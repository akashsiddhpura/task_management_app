import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'blocs/task_bloc.dart';
import 'screens/task_list_screen.dart';
import 'models/task_model.dart';
import 'services/hive_service.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  final taskBox = await Hive.openBox<Task>('tasks');

  runApp(TaskManagementApp(taskBox: taskBox));
}

class TaskManagementApp extends StatelessWidget {
  final Box<Task> taskBox;

  TaskManagementApp({required this.taskBox});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(hiveService: HiveService(taskBox: taskBox)),
      child: MaterialApp(
        title: 'Task Management App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: TaskListScreen(),
      ),
    );
  }
}
