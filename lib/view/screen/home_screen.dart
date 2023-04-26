import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart' as uuid;

import '../../controller/task_controller.dart';
import '../../model/task_model.dart';
import '../widget/container_use_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<TaskModel> taskList = [];

  final TextEditingController _taskNameController = TextEditingController();

  final TextEditingController _priorityController = TextEditingController();
  final TaskController _taskController = TaskController();

  bool isIntialized = false;

  @override
  void initState() {
    super.initState();
  }

  void _addTask(TaskModel task) {
    taskList.add(task);
    setState(() {});
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    _priorityController.dispose();
    super.dispose();
  }

  void _showAddTaskDialog() {
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetAnimationCurve: Curves.bounceInOut,
          insetAnimationDuration: const Duration(seconds: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Form(
            child: Container(
              height: 300.0,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _taskNameController,
                    decoration: const InputDecoration(
                      hintText: 'Task Name',
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  OutlinedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null && picked != selectedDate) {
                        setState(() {
                          selectedDate = picked;
                        });
                      }
                    },
                    child: Text(
                        'Select Date: ${DateFormat('dd/MM/yyyy').format(selectedDate)}'),
                  ),
                  const SizedBox(height: 20.0),
                  OutlinedButton(
                    onPressed: () async {
                      final TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(selectedDate),
                      );
                      if (picked != null) {
                        setState(() {
                          selectedDate = DateTime(
                              selectedDate.year,
                              selectedDate.month,
                              selectedDate.day,
                              picked.hour,
                              picked.minute);
                        });
                      }
                    },
                    child: Text(
                        'Select Time: ${DateFormat('hh:mm a').format(selectedDate)}'),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: _priorityController,
                    decoration: const InputDecoration(
                      hintText: 'Priority',
                    ),
                    onFieldSubmitted: (value) {
                      _addTask(
                        TaskModel(
                          taskName: _taskNameController.text,
                          timeNeeded: selectedDate,
                          priority: _priorityController.text,
                          isCompleted: false,
                          id: const uuid.Uuid().v4(),
                        ),
                      );
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Task List'),
        ),
        body: StreamBuilder(
          stream: _taskController.getTaskList(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Scaffold(
                  body: Center(
                    child: Text("Error!"),
                  ),
                );
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );

              case ConnectionState.active:
                return ListView.builder(
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return ContainerUseWidget(
                      title: taskList[index].taskName,
                      priority: taskList[index].priority,
                      date: taskList[index].timeNeeded.toString(),
                      isCompleted: taskList[index].isCompleted,
                    );
                  },
                );
              case ConnectionState.done:
                return const Scaffold(
                  body: Center(
                    child: Text("Error! With Done"),
                  ),
                );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddTaskDialog(),
          tooltip: 'Add Task',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
