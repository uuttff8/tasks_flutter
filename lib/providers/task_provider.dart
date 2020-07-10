import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tasks_flutter/strings.dart' as str;
import 'package:tasks_flutter/model/task.dart';

class TasksTakerProvider with ChangeNotifier, DiagnosticableTreeMixin {
  void addNewTask(String name, String description) {
    Box box = Hive.box(str.hiveTasks);

    List prevTasks = box.get("tasks", defaultValue: []);
    prevTasks.add(TaskHive(name: name, description: description));
    box.add(prevTasks);
  }
}
