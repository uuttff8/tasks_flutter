import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks_flutter/model/task_list.dart';
import 'package:tasks_flutter/ui/core_ui/exts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../strings.dart' as str;

class TasksSettings extends StatelessWidget {
  const TasksSettings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      color: TasksColors.newTask,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SortingTaskList(),
          _Separator(),
          _SettingsTaskLists(),
          _Separator(),
          _SettingsDoneTasks(),
        ],
      ),
    );
  }
}

class _Separator extends StatelessWidget {
  const _Separator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
        child: Container(
          height: 2.0,
          width: 100,
          color: Colors.yellow,
        ),
      ),
    );
  }
}

class _SortingTaskList extends StatelessWidget {
  const _SortingTaskList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Sort By",
                style: TextStyle(fontSize: 18, color: TasksColors.textColor),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 8.0),
                    Text(
                      "Done time",
                      style: TextStyle(
                        fontSize: 16,
                        color: TasksColors.description_text,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      "Date",
                      style: TextStyle(
                        fontSize: 16,
                        color: TasksColors.description_text,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
        ],
      ),
    );
  }
}

class _SettingsTaskLists extends StatelessWidget {
  const _SettingsTaskLists({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 158,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Task Lists",
              style: TextStyle(fontSize: 18, color: TasksColors.textColor),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 16.0),
              child: _TaskListsSettings(),
            )
          ],
        ),
      ),
    );
  }
}

class _TaskListsSettings extends StatelessWidget {
  const _TaskListsSettings({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _createListDialog() {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text("Name your new task list"),
            content: Column(
              children: <Widget>[
                SizedBox(height: 16),
                CupertinoTextField(),
              ],
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text("Cancel"),
                isDestructiveAction: true,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              CupertinoDialogAction(
                child: Text("Create"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    void _createListSettingsDialog(int index, Box<TaskListHive> box) {
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            actions: <Widget>[
              CupertinoActionSheetAction(
                isDestructiveAction: true,
                child: Text("Delete"),
                onPressed: () {
                  box.deleteAt(index);
                  Navigator.pop(context);
                },
              )
            ],
          );
        },
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 65,
          child: ValueListenableBuilder(
            valueListenable:
                Hive.box<TaskListHive>(str.hiveTaskLists).listenable(),
            builder:
                (BuildContext context, Box<TaskListHive> box, Widget widget) {
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  TaskListHive list = box.values.elementAt(index);
                  return Padding(
                    padding: const EdgeInsets.only(top: 4.0, right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${list.name}",
                          style: TextStyle(
                            color: TasksColors.description_text,
                          ),
                        ),
                        InkWell(
                          child: Icon(
                            Icons.more_horiz,
                            color: TasksColors.description_text,
                          ),
                          onTap: () {
                            _createListSettingsDialog(index, box);
                          },
                        )
                      ],
                    ),
                  );
                },
                itemCount: box.values.length,
              );
            },
          ),
        ),
        InkWell(
          onTap: _createListDialog,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Create List",
                    style: TextStyle(
                      color: TasksColors.description_text,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: InkWell(
                    child: Icon(
                      Icons.add,
                      color: TasksColors.description_text,
                      size: 20,
                    ),
                    onTap: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SettingsDoneTasks extends StatelessWidget {
  const _SettingsDoneTasks({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Done Tasks",
              style: TextStyle(fontSize: 18, color: TasksColors.textColor),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: CupertinoButton(
                child: Text(
                  "Delete done tasks",
                  style: TextStyle(
                    color: Colors.yellow,
                  ),
                ),
                onPressed: () {
                  // tasks settings should be dissmised
                  Navigator.pop<bool>(context);

                  showCupertinoDialog<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      return CupertinoAlertDialog(
                        title: Text("Delete done tasks?"),
                        content: Text(
                            "All done tasks will be deleted without the ability to remove"),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            child: Text('Cancel'),
                            isDestructiveAction: true,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          CupertinoDialogAction(
                            child: Text('Continue'),
                            onPressed: () {
                              Navigator.of(context).pop();
                              BotToast.showText(
                                text: "Done tasks deleted",
                                contentColor: TasksColors.toast_color,
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
