import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final VoidCallback onDelete;
  final Function(Task) onUpdate;

  TaskItem({required this.task, required this.onDelete, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      color: task.status == 'Done'
          ? Colors.greenAccent.shade100
          : task.status == 'In Progress'
              ? Colors.orange.shade100
              : Colors.blueAccent.shade100,
      // surfaceTintColor: Colors.greenAccent.shade100.withOpacity(.8),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
        minVerticalPadding: 0,
        title: Text(
          task.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(task.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: DropdownButton<String>(
                value: task.status,
                padding: EdgeInsets.zero,
                isDense: true,
                items: <String>['To Do', 'In Progress', 'Done'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                borderRadius: BorderRadius.circular(10),
                underline: SizedBox(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    task.status = newValue;
                    onUpdate(task);
                  }
                },
              ),
            ),
            SizedBox(
              width: 10,
            ),
            InkWell(
              child: Icon(Icons.delete),
              onTap: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
