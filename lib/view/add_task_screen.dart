import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/model/data_model.dart';
import 'package:to_do_list/model/db/db_functions.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _todoNameController = TextEditingController();
  final _todoSubNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xff757575),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Add Task',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.lightBlueAccent),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _todoNameController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        hintText: 'Title text',
                        labelText: 'Title',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Fill the text field';
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      controller: _todoSubNameController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        hintText: 'Description',
                        labelText: 'Sub Text',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Fill the text field';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            onAddToDoNameClicked();
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text(
                          'Add',
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onAddToDoNameClicked() async {
    final todoName = _todoNameController.text.trim();
    final todoSubName = _todoSubNameController.text.trim();

    if (todoName.isEmpty || todoSubName.isEmpty) {
      return;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Task added Successfully'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(20),
        ),
      );
    }

    final todo = ToDoModel(
        todoName: todoName, todoSubName: todoSubName, complete: false);
    print('adding place');
    Provider.of<FunctionDB>(context, listen: false).addToDo(todo);
  }
}
