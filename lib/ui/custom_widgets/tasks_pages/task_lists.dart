import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:tasks_flutter/model/task_list.dart';
import 'package:tasks_flutter/ui/core_ui/exts.dart';

class TaskListsSecond extends StatelessWidget {
  const TaskListsSecond({
    Key key,
    @required this.box,
  }) : super(key: key);

  final Box<TaskListHive> box;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(0.0),
      itemBuilder: (BuildContext context, int index) {
        TaskListHive currentTaskLists = box.values.elementAt(index);

        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${currentTaskLists.name}',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              if (currentTaskLists.tasks.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: currentTaskLists.tasks
                            .map(
                              (task) => Text(
                                "${task.name}",
                                style: TextStyle(
                                  color: TasksColors.description_text,
                                  fontSize: 16,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 0.0),
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 8,
                        child: Text(
                          "Add Task",
                          style: TextStyle(
                            color: TasksColors.newTask,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.add,
                          color: TasksColors.newTask,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 4.0),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                child: Container(
                  height: 2.0,
                  width: MediaQuery.of(context).size.width / 6.0,
                  color: TasksColors.newTask,
                ),
              )
            ],
          ),
        );
      },
      itemCount: box.values.length,
    );
  }
}
