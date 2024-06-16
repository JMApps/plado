import 'package:flutter/material.dart';

import '../../../../../core/styles/app_styles.dart';
import '../../../../../domain/entities/task_entity.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.taskModel,
    required this.index,
  });

  final TaskEntity taskModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppStyles.paddingMini,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(taskModel.taskTitle),
        ],
      ),
    );
  }
}
