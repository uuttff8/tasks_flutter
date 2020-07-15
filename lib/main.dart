import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tasks_flutter/model/task.dart';
import 'package:tasks_flutter/model/task_list.dart';
import 'package:tasks_flutter/ui/custom_widgets/tasks_toolbar.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'strings.dart' as str;

import 'package:tasks_flutter/providers/task_provider.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(TaskHiveAdapter());
  Hive.registerAdapter(TaskListHiveAdapter());

  await Hive.openBox<TaskHive>(str.hiveTasks);
  await Hive.openBox<TaskListHive>(str.hiveTaskLists);

  // Hive.box<TaskListHive>(str.hiveTaskLists).add(TaskListHive(
  //     name: "Work",
  //     tasks: [TaskHive(name: "asdasd", description: "123123019283")]));

  runApp(TasksFlutter());
}

class TasksApp extends StatelessWidget {
  const TasksApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => TasksTakerProvider(),
      builder: (context, widget) {
        return TasksFlutter();
      },
    );
  }
}

class TasksFlutter extends StatelessWidget {
  const TasksFlutter({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      debugShowCheckedModeBanner: false,
      // showSemanticsDebugger: true,
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          body: TabbedWidgets(),
        ),
      ),
    );
  }
}
