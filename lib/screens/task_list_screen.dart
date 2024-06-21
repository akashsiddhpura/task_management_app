import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/task_bloc.dart';
import '../models/task_model.dart';
import 'task_form_screen.dart';
import '../widgets/task_item.dart';

class TaskListScreen extends StatefulWidget {
  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<TaskBloc>().add(LoadTasks());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Management'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              context.read<TaskBloc>().add(FilterTasksByStatus(value));
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'All', child: Text('All')),
              PopupMenuItem(value: 'To Do', child: Text('To Do')),
              PopupMenuItem(value: 'In Progress', child: Text('In Progress')),
              PopupMenuItem(value: 'Done', child: Text('Done')),
            ],
          ),
        ],
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TasksLoaded) {
            if (state.tasks.length == 0) {
              return Center(
                child: Text(
                  'No tasks found',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              );
            }
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                final task = state.tasks[index];

                return TaskItem(
                  task: task,
                  onDelete: () {
                    context.read<TaskBloc>().add(DeleteTask(task));
                  },
                  onUpdate: (updatedTask) {
                    context.read<TaskBloc>().add(UpdateTask(updatedTask));
                  },
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push<Task>(
            context,
            MaterialPageRoute(builder: (context) => TaskFormScreen()),
          );

          if (result != null) {
            context.read<TaskBloc>().add(AddTask(result));
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
