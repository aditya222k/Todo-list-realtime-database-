import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'task_tile.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/models/tasks_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List list = [];

  // List title = [];
  final ref = FirebaseDatabase.instance.reference().child('Tasks');

  // getList() async {
  //   databaseRef.once().then((DataSnapshot snapshot) {
  //     // print('Data : ${snapshot.value}');
  //   });
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return FutureBuilder(
            future: ref.once(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data.value != null) {
                  list.clear();
                  Map<dynamic, dynamic> values = snapshot.data.value;
                  values.forEach((key, value) {
                    list.add(key);
                  });
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final task = taskData.tasks[index];
                      return FutureBuilder(
                          future: ref.child('${list[index]}').once(),
                          builder: (BuildContext cont, AsyncSnapshot snap) {
                            if (snap.connectionState == ConnectionState.done) {
                              if (snap.data.value != null) {
                                String title = snap.data.value['Task Name'];
                                bool check = snap.data.value['Status'];

                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white, //background color of box
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          blurRadius: 25.0, // soften the shadow
                                          spreadRadius: 5.0, //extend the shadow
                                          // offset: Offset(
                                          //   15.0, // Move to right 10  horizontally
                                          //   15.0, // Move to bottom 10 Vertically
                                          // ),
                                        )
                                      ],
                                    ),
                                    child: TaskTile(
                                      taskTitle: title,
                                      isChecked: check,
                                      checkboxCallback: (checkboxState) {

                                        taskData.updateTask(task);
                                        if(task.isDone){
                                          ref.child('${list[index]}').update({
                                            'Status':true
                                          });
                                        }else{
                                          ref.child('${list[index]}').update({
                                            'Status':false
                                          });
                                        }
                                      },
                                      longPressCallback: () {
                                        ref.child('${list[index]}').remove();
                                        taskData.deleteTask(task);
                                      },
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            } else {
                              return Container();
                            }
                          });
                    },
                    itemCount: taskData.taskCount,
                  );
                }else{
                  return Container();
                    Center(child: CircularProgressIndicator());

                }
              } else {
                return Container();
              } //if 1
            });
      },
    );
  }
}
