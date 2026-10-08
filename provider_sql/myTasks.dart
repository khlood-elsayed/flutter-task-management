import 'package:flutter/material.dart';
import 'package:flutter_intro_1/Screens/provider_sql/task.dart';
import 'package:flutter_intro_1/Screens/provider_sql/taskprovider.dart';
import 'package:provider/provider.dart';


class Mytasks extends StatelessWidget {
  const Mytasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Tasks",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: Consumer<TaskProvider>(
        builder: (context, provider, child) {
          final tasks = provider.tasks;
          final isPending = tasks.where((t) => !t.isCompleted).toList();
          final isCompleted = tasks.where((t) => t.isCompleted).toList();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Icon(Icons.pending_actions, size: 25),
                    const SizedBox(width: 5),
                    const Text(
                      "Pending Tasks",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(width: 5),
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.purple[100],
                      foregroundColor: Colors.purple,
                      child: Text("${isPending.length}"),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: isPending.isEmpty
                    ? const Center(
                        child: Text(
                          "No Pending Tasks",
                          style: TextStyle(fontSize: 20, color: Colors.black38),
                        ),
                      )
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          return TaskColumn(task: isPending[index]);
                        },
                        itemCount: isPending.length,
                      ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle_outline, size: 25),
                    const SizedBox(width: 5),
                    const Text(
                      "Completed Tasks",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(width: 5),
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.purple[100],
                      foregroundColor: Colors.purple,
                      child: Text("${isCompleted.length}"),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: isCompleted.isEmpty
                    ? const Center(
                        child: Text(
                          "No Completed Tasks",
                          style: TextStyle(fontSize: 20, color: Colors.black38),
                        ),
                      )
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          return TaskColumn(task: isCompleted[index]);
                        },
                        itemCount: isCompleted.length,
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple[100],
        onPressed: () {
          context.read<TaskProvider>().removeALLtasks();
        },
        child: const Icon(Icons.delete_forever, color: Colors.purple),
      ),
    );
  }
}

class TaskColumn extends StatelessWidget {
  final Task task;

  const TaskColumn({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        style: ListTileStyle.list,
        leading: CircleAvatar(
          backgroundColor: Colors.purple[100],
          foregroundColor: Colors.purple,
          child: task.isCompleted
              ? const Icon(Icons.check)
              : const Icon(Icons.check_circle_outline),
        ),
        title: Text(
          task.title,
          style: task.isCompleted
              ? const TextStyle(
                  decoration: TextDecoration.lineThrough,
                  fontWeight: FontWeight.bold,
                )
              : const TextStyle(
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold,
                ),
        ),
        subtitle: Text(task.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                context.read<TaskProvider>().removeTask(task);
              },
              icon: const Icon(Icons.delete_outline),
              color: Colors.redAccent,
            ),
            Checkbox(
              value: task.isCompleted,
              onChanged: (bool? value) {
                if (value != null) {
                  context.read<TaskProvider>().toggleTask(task);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}