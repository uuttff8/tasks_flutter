import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks_flutter/strings.dart';
import 'package:tasks_flutter/ui/core_ui/dots_indicator.dart';
import 'package:tasks_flutter/ui/core_ui/exts.dart';
import 'package:tasks_flutter/ui/core_ui/spacing.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:tasks_flutter/model/task.dart';
import 'task_list.dart';

enum Pages { Tasks, ListOfTasks }

class TasksPageWidgets extends StatefulWidget {
  TasksPageWidgets({Key key}) : super(key: key);

  @override
  _TasksPageWidgetsState createState() => _TasksPageWidgetsState();
}

class _TasksPageWidgetsState extends State<TasksPageWidgets> {
  final PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        PageView.builder(
          physics: ClampingScrollPhysics(),
          onPageChanged: _pageChanged,
          controller: controller,
          itemCount: 2,
          itemBuilder: (context, index) {
            Pages element = Pages.values.elementAt(index);
            switch (element) {
              case Pages.Tasks:
                return FirstTasks();
              case Pages.ListOfTasks:
                return SecondTasks();
            }
            return null;
          },
        ),
        Padding(
          padding: EdgeInsets.only(top: 100),
          child: Indicator(
            controller: controller,
            itemCount: 2,
          ),
        ),
      ],
    );
  }

  void _pageChanged(int index) {
    setState(() {});
  }
}

class SecondTasks extends StatelessWidget {
  const SecondTasks({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TasksPage(
      text: "Task lists",
      child: ListView.separated(
        padding: const EdgeInsets.all(0.0),
        itemBuilder: (BuildContext context, int index) {
          return Text(
            'iteaaaaaaam $index',
            style: TextStyle(color: Colors.white),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(height: 1, color: CupertinoColors.white);
        },
        itemCount: 12,
      ),
    );
  }
}

class FirstTasks extends StatelessWidget {
  const FirstTasks({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TasksPage(
      text: "Tasks",
      child: ValueListenableBuilder(
        valueListenable: Hive.box<TaskHive>(hiveTasks).listenable(),
        builder: (context, Box<TaskHive> box, widget) {
          Iterable tasks = box.values;

          if (tasks.isEmpty) {
            return Center(child: Text("No Values"));
          }

          return TaskList(box: box);
        },
      ),
    );
  }
}

class TasksPage extends StatelessWidget {
  const TasksPage({
    Key key,
    @required this.child,
    @required this.text,
  }) : super(key: key);

  final Widget child;
  final String text;

  @override
  Widget build(BuildContext context) {
    final double listTopPadding = 4;
    final double listViewHeight =
        MediaQuery.of(context).size.height - 194 - listTopPadding;

    return Container(
      color: TasksColors.mainBlack,
      child: Padding(
        padding: EdgeInsets.only(
          top: 50,
          left: 16.0,
          right: 16.0,
          bottom: 0.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  this.text,
                  style: TextStyle(fontSize: 32, color: Colors.white),
                ),
                InkWell(
                  child: Icon(
                    Icons.search,
                    color: TasksColors.iconWhite,
                  ),
                  onTap: () {
                    // TODO: Implement searching
                  },
                )
              ],
            ),
            Spacing(height: 24),
            Padding(
              padding: EdgeInsets.only(top: listTopPadding),
              child: SizedBox(
                height: listViewHeight,
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
