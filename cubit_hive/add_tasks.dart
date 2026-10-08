import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_intro_1/Screens/cubit_hive/myTasks.dart';
import 'package:flutter_intro_1/Screens/cubit_hive/task.dart';
import 'package:flutter_intro_1/Screens/cubit_hive/taskcubit.dart';

class AddTasks extends StatelessWidget {
  final TextEditingController titlecontroller = TextEditingController();
  final TextEditingController descriptioncontroller = TextEditingController();
  AddTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          "Add Task",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Icon(
              Icons.check_circle_outlined,
              size: 50,
              color: Colors.blueAccent,
            ),
            const SizedBox(height: 20),
            const Text(
              "Create a New Task",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(height: 20),
            const Text(
              "Add a title and description for your task",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black38,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(5),
              child: TextField(
                controller: titlecontroller,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.title),
                  label: const Row(children: [Text("Task title")]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(5),
              child: TextField(
                controller: descriptioncontroller,
                maxLines: 4,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.description),
                  label: const Row(children: [Text("Task description")]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () {
                  if (titlecontroller.text.isEmpty ||
                      descriptioncontroller.text.isEmpty) {
                    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "PLease Enter The Title and Description of Task",
                        ),
                      ),
                    );
                  } else {
                    context.read<TasksCubit>().addTask(
                          Task(
                            title: titlecontroller.text,
                            description: descriptioncontroller.text,
                          ),
                        );
                    titlecontroller.clear();
                    descriptioncontroller.clear();
                  }
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add),
                    SizedBox(width: 10),
                    Text("Add Task"),
                  ],
                ),
              ),
            ),
            Card(
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.black12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.checklist_outlined,
                      color: Colors.blueAccent,
                      size: 30,
                    ),
                    const SizedBox(height: 3),
                    const Text(
                      "Tasks Added",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    BlocBuilder<TasksCubit, List<Task>>(
                      builder: (context, tasks) {
                        return Text(
                          "${tasks.length}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Mytasks()),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.list),
                    SizedBox(width: 10),
                    Text("View All Tasks"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}