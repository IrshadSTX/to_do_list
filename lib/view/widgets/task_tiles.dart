import 'package:flutter/material.dart';
import 'package:to_do_list/model/data_model.dart';
import 'package:to_do_list/model/db/db_functions.dart';

class ListTasksWidget extends StatelessWidget {
  const ListTasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: todoListNotifier,
      builder: (BuildContext ctx, List<ToDoModel> toDoList, Widget? child) {
        return ListView.separated(
            itemBuilder: (ctx, index) {
              final data = toDoList[index];
              return ListTile(
                leading: Text(
                  '${index + 1}',
                  style: const TextStyle(fontSize: 20),
                ),
                title: Text(data.todoName),
                subtitle: Text(data.todoSubName),
                trailing: SizedBox(
                    width: 80,
                    child: Row(
                      children: [
                        data.complete
                            ? const Icon(
                                Icons.done,
                                color: Colors.green,
                                size: 30,
                              )
                            : const Icon(
                                Icons.pending_actions_outlined,
                                color: Colors.blueAccent,
                                size: 30,
                              ),
                        IconButton(
                            onPressed: () async {
                              await deleteAlertBox(context, index);
                            },
                            icon: const Icon(Icons.delete,
                                color: Colors.red, size: 20))
                      ],
                    )),
                onTap: () {
                  data.complete
                      ? null
                      : showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            actions: [
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: Container(
                                      color: Colors.red,
                                      padding: const EdgeInsets.all(15),
                                      child: const Text(
                                        "exit",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  TextButton(
                                    onPressed: () {
                                      ToDoModel markedTodo = ToDoModel(
                                        todoName: data.todoName,
                                        todoSubName: data.todoSubName,
                                        complete: true,
                                      );
                                      markCompleted(index, markedTodo);
                                      Navigator.of(ctx).pop();
                                    },
                                    child: Container(
                                      color: Colors.green,
                                      padding: const EdgeInsets.all(15),
                                      child: const Text(
                                        "Mark as completed",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                },
              );
            },
            separatorBuilder: (ctx, index) => const Divider(),
            itemCount: toDoList.length);
      },
    );
  }

  Future<void> deleteAlertBox(BuildContext context, int index) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Deleting Task',
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Do you want to delete this task?'),
                Text('The task get removed'),
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
              ),
              onPressed: () {
                deleteToDo(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
