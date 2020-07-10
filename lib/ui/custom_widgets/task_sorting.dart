import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks_flutter/ui/core_ui/exts.dart';

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
    void _createListDialog() {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            content: Column(
              children: <Widget>[
                Text(
                  "Name your new task list",
                  style: TextStyle(fontSize: 16),
                ),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 65,
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            "123123",
                            style: TextStyle(
                              color: TasksColors.description_text,
                            ),
                          ),
                        );
                      },
                      itemCount: 3,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 8,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: InkWell(
                            child: Text(
                              "Create List",
                              style: TextStyle(
                                color: TasksColors.description_text,
                              ),
                            ),
                            onTap: _createListDialog,
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
                  )
                ],
              ),
            )
          ],
        ),
      ),
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
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
