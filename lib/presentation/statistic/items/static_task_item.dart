import 'package:flutter/material.dart';
import 'package:plado/core/styles/app_styles.dart';

import '../../../domain/entities/task_entity.dart';

class GraphicTaskItem extends StatelessWidget {
  const GraphicTaskItem({
    super.key,
    required this.taskModel,
  });

  final TaskEntity taskModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        onTap: () {},
        shape: AppStyles.shape,
        title: Text(taskModel.taskTitle),
        trailing: _taskStatusIcon(taskModel.taskStatusIndex),
      ),
    );
  }

  Icon _taskStatusIcon(int taskStatusIndex) {
    late Icon icon;
    switch (taskStatusIndex) {
      case 0:
        icon = const Icon(Icons.access_time, color: Colors.amber);
      case 1:
        icon = const Icon(Icons.check_circle_outline_rounded, color: Colors.teal);
        break;
      case 2:
        icon = const Icon(Icons.blur_circular_rounded, color: Colors.red);
        break;
    }
    return icon;
  }
}
