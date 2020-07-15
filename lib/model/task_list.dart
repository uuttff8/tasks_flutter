import 'package:hive/hive.dart';
import 'task.dart';

part 'task_list.g.dart';

@HiveType(typeId: 1)
class TaskListHive extends HiveObject {
  TaskListHive({this.name, this.tasks});

  @HiveField(0)
  String name;

  @HiveField(1)
  List<TaskHive> tasks;
}
