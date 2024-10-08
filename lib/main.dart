import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'exercises.dart';
import 'reps.dart';

final dataProvider = StateProvider<List<String>>((ref) => exerciseList); //["chinup", "pullup", "dip"]);

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => HomeScreen()),
    GoRoute(path: '/createnewexercise', builder: (context, state) => CreateNewExerciseScreen()),
    GoRoute(path: '/createtrainingsession', 
            builder: (context, state) => CreateTrainingSessionScreen()),
    GoRoute(path: '/summary', builder: (context, state) => EndTrainingScreen()),
  ],
);

main() {
  runApp(ProviderScope(child: MaterialApp.router(routerConfig: router)));
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final exerciseDIPstraightBar = Exercise("DIP straight bar", []);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Center(child: Text("Calisthenics App")),
        ),
        body: Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => context.go("/createnewexercise"),
                      child: const Text("Create a new exercise"),
                    ),
                    ElevatedButton(
                      onPressed: () => context.go("/createtrainingsession"),
                      child: const Text("Create training session"),
                    ),
                    ElevatedButton(
                      onPressed: () => context.go("/summary"),
                      child: const Text("End training session"),
                    ),
                  ],
                ),
                const Text("EXERCISES", style: TextStyle(fontSize: 32)),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [const Text("CHINUP close grip"), ChinupWidget()],),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [const Text("PULLUP close grip"), PullupWidget()],),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(exerciseDIPstraightBar.name)],),
                //const Text("PULLUP wide grip"),
                //const Text("DIP bar 1", textAlign: TextAlign.left),
                //const Text("DIP bar 2"),
                ListWidget(),
                AddButton(),
                const OutlinedButton(
                  onPressed: null,
                  child: Text("Add exercise")
                ),
    ]));
  }
}

class AddButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () => ref
          .watch(dataProvider.notifier)
          .update((state) => [...state, 'A new exercise']),
      child: const Text('Add a new exercise'),
    );
  }
}

class ListWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> data = ref.watch(dataProvider);
    return Column(children: data.map((e) => Text(e)).toList());
  }
}

class ChinupWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int chinupReps1 = ref.watch(chinupProvider1);
    final int chinupReps2 = ref.watch(chinupProvider2);
    final int chinupReps3 = ref.watch(chinupProvider3);
    //return Text("chinupReps: $chinupReps");
    return Row(children:
      [ElevatedButton(onPressed: () => ref.watch(chinupProvider1.notifier).update((state) => state += 1), child: Text('$chinupReps1')),
       ElevatedButton(onPressed: () => ref.watch(chinupProvider2.notifier).update((state) => state += 1), child: Text('$chinupReps2')),
       ElevatedButton(onPressed: () => ref.watch(chinupProvider3.notifier).update((state) => state += 1), child: Text('$chinupReps3')),
      ]);
  }
}

class PullupWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int pullupReps1 = ref.watch(pullupProvider1);
    final int pullupReps2 = ref.watch(pullupProvider2);
    final int pullupReps3 = ref.watch(pullupProvider3);
    //return Text("chinupReps: $chinupReps");
    return Row(children:
      [ElevatedButton(onPressed: () => ref.watch(pullupProvider1.notifier).update((state) => state += 1), child: Text('$pullupReps1')),
       ElevatedButton(onPressed: () => ref.watch(pullupProvider2.notifier).update((state) => state += 1), child: Text('$pullupReps2')),
       ElevatedButton(onPressed: () => ref.watch(pullupProvider3.notifier).update((state) => state += 1), child: Text('$pullupReps3')),
      ]);
  }
}



// screens
class CreateNewExerciseScreen extends StatelessWidget {
  addNewExercise() {
    print("adding new exercise");
    String newEx = "new ex";
    exerciseList.add(newEx);
  }
  @override
  Widget build(BuildContext context) {
    final exerciseDIP = Exercise("DIP", [dipProvider1]);  // using class Exercise below
    final newExerciseField = SizedBox(
      width: 250, 
      child: TextFormField(decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'exercise name...',
        isDense: true, 
        contentPadding: EdgeInsets.all(10),
      ))
    );
    final exerciseForm = Form(child: newExerciseField);
    final addExerciseButton = ElevatedButton(
      onPressed: addNewExercise,
      child: const Text('Add'),
    );
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Center(child: Text("Calisthenics App")),
        ),
        body: Center(
            child: Column(children: [
              const Text("This screen is for creating new exercises"),
              const Text("Existing exercises:"),
              Text(exerciseList[0]),  //data.map((e) => Text(e)).toList()
              Text(exerciseList[1]),
              exerciseList.length > 2 ? Text(exerciseList[2]) : const Text(""),
              exerciseList.length > 3 ? Text(exerciseList[3]) : const Text(""),
              Text(exerciseDIP.name),  // displays exercise name
              // create input field and add button
              exerciseForm,
              addExerciseButton,
              ElevatedButton(
                onPressed: () => context.go("/"),
                child: const Text("Return to main screen"),
              ),
    ])));
  }
}

class Exercise {
  String name;
  List<dynamic>reps;
  Exercise(this.name, this.reps);
}

class CreateTrainingSessionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Center(child: Text("Calisthenics App")),
        ),
        body: Center(
            child: Column(children: [
              const Text("This screen is for creating an exercise session"),
              ElevatedButton(
                onPressed: () => context.go("/"),
                child: const Text("Return to main screen"),
              ),
    ])));
  }
}

class EndTrainingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Center(child: Text("Calisthenics App")),
        ),
        body: Center(
            child: Column(children: [
              const Text("This screen is for overviewing completed exercises of a training session"),
              ElevatedButton(
                onPressed: () => context.go("/"),
                child: const Text("Return to main screen"),
              ),
    ])));
  }
}


/*
void main() {
  runApp(const CalisthenicsApp());
}

class CalisthenicsApp extends StatelessWidget {
  const CalisthenicsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calisthenics App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Exercise Program'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _createNewExercise() {
    setState(() {
      // AddExerciseScreen, creating a new exercise
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Column(
          children: <Widget>[
            Text('Chin up'),
            Text('Pull up', textAlign: TextAlign.left),
            Text('Push up'),
            ElevatedButton(onPressed: null, child: Text('Add')),
          ],
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewExercise,
        tooltip: 'Create a new exercise',
        child: const Icon(Icons.add),
      ),
    );
  }
}
*/