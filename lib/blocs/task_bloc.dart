import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../models/task_model.dart';
import '../services/hive_service.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final HiveService hiveService;

  TaskBloc({required this.hiveService}) : super(TaskInitial()) {
    on<LoadTasks>((event, emit) {
      final tasks = hiveService.fetchTasks();
      emit(TasksLoaded(tasks));
    });

    on<AddTask>((event, emit) {
      hiveService.createTask(event.task);
      final tasks = hiveService.fetchTasks();
      emit(TasksLoaded(tasks));
    });

    on<UpdateTask>((event, emit) {
      hiveService.updateTask(event.task);
      final tasks = hiveService.fetchTasks();
      emit(TasksLoaded(tasks));
    });

    on<DeleteTask>((event, emit) {
      hiveService.deleteTask(event.task);
      final tasks = hiveService.fetchTasks();
      emit(TasksLoaded(tasks));
    });

    on<FilterTasksByStatus>((event, emit) {
      final allTasks = hiveService.fetchTasks();
      final filteredTasks = event.status == 'All' ? allTasks : allTasks.where((task) => task.status == event.status).toList();
      emit(TasksLoaded(filteredTasks));
    });
  }
}
