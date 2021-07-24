import 'package:flutter/material.dart';
import 'task_tile.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/models/tasks_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';


class TaskList extends StatelessWidget {
  var dbref =FirebaseDatabase.instance.reference().child('Task');



  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(builder: (context,taskData,child){
      return ListView.builder(
        itemBuilder: (context, index) {
          final task= taskData.tasks[index];
          return TaskTile(
              isChecked: task.isDone,
              taskTitle: task.name,
              checkboxCallback:( checkboxState) {
                task.isDone?
                dbref.update({
                  'Value': false,
                }):dbref.update({
                  'Value': true,
                });

                taskData.updateTask(task);},
                longPressCallback: (){
                taskData.deleteTask(task);
          },

          );
        },
        itemCount: taskData.taskCount,
      );
    },

    );
  }
}
