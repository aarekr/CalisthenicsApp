import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => HomeScreen()),
    GoRoute(path: '/createtrainingsession', 
            builder: (context, state) => CreateTrainingSessionScreen()),
    GoRoute(path: '/summary', builder: (context, state) => SummaryScreen()),
  ],
);

main() {
  runApp(MaterialApp.router(routerConfig: router));
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
                const Text("Chinup"),
                const Text("Pullup"),
                const Text("Dip"),
                OutlinedButton(
                  onPressed: () => print("adding an exercise"),
                  child: const Text("Add exercise")),
                ElevatedButton(
                  onPressed: () => context.go("/createtrainingsession"),
                  child: const Text("Create daily exercise plan"),
                ),
                ElevatedButton(
                  onPressed: () => context.go("/summary"),
                  child: const Text("End training session"),
                ),
    ]));
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