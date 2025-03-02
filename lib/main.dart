import 'package:flutter/material.dart';

void main() {
  runApp(TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TaskListScreen(),
    );
  }
}

class Task {
  String name;
  bool isCompleted;

  Task({required this.name, this.isCompleted = false});
}

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [];
  TextEditingController taskController =
      TextEditingController(); // Controller for input field

  void addTask() {
    String taskName = taskController.text.trim();
    if (taskName.isNotEmpty) {
      setState(() {
        tasks.add(Task(name: taskName));
        taskController.clear();
      });
    }
  }

  void toggleTaskCompletion(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Task Manager"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input Field and Add Button
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration: InputDecoration(
                      labelText: "Enter Task",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(onPressed: addTask, child: Text("Add")),
              ],
            ),
            SizedBox(height: 20),

            // Task List
            Expanded(
              child:
                  tasks.isEmpty
                      ? Center(child: Text("No tasks added"))
                      : ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              leading: Checkbox(
                                value: tasks[index].isCompleted,
                                onChanged: (value) {
                                  toggleTaskCompletion(index);
                                },
                              ),
                              title: Text(
                                tasks[index].name,
                                style: TextStyle(
                                  decoration:
                                      tasks[index].isCompleted
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                ),
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  deleteTask(index);
                                },
                              ),
                            ),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
