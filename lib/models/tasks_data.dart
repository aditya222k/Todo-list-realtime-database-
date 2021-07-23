import 'package:flutter/material.dart';
import 'task.dart';

class TaskData extends ChangeNotifier{

  List<Task> tasks = [
    Task(name: 'buy Milk'),
    Task(name: 'buy egg'),
    Task(name: 'buy lasan'),
  ];


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
    notifyListeners();
  }

}