import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/Widgets/tasks_list.dart';
import 'add_task_screens.dart';
import 'package:todo_list/models/tasks_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_list/Widgets/task_tile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

// var dbref = FirebaseDatabase.instance.reference();


// List title = [];
final databaseRef = FirebaseDatabase.instance.reference().child('Task');

class TasksScreen extends StatefulWidget {



  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(23),
                    topLeft: Radius.circular(23))),
            builder: (context) => AddTaskScreen(),
          );
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 60, left: 30, right: 30, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  child: Icon(
                    Icons.list,
                    size: 30,
                    color: Colors.lightBlueAccent,
                  ),
                  backgroundColor: Colors.white,
                  radius: 30,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Todo',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  '${Provider.of<TaskData>(context).taskCount} Tasks left',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Consumer<TaskData>(
                builder: (context, taskData, child) {
                  return FutureBuilder(
                    future: databaseRef.once(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        List list = [];

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
              ),
            ),
          )
        ],
      ),
    );
  }
}
