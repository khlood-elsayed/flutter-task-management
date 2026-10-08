import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_intro_1/Screens/cubit_hive/add_tasks.dart';
import 'package:flutter_intro_1/Screens/cubit_hive/task.dart';
import 'package:flutter_intro_1/Screens/cubit_hive/taskcubit.dart';
import 'package:hive_flutter/hive_flutter.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  final taskBox = await Hive.openBox<Task>('tasks_box');

  runApp(
    BlocProvider(
      create: (_) => TasksCubit(taskBox),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task App (Cubit + Hive)',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: AddTasks(),
    );
  }
}