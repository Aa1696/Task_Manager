# Task_Manager
It is being created by the Nasreen Qureshi for the project development and learning purpose

UML diagram:



classDiagram
    class TaskApp {
        <<Flutter App>>
        +MaterialApp build(BuildContext context)
    }

    class LoginPage {
        <<StatefulWidget>>
        -TextEditingController _emailController
        -TextEditingController _passwordController
        -bool _isLoading
        +Future<void> _login()
        +Future<void> _register()
        +Widget build(BuildContext context)
    }

    class TaskListPage {
        <<StatefulWidget>>
        -List<ParseObject> _tasks
        -bool _isLoading
        +void initState()
        +Future<void> _fetchTasks()
        +Future<void> _addTask(String title, String description)
        +Future<void> _updateTask(ParseObject task, String title, String description)
        +Future<void> _deleteTask(ParseObject task)
        +Future<void> _logout()
        +Widget build(BuildContext context)
        -void _showAddDialog()
        -void _showEditDialog(ParseObject task)
    }

    class ParseUser {
        <<Back4App SDK>>
        +login()
        +signUp()
        +logout()
        +currentUser()
    }

    class ParseObject {
        <<Back4App SDK>>
        +save()
        +delete()
        +get(String key)
        +set(String key, dynamic value)
    }

    class QueryBuilder {
        <<Back4App SDK>>
        +find()
    }

    class TextEditingController {
        <<Flutter SDK>>
    }

    class BuildContext {
        <<Flutter SDK>>
    }

    TaskApp --> LoginPage
    TaskApp --> TaskListPage
    LoginPage --> ParseUser : uses
    TaskListPage --> ParseObject : uses
    TaskListPage --> QueryBuilder : uses
    TaskListPage --> ParseUser : uses
    LoginPage ..> TextEditingController : uses
    TaskListPage ..> TextEditingController : uses
    LoginPage ..> BuildContext : uses
    TaskListPage ..> BuildContext : uses



    Summary of Project:
This project successfully developed a functional Task Manager application using Flutter for the frontend and Back4App as the backend.
It demonstrated the efficient implementation of user authentication and CRUD operations without the need for complex server-side development.
The application provides users with a seamless experience for managing their tasks, leveraging real-time database synchronization for up-to-date information.
Outcomes:
Gained practical experience in utilizing Backend-as-a-Service (BaaS) platforms.
Successfully integrated Flutter with a cloud database, showcasing the ease of building mobile applications with cloud support.
Developed a strong understanding of user authentication processes within a mobile application context.
Implemented and tested CRUD functionalities, solidifying knowledge of data management in mobile applications.
Showcased the ability to create a complete, deployable application, including version control and presentation materials.
The project highlights the speed and efficiency of modern mobile development using tools like flutter and back4app.
Thank you.
