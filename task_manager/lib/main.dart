// Task Manager App with Back4App (All in One Screen)
// Technology Stack: Flutter (Dart) + Back4App (BaaS)
// Features: Registration, Login, CRUD Operations (Create, Read, Update, Delete), Secure Logout

import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Back4App with Application ID and Client Key
  await Parse().initialize(
    'X2YRNKyygP5IVE48yLgUErckpkBqFuPGqxo2g73m', // Replace with your Back4App Application ID
    'https://parseapi.back4app.com',
    clientKey:
        'z4sWti5PjFi1AJ62Mel2kXI2A2HRwRVagZBYmAKz', // Replace with your Back4App Client Key
    autoSendSessionId: true,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Task Manager', home: TaskManagerScreen());
  }
}

// All-in-One Task Manager Screen
class TaskManagerScreen extends StatefulWidget {
  @override
  _TaskManagerScreenState createState() => _TaskManagerScreenState();
}

class _TaskManagerScreenState extends State<TaskManagerScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  List<ParseObject> tasks = [];

  void registerUser() async {
    final user = ParseUser(emailController.text, passwordController.text, null);
    var response = await user.signUp();
    if (response.success) {
      showMessage('Registration Successful!');
    } else {
      showMessage('Registration Failed: ${response.error?.message}');
    }
  }

  void loginUser() async {
    final user = ParseUser(emailController.text, passwordController.text, null);
    var response = await user.login();
    if (response.success) {
      fetchTasks();
      showMessage('Login Successful!');
    } else {
      showMessage('Login Failed: ${response.error?.message}');
    }
  }

  void logoutUser() async {
    await ParseUser.currentUser()!.logout();
    showMessage('Logged Out Successfully!');
    setState(() {
      tasks.clear();
    });
  }

  void createTask() async {
    final task =
        ParseObject('Task')
          ..set('title', titleController.text)
          ..set('description', descriptionController.text);
    await task.save();
    fetchTasks();
  }

  void fetchTasks() async {
    final query = QueryBuilder<ParseObject>(ParseObject('Task'));
    final response = await query.find();
    if (response.success) {
      setState(() {
        tasks = response.results ?? [];
      });
    }
  }

  void updateTask(ParseObject task) async {
    task.set('title', titleController.text);
    task.set('description', descriptionController.text);
    await task.save();
    fetchTasks();
  }

  void deleteTask(ParseObject task) async {
    await task.delete();
    fetchTasks();
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
        actions: [IconButton(icon: Icon(Icons.logout), onPressed: logoutUser)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(onPressed: loginUser, child: Text('Login')),
            ElevatedButton(onPressed: registerUser, child: Text('Register')),
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Task Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Task Description'),
            ),
            ElevatedButton(onPressed: createTask, child: Text('Add Task')),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return ListTile(
                    title: Text(task.get<String>('title') ?? 'No Title'),
                    subtitle: Text(
                      task.get<String>('description') ?? 'No Description',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            titleController.text =
                                task.get<String>('title') ?? '';
                            descriptionController.text =
                                task.get<String>('description') ?? '';
                            updateTask(task);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => deleteTask(task),
                        ),
                      ],
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
