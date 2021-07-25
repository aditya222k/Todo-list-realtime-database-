import 'package:flutter/material.dart';
import 'package:todo_list/models/tasks_data.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

String newTaskTitle = "";
int timeStamp=0;

int timecheck() {
  timeStamp = DateTime.now().millisecondsSinceEpoch;
  return timeStamp ;
}

class AddTaskScreen extends StatelessWidget {
  var dbref =FirebaseDatabase.instance.reference().child('Task');



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
                timecheck();
                print(timeStamp);
                dbref.child('$timeStamp').update({
                  'Title': newTaskTitle,
                  'Value': false,
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
