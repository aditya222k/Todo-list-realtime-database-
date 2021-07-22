import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {


  @override

  final bool isChecked ;
  final String taskTitle;
  final  checkboxCallback;

  TaskTile({required this.isChecked,required this.taskTitle,required this.checkboxCallback});


  @override
  Widget build(BuildContext context) {
    return ListTile(
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



