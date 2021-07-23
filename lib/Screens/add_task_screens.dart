import 'package:flutter/material.dart';
import 'package:todo_list/models/tasks_data.dart';
import 'package:provider/provider.dart';

class AddTaskScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    String newTaskTitle = "";

    return Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
                child: Text(
              'Add Task',
              style: TextStyle(color: Colors.lightBlueAccent, fontSize: 30),
            )),
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (newText) {
                newTaskTitle = newText;
                }
            ),
            MaterialButton(
              onPressed: () {
                Provider.of<TaskData>(context,listen:false).addTask(newTaskTitle);
                Navigator.pop(context);
              },
              color: Colors.lightBlueAccent,
              child: Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ));
  }
}
