import 'package:flutter/material.dart';


class AddTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        Center(child: Text('Add Task',style: TextStyle(color: Colors.lightBlueAccent,fontSize: 30),)),
        TextField(autofocus: true,
        textAlign: TextAlign.center,
        ),
        MaterialButton(onPressed: (){},color: Colors.lightBlueAccent,
          child: Text('Add',style: TextStyle(color: Colors.white),),
        )
      ],)
    );
  }
}
