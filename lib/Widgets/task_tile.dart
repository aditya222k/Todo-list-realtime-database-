import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class TaskTile extends StatefulWidget {
  @override

  final bool isChecked ;
  final String taskTitle;
  final  checkboxCallback;
  final longPressCallback;

  TaskTile({ required this.isChecked,required this.taskTitle,required this.checkboxCallback,required this.longPressCallback}):assert(isChecked!= null);

  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  var dbref =FirebaseDatabase.instance.reference().child('Task');

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: widget.longPressCallback,
      title: Text(widget.taskTitle,
          style: TextStyle(
              decoration: widget.isChecked ? TextDecoration.lineThrough : null)),
      trailing: Checkbox(
        value: widget.isChecked,
        activeColor: Colors.lightBlueAccent,
        onChanged: widget.checkboxCallback,
        // onChanged: (value) {
        //   toggleCheckboxState(value);
        // },
      ),
    );
  }
}



