import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../lib/models/task_model.dart';
import '../lib/services/hive_service.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());

  group('HiveService Tests', () {
    late HiveService hiveService;
    late Box<Task> box;

    setUp(() async {
      box = await Hive.openBox<Task>('testBox');
      hiveService = HiveService(taskBox: box);
    });

    tearDown(() async {
      await box.clear();
      await box.close();
    });

    test('Create Task', () async {
      final task = Task(
        id: '1',
        title: 'New Task',
        description: 'Task Description',
        status: 'To Do',
      );

      hiveService.createTask(task);
      final tasks = hiveService.fetchTasks();
      expect(tasks.length, 1);
      expect(tasks[0].title, 'New Task');
    });

    test('Update Task', () async {
      final task = Task(
        id: '1',
        title: 'New Task',
        description: 'Task Description',
        status: 'To Do',
      );

      hiveService.createTask(task);
      task.title = 'Updated Task';
      hiveService.updateTask(task);

      final tasks = hiveService.fetchTasks();
      expect(tasks[0].title, 'Updated Task');
    });

    test('Delete Task', () async {
      final task = Task(
        id: '1',
        title: 'New Task',
        description: 'Task Description',
        status: 'To Do',
      );

      hiveService.createTask(task);
      hiveService.deleteTask(task);

      final tasks = hiveService.fetchTasks();
      expect(tasks.length, 0);
    });

    test('Fetch Tasks', () async {
      final task1 = Task(
        id: '1',
        title: 'Task 1',
        description: 'Description 1',
        status: 'To Do',
      );
      final task2 = Task(
        id: '2',
        title: 'Task 2',
        description: 'Description 2',
        status: 'In Progress',
      );

      hiveService.createTask(task1);
      hiveService.createTask(task2);

      final tasks = hiveService.fetchTasks();
      expect(tasks.length, 2);
    });
  });
}
