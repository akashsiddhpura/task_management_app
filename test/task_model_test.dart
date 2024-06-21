import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../lib/models/task_model.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());

  group('Task Model Tests', () {
    test('Task model serialization and deserialization', () async {
      var box = await Hive.openBox<Task>('testBox');

      final task = Task(
        id: '1',
        title: 'Test Task',
        description: 'This is a test task',
        status: 'To Do',
      );

      // Serialize
      await box.put('task', task);
      final retrievedTask = box.get('task');

      // Deserialize and verify
      expect(retrievedTask, isNotNull);
      expect(retrievedTask!.id, task.id);
      expect(retrievedTask.title, task.title);
      expect(retrievedTask.description, task.description);
      expect(retrievedTask.status, task.status);

      await box.close();
    });
  });
}
