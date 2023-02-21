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
                trailing: data.complete
                    ? Icon(
                        Icons.done,
                        color: Colors.green,
                        size: 30,
                      )
                    : Icon(
                        Icons.pending_actions_outlined,
                        color: Colors.blueAccent,
                        size: 30,
                      ),
                onTap: () {
                  showDialog(
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
}

// class TaskCheckBox extends StatefulWidget {
//   const TaskCheckBox({super.key});

//   @override
//   State<TaskCheckBox> createState() => _TaskCheckBoxState();
// }

// class _TaskCheckBoxState extends State<TaskCheckBox> {
//   bool isChecked = false;
//   @override
//   Widget build(BuildContext context) {
//     return Checkbox(
//       activeColor: Colors.lightBlueAccent,
//       onChanged: (newValue) {
//         setState(() {
//           isChecked = newValue!;
//         });
//       },
//       value: isChecked,
//     );
//   }
// }
