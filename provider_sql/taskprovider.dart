import 'package:flutter/foundation.dart';
import 'package:flutter_intro_1/Screens/provider_sql/databasehelper.dart';
import 'package:flutter_intro_1/Screens/provider_sql/task.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  TaskProvider() {
    loadTasks();
  }

  Future<void> loadTasks() async {
    _tasks = await DatabaseHelper.instance.getAllTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    final savedTask = await DatabaseHelper.instance.insertTask(task);
    _tasks.add(savedTask);
    notifyListeners();
  }

  Future<void> toggleTask(Task task) async {
    final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
    await DatabaseHelper.instance.updateTask(updatedTask);

    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
      notifyListeners();
    }
  }

  Future<void> removeTask(Task task) async {
    if (task.id != null) {
      await DatabaseHelper.instance.deleteTask(task.id!);
      _tasks.removeWhere((t) => t.id == task.id);
      notifyListeners();
    }
  }

  Future<void> removeALLtasks() async {
    await DatabaseHelper.instance.deleteAllTasks();
    _tasks.clear();
    notifyListeners();
  }
}