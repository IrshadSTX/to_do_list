import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list/model/data_model.dart';
import 'package:to_do_list/view/to_do_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(ToDoModelAdapter().typeId)) {
    Hive.registerAdapter(ToDoModelAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ToDoScreen(),
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
    );
  }
}
