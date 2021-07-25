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
  var dbref = FirebaseDatabase.instance.reference();
  List list = [];


  // List title = [];
  final databaseRef = FirebaseDatabase.instance.reference().child('Task');

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
          future: databaseRef.once(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {

              if (snapshot.data.value != null) {
                print(snapshot.data.value);
                list.clear();

                Map<dynamic, dynamic> values = snapshot.data.value;
                values.forEach((key, value) {
                  list.add(key);
                });
                // print(list);
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    // list[index];
                    // print(snapshot.data.value);
                    // var data = snapshot.data.value[];
                    final task = taskData.tasks[index];
                    // return TaskTile(
                    //   isChecked: task.isDone,
                    //   taskTitle: task.name,
                    //   checkboxCallback: (checkboxState) {
                    //     task.isDone
                    //         ? databaseRef.child('${list[index]}').update({
                    //       'Value': false,
                    //     })
                    //         : databaseRef.child('${list[index]}').update({
                    //       'Value': true,
                    //     });
                    //
                    //     taskData.updateTask(task);
                    //   },
                    //   longPressCallback: () {
                    //     taskData.deleteTask(task);
                    //     dbref.child('$task').remove();
                    //   },
                    // );
                    return FutureBuilder(
                      future: databaseRef.child("${list[index]}").once(),
                      builder: (BuildContext cnt, AsyncSnapshot snap) {
                        if(snap.connectionState == ConnectionState.done){
                        if(snap.data.value != null){
                          List listItem = [];
                          String title = snap.data.value['Title'];
                          bool check = snap.data.value['Value'];
                          // print(snap.data.value['Title']);
                          // print(snap.data.value['Value']);

                          // listItem = snap.data.value['Title'];
                          // Map<dynamic, dynamic> taskvalue = snap.data.value;
                          // taskvalue.forEach((key, value) {
                          //   title.add(key);
                          // });
                          // print(title);
                          return TaskTile(
                              isChecked: check,
                              taskTitle: title,
                              checkboxCallback: (checkboxState) {
                                setState(() {
                                  taskData.updateTask(task);
                                  task.isDone
                                      ? databaseRef.child('${list[index]}').update({
                                    'Value': true,
                                  })
                                      : databaseRef.child('${list[index]}').update({
                                    'Value': false,
                                  });
                                });

                              },
                              longPressCallback: () {
                                taskData.deleteTask(task);
                                databaseRef.child('${list[index]}').remove();
                              });

                        }else{
                          return Center(child: Text('no Data'));
                        }

                      }else{
                          return Container();

                        }
                        // String title = snap.data.value['Title'];

                      },
                    );
                  },
                  itemCount: list.length,
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        );
      },
    );
  }
}
