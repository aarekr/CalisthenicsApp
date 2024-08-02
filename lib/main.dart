import 'package:flutter/material.dart';

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
