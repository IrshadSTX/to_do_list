import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list/model/data_model.dart';

ValueNotifier<List<ToDoModel>> todoListNotifier = ValueNotifier([]);

Future<void> addToDo(ToDoModel value) async {
  final todoDB = await Hive.openBox<ToDoModel>('todo_db');
  final ids = await todoDB.add(value);
  value.id = ids;
  todoListNotifier.value.add(value);
  todoListNotifier.notifyListeners();
  getAllToDo();
}

Future<void> getAllToDo() async {
  final todoDB = await Hive.openBox<ToDoModel>('todo_db');
  todoListNotifier.value.clear();
  todoListNotifier.value.addAll(todoDB.values);
  todoListNotifier.notifyListeners();
}

Future<void> deleteToDo(index) async {
  final todoDB = await Hive.openBox<ToDoModel>('todo_db');
  await todoDB.deleteAt(index);
  getAllToDo();
}

Future<void> markCompleted(int id, ToDoModel value) async {
  final todoDB = await Hive.openBox<ToDoModel>('todo_db');
  todoDB.putAt(id, value);
  getAllToDo();
}

class FunctionDB with ChangeNotifier {
  List<ToDoModel> toDoList = [];
  Future<void> addToDo(ToDoModel value) async {
    final todoDB = await Hive.openBox<ToDoModel>('todo_db');
    final ids = await todoDB.add(value);
    value.id = ids;
    toDoList.add(value);
    print('listening1');
    notifyListeners();
    getAllToDo();
  }

  Future<void> getAllToDo() async {
    final todoDB = await Hive.openBox<ToDoModel>('todo_db');
    toDoList.clear();
    toDoList.addAll(todoDB.values);
    notifyListeners();
  }

  Future<void> deleteToDo(index) async {
    final todoDB = await Hive.openBox<ToDoModel>('todo_db');
    await todoDB.deleteAt(index);
    getAllToDo();
    notifyListeners();
  }

  Future<void> markCompleted(int id, ToDoModel value) async {
    final todoDB = await Hive.openBox<ToDoModel>('todo_db');
    todoDB.putAt(id, value);
    getAllToDo();
    notifyListeners();
  }
}
