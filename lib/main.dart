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
    GoRoute(path: '/summary', builder: (context, state) => SummaryScreen()),
  ],
);

main() {
  runApp(ProviderScope(child: MaterialApp.router(routerConfig: router)));
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
                Row(children: [const Text("CHINUP close grip"), ChinupWidget()],),
                Row(children: [const Text("PULLUP close grip"), PullupWidget()],),
                //const Text("PULLUP wide grip"),
                //const Text("DIP bar 1", textAlign: TextAlign.left),
                //const Text("DIP bar 2"),
                OutlinedButton(
                  onPressed: () => print("adding an exercise"),
                  child: const Text("Add exercise")),
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
                ListWidget(),
                AddButton(),
                //Row(children: [ChinupWidget()]),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(children: [
              const Text("This screen is for creating new exercises"),
              ElevatedButton(
                onPressed: () => context.go("/"),
                child: const Text("Return to main screen"),
              ),
    ])));
  }
}

class CreateTrainingSessionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

class SummaryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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