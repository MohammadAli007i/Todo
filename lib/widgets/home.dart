import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'todo_provider.dart';
import 'task.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<TodoProvider>(context, listen: false).loadTasks();
    });
  }

  List<Task> getCompletedTasks(List<Task> tasks) {
    return tasks.where((task) => task.isCompleted).toList();
  }

  List<Task> getPendingTasks(List<Task> tasks) {
    return tasks.where((task) => !task.isCompleted).toList();
  }

  void _showEditTaskDialog(Task task) {
    final titleController = TextEditingController(text: task.title);
    final descriptionController = TextEditingController(text: task.description);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets.add(EdgeInsets.all(16)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Edit Task",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: "Description"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Provider.of<TodoProvider>(context, listen: false).updateTask(
                  task.id!,
                  titleController.text,
                  descriptionController.text,
                );
                Navigator.pop(context);
              },
              child: Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);

    final completedTasks = getCompletedTasks(provider.tasks);
    final pendingTasks = getPendingTasks(provider.tasks);

    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        title: Text(
          "To-Do Management",
          style: TextStyle(fontWeight: FontWeight.bold , fontFamily: 'zillaslab'),
        ),
        backgroundColor: Color(0xffD0C082),
        centerTitle: true,
      ),
      body: provider.tasks.isEmpty
          ? Center(
        child: Text(
          "No tasks available. Add a task to get started.",
          style: TextStyle(fontSize: 16 , fontFamily: 'zillasalb'),
        ),
      )
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pending Tasks",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffdebb2f),
                    fontFamily: 'zillaslab'
                ),
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: pendingTasks.length,
                itemBuilder: (context, index) {
                  final task = pendingTasks[index];
                  return TaskCard(
                    task: task,
                    onEdit: () => _showEditTaskDialog(task),
                    onDelete: () => provider.deleteTask(task.id!),
                    onToggleCompletion: () => provider.toggleTaskCompletion(
                        task.id!, !task.isCompleted),
                  );
                },
              ),
              SizedBox(height: 20),
              Text(
                "Completed Tasks",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffdebb2f),
                    fontFamily: 'zillaslab'
                ),
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: completedTasks.length,
                itemBuilder: (context, index) {
                  final task = completedTasks[index];
                  return TaskCard(
                    task: task,
                    onEdit: () => _showEditTaskDialog(task),
                    onDelete: () => provider.deleteTask(task.id!),
                    onToggleCompletion: () => provider.toggleTaskCompletion(
                        task.id!, !task.isCompleted),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddTaskDialog(),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Color(0xffdebb2f),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onToggleCompletion;

  const TaskCard({
    Key? key,
    required this.task,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleCompletion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: task.isCompleted ? Colors.green[200] : Colors.orange[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: ListTile(
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (value) => onToggleCompletion(),
        ),
        title: Text(
          task.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            decoration: task.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        subtitle: Text(
          task.description,
          style: TextStyle(fontSize: 14),
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == "Edit") onEdit();
            if (value == "Delete") onDelete();
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: "Edit",
              child: Text("Edit",style: TextStyle(fontFamily: 'zillaslab' , fontWeight: FontWeight.bold),),
            ),
            PopupMenuItem(
              value: "Delete",
              child: Text("Delete", style: TextStyle(fontFamily: 'zillaslab', fontWeight: FontWeight.bold),),
            ),
          ],
        ),
      ),
    );
  }
}
