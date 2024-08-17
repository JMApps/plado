import 'package:flutter/material.dart';

import '../../../core/styles/app_styles.dart';
import '../../../domain/entities/task_entity.dart';
import '../widgets/task_static_detail.dart';

class StaticTaskItem extends StatelessWidget {
  const StaticTaskItem({
    super.key,
    required this.taskModel,
  });

  final TaskEntity taskModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (_) => TaskStaticDetail(taskModel: taskModel),
          );
        },
        shape: AppStyles.shape,
        title: Text(taskModel.taskTitle),
        leading: _taskStatusIcon(taskModel.taskStatusIndex),
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
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
