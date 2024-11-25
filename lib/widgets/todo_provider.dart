import 'package:flutter/material.dart';
import 'package:todo3/database/db_helper.dart';

class Task {
  int? id;
  String title;
  String description;
  bool isCompleted;

  Task({this.id, required this.title, required this.description, this.isCompleted = false});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  static Task fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isCompleted: map['isCompleted'] == 1,
    );
  }
}

class TodoProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Future<void> loadTasks() async {
    final data = await DBHelper().getTasks();
    _tasks = data.map((task) => Task.fromMap(task)).toList();
    notifyListeners();
  }

  Future<void> addTask(String title, String description) async {
    final task = Task(title: title, description: description);
    await DBHelper().insertTask(task.toMap());
    await loadTasks();
  }

  Future<void> updateTask(int id, String title, String description) async {
    await DBHelper().updateTaskDetails(id, title, description);
    await loadTasks();
  }

  Future<void> toggleTaskCompletion(int id, bool isCompleted) async {
    await DBHelper().updateTask(id, isCompleted ? 1 : 0);
    await loadTasks();
  }

  Future<void> deleteTask(int id) async {
    await DBHelper().deleteTask(id);
    await loadTasks();
  }
}

