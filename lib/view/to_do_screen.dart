import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/core/constants.dart';
import 'package:to_do_list/model/db/db_functions.dart';
import 'package:to_do_list/view/add_task_screen.dart';
import 'package:to_do_list/view/widgets/task_tiles.dart';

class ToDoScreen extends StatelessWidget {
  const ToDoScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => const AddTaskScreen(),
          );
        },
        backgroundColor: Colors.lightBlueAccent,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.lightBlueAccent,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(
                  top: 50, bottom: 30, left: 30, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          child: IconButton(
                              onPressed: () async {
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(
                                        'Reset entire datas',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: const <Widget>[
                                            Text(
                                                'Do you want to reset this task screen'),
                                            Text(
                                                'The Tasks no longer available'),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          child: const Text('Decline'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: const Text(
                                            'Approve',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          onPressed: () {
                                            Provider.of<FunctionDB>(context,
                                                    listen: false)
                                                .resetDB();
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: const Icon(
                                Icons.restart_alt,
                                color: Colors.black,
                              ))),
                    ],
                  ),
                  kHeight10,
                  const Text(
                    'TodoList',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Consumer<FunctionDB>(builder: (context, value, child) {
                    return Text(
                      value.toDoList.isEmpty
                          ? 'Empty Task'
                          : 'Tasks ${value.toDoList.length} ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    );
                  }),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: const ListTasksWidget(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
