import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list/model/data_model.dart';

class FunctionDB with ChangeNotifier {
  final todoNameController = TextEditingController();
  final todoSubNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<ToDoModel> toDoList = [];

  Future<void> addToDo(ToDoModel value) async {
    final todoDB = await Hive.openBox<ToDoModel>('todo_db');
    final ids = await todoDB.add(value);
    value.id = ids;
    toDoList.add(value);
    todoNameController.clear();
    todoSubNameController.clear();
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

  Future<void> resetDB() async {
    final todoDB = await Hive.openBox<ToDoModel>('todo_db');
    await todoDB.clear();
    notifyListeners();
  }
}
