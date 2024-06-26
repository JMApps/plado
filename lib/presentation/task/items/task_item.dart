import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../domain/entities/task_entity.dart';
import '../../../core/styles/app_styles.dart';

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
    return Padding(
      padding: AppStyles.paddingBottomMini,
      child: ListTile(
        onTap: () {},
        shape: AppStyles.shapeMini,
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        contentPadding: AppStyles.paddingRight,
        horizontalTitleGap: 8,
        tileColor: AppStyles.priorityColors[taskModel.taskPriorityIndex].withOpacity(0.05),
        leading: Checkbox(
          value: false,
          onChanged: (bool? onChanged) {},
        ),
        trailing: Icon(
          Icons.circle,
          color: AppStyles.tashabColors[taskModel.taskColorIndex],
          size: 15,
        ),
        title: Text(
          taskModel.taskTitle,
          style: const TextStyle(
            fontSize: 18,
            overflow: TextOverflow.ellipsis,
          ),
          maxLines: 1,
        ),
        subtitle: Text(DateFormat('dd.MM.yyyy – HH:mm').format(taskModel.startDateTime)),
      ),
    );
  }
}
