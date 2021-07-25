import 'package:flutter/material.dart';
import 'package:todo_list/models/tasks_data.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

String newTaskTitle = "";
int timeStamp =0;

class AddTaskScreen extends StatelessWidget {
  var ref= FirebaseDatabase.instance.reference().child('Tasks');

  int timeCheck(){
    timeStamp= DateTime.now().millisecondsSinceEpoch;
    return timeStamp;
  }


  @override
  Widget build(BuildContext context) {

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
                timeCheck();
                print('$timeStamp');
                ref.child('$timeStamp').update({
                  'Task Name':newTaskTitle,
                  'Status': false,
                });

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
