import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class TaskTile extends StatelessWidget {


  @override

  final bool isChecked ;
  final String taskTitle;
  final  checkboxCallback;
  final longPressCallback;

  TaskTile({ required this.isChecked,required this.taskTitle,required this.checkboxCallback,required this.longPressCallback}):assert(isChecked!= null);


  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:  Checkbox(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        value: isChecked,
        activeColor: Colors.lightBlueAccent,
        onChanged: checkboxCallback,
        // onChanged: (value) {
        //   toggleCheckboxState(value);
        // },
      ),
      onLongPress: longPressCallback,
      title: Text(taskTitle,
          style: TextStyle(
              decoration: isChecked ? TextDecoration.lineThrough : null)),
      // trailing: Checkbox(
      //   value: isChecked,
      //   activeColor: Colors.lightBlueAccent,
      //   onChanged: checkboxCallback,
      //   // onChanged: (value) {
      //   //   toggleCheckboxState(value);
      //   // },
      // ),
    );
  }
}



