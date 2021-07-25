import 'package:flutter/material.dart';
import 'task.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';


class TaskData extends ChangeNotifier{

  List<Task> tasks = [];

  var dbRef = FirebaseDatabase.instance.reference().child('Task');

  int get taskCount{
    return tasks.length;
  }

  void addTask(String newTaskTle){
    final task = Task(name: newTaskTle);
    tasks.add(task);
    notifyListeners();
  }

  void updateTask(Task task){
    task.toggleDone();
    notifyListeners();
  }

  void deleteTask(Task task){
    tasks.remove(task);
    print(task);
    notifyListeners();
  }

}