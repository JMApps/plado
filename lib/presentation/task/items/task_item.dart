import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../../domain/entities/task_entity.dart';
import '../../../core/routes/name_routes.dart';
import '../../../core/styles/app_styles.dart';
import '../../../data/models/arguments/update_task_args.dart';

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
    DateTime parsedDate = DateTime.parse(taskModel.startDateTime);
    // TODO обязательно передать текущую локаль
    String timeAgo = timeago.format(parsedDate, locale: 'en');
    return Padding(
      padding: AppStyles.paddingBottomMini,
      child: ListTile(
        onTap: () {},
        onLongPress: () {
          Navigator.pushNamed(context, NameRoutes.updateTaskPage, arguments: UpdateTaskArgs(taskEntity: taskModel));
        },
        shape: AppStyles.shapeMini,
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        contentPadding: AppStyles.paddingRight,
        horizontalTitleGap: 8,
        tileColor: AppStyles.priorityColors[taskModel.taskPriorityIndex].withOpacity(0.05),
        leading: Checkbox(
          value: false,
          onChanged: (bool? onChanged) {

          },
        ),
        trailing: Icon(
          Icons.circle,
          color: AppStyles.taskHabitColors[taskModel.taskColorIndex],
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
        subtitle: Text(timeAgo),
      ),
    );
  }
}
