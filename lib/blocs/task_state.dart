part of 'task_bloc.dart';

@immutable
abstract class TaskState {}

class TaskInitial extends TaskState {}

class TasksLoaded extends TaskState {
  final List<Task> tasks;

  TasksLoaded(this.tasks);
}
