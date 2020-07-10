import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class TaskHive extends HiveObject {
  TaskHive({this.name, this.description});

  @HiveField(0)
  String name;

  @HiveField(1)
  String description;
}
