import 'package:flutter/material.dart';

class TaskTile extends StatefulWidget {
  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool isChecked = false;

  void checkboxCallback(bool checkboxState) {
    setState(() {
      isChecked = checkboxState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('this a task',
          style: TextStyle(
              decoration: isChecked ? TextDecoration.lineThrough : null)),
      trailing: TaskCheckbox(
          checkboxState: isChecked, toggleCheckboxState: checkboxCallback),
    );
  }
}

class TaskCheckbox extends StatelessWidget {
  final Function toggleCheckboxState;
  final bool checkboxState;

  TaskCheckbox({required this.checkboxState,  required this.toggleCheckboxState});

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: checkboxState,
      activeColor: Colors.lightBlueAccent,
      onChanged: (value) {
        toggleCheckboxState(value);
      },
    );
  }
}
