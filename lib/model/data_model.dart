import 'package:hive_flutter/adapters.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class ToDoModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String todoName;
  @HiveField(2)
  final String todoSubName;
  @HiveField(3)
  final bool complete;
  ToDoModel({
    required this.todoName,
    required this.todoSubName,
    required this.complete,
    this.id,
  });
}
