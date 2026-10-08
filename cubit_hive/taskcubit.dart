import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_intro_1/Screens/cubit_hive/task.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TasksCubit extends Cubit<List<Task>> {
  final Box<Task> _taskBox;

  TasksCubit(this._taskBox) : super([]) {
    loadTasks();
  }

  void loadTasks() {
    emit(_taskBox.values.toList());
  }

  Future<void> addTask(Task task) async {
    await _taskBox.add(task);
    emit(_taskBox.values.toList());
  }

  Future<void> removeTask(Task task) async {
    await task.delete(); 
    emit(_taskBox.values.toList());
  }

  Future<void> removeALLtasks() async {
    await _taskBox.clear();
    emit([]);
  }

  Future<void> toggleTask(Task task) async {
    task.isCompleted = !task.isCompleted;
    await task.save();
    emit(_taskBox.values.toList());
  }
}