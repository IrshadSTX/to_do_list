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
                title: Text(data.todoName),
                subtitle: Text(data.todoSubName),
                trailing: IconButton(
                  onPressed: () {
                    deleteToDo(index);
                  },
                  icon: const Icon(Icons.delete),
                ),
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
