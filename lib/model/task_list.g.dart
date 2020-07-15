// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskListHiveAdapter extends TypeAdapter<TaskListHive> {
  @override
  final typeId = 1;

  @override
  TaskListHive read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskListHive(
      name: fields[0] as String,
      tasks: (fields[1] as List)?.cast<TaskHive>(),
    );
  }

  @override
  void write(BinaryWriter writer, TaskListHive obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.tasks);
  }
}
