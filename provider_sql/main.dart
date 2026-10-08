import 'package:flutter/material.dart';
import 'package:flutter_intro_1/Screens/provider_sql/add_tasks.dart';
import 'package:flutter_intro_1/Screens/provider_sql/taskprovider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => TaskProvider(),
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
      home: AddTasks(),
    );
  }
}