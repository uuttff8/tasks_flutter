import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:tasks_flutter/model/task.dart';
import 'package:tasks_flutter/ui/core_ui/exts.dart';

class TaskListFirst extends StatelessWidget {
  const TaskListFirst({
    Key key,
    @required this.box,
  }) : super(key: key);

  final Box<TaskHive> box;

  @override
  Widget build(BuildContext context) {
    final tasks = box.values;
    return ListView.separated(
      padding: const EdgeInsets.all(0.0),
      itemBuilder: (BuildContext context, int index) {
        TaskHive currentTask = tasks.elementAt(index);

        return TaskListCell(currentTask: currentTask, box: box, index: index);
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(height: 1, color: CupertinoColors.white);
      },
      itemCount: tasks.length,
    );
  }
}

class TaskListCell extends StatelessWidget {
  const TaskListCell({
    Key key,
    @required this.currentTask,
    @required this.box,
    @required this.index,
  }) : super(key: key);

  final TaskHive currentTask;
  final Box<TaskHive> box;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MaterialButton(
            onPressed: () {},
            padding: EdgeInsets.zero,
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                border: Border.all(color: TasksColors.toast_color),
                shape: BoxShape.circle,
              ),
            ),
            splashColor: Colors.transparent,
            minWidth: 0,
            shape: CircleBorder(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 14.0),
            child: Text(
              '${currentTask.name} - ${currentTask.description}',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              Icons.more_horiz,
              color: TasksColors.iconWhite,
            ),
            onPressed: () {
              showCupertinoModalPopup(
                context: context,
                builder: (BuildContext context) {
                  return Builder(builder: (BuildContext context) {
                    return CupertinoActionSheet(
                      actions: <Widget>[
                        CupertinoActionSheetAction(
                          child: Text(
                            "Delete",
                          ),
                          onPressed: () {
                            box.deleteAt(index);
                            Navigator.of(context).pop();
                          },
                          isDestructiveAction: true,
                        )
                      ],
                    );
                  });
                },
              );
            },
          )
        ],
      ),
    );
  }
}
