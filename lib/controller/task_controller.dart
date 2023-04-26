import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/task_model.dart';

class TaskController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference _taskCollection =
      FirebaseFirestore.instance.collection('tasks');

  Future<String> addTask(TaskModel task) async {
    String result = "Unsuccessful";
    try {
      await _taskCollection.add(task.toMap());
      result = "Successful";
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  Future<String> updateTask(TaskModel task) async {
    String result = "Unsuccessful";
    try {
      await _taskCollection.doc(task.taskName).update(task.toMap());
      result = "Successful";
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  Future<String> deleteTask(TaskModel task) async {
    String result = "Unsuccessful";
    try {
      await _taskCollection.doc(task.taskName).delete();
      result = "Successful";
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  Stream<List<TaskModel>> getTaskList() {
    return _taskCollection.snapshots().map((QuerySnapshot querySnapshot) {
      List<TaskModel> taskList = [];
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
        if (data != null) {
          taskList.add(TaskModel.fromMap(data));
        }
      }
      return taskList;
    });
  }
}
