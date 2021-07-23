import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/Screens/task_screen.dart';
import 'models/tasks_data.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context)=>TaskData(),
      // builder: (context)=>TaskData(),
      child: MaterialApp(
        home: TasksScreen(),
      ),
    );
  }
}
