import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  List<String> taskList = [];

  void _addTask(String task) {
    setState(() {
      taskList.add(task);
    });
  }

  void _showAddTaskBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: 200.0,
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Task Name',
                  ),
                  onSubmitted: (value) {
                    _addTask(value);
                    Navigator.pop(context);
                  },
                ),
                const TextField(
                  decoration: InputDecoration(
                    hintText: 'Date and Time',
                  ),
                ),
                const TextField(
                  decoration: InputDecoration(
                    hintText: 'Priority',
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
      ),
      body: ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(taskList[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskBottomSheet(),
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
