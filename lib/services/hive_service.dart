import 'package:hive/hive.dart';
import '../models/task_model.dart';

class HiveService {
  final Box<Task> taskBox;

  HiveService({required this.taskBox});

  List<Task> fetchTasks() {
    return taskBox.values.toList();
  }

  void createTask(Task task) {
    taskBox.add(task);
  }

  void updateTask(Task task) {
    task.save();
  }

  void deleteTask(Task task) {
    task.delete();
  }
}
