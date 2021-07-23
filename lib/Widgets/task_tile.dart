import 'package:flutter/material.dart';

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
      onLongPress: longPressCallback,
      title: Text(taskTitle,
          style: TextStyle(
              decoration: isChecked ? TextDecoration.lineThrough : null)),
      trailing: Checkbox(
        value: isChecked,
        activeColor: Colors.lightBlueAccent,
        onChanged: checkboxCallback,
        // onChanged: (value) {
        //   toggleCheckboxState(value);
        // },
      ),
    );
  }
}



