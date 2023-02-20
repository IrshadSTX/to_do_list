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
  ToDoModel({
    required this.todoName,
    required this.todoSubName,
    this.id,
  });
}
