import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../../domain/entities/task_entity.dart';
import '../../../core/routes/name_routes.dart';
import '../../../core/styles/app_styles.dart';
import '../../../data/models/arguments/update_task_args.dart';
import '../../../data/services/notifications/notification_service.dart';
import '../../../data/state/task_data_state.dart';

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
    final taskDataState = Provider.of<TaskDataState>(context, listen: false);
    DateTime parsedDate = DateTime.parse(taskModel.createDateTime);
    bool statusTask = taskModel.taskStatusIndex == 0 ? false : true;
    // TODO обязательно передать текущую локаль
    String timeAgo = timeago.format(parsedDate, locale: 'en');
    return Padding(
      padding: AppStyles.paddingBottomMini,
      child: ListTile(
        onTap: !statusTask ? () {
          Navigator.pushNamed(context, NameRoutes.updateTaskPage, arguments: UpdateTaskArgs(taskEntity: taskModel));
        } : null,
        shape: AppStyles.shapeMini,
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        contentPadding: AppStyles.paddingRight,
        horizontalTitleGap: 8,
        tileColor: AppStyles.priorityColors[taskModel.taskPriorityIndex].withOpacity(0.05),
        leading: Checkbox(
          value: statusTask,
          onChanged: !statusTask ? (bool? onChanged) {
            if (onChanged!) {
              taskDataState.changeTaskStatus(taskId: taskModel.taskId, taskStatusIndex: 1);
              if (taskModel.notificationId > 0) {
                NotificationService().cancelNotificationWithId(taskModel.notificationId);
              }
            } else {
              taskDataState.changeTaskStatus(taskId: taskModel.taskId, taskStatusIndex: 0);
            }
          } : null,
        ),
        trailing: Icon(
          statusTask ? Icons.circle_rounded : Icons.circle_outlined,
          color: AppStyles.taskHabitColors[taskModel.taskColorIndex],
          size: 15,
        ),
        title: Text(
          taskModel.taskTitle,
          style: TextStyle(
            fontSize: 18,
            decoration: taskModel.taskStatusIndex == 0 ? TextDecoration.none : TextDecoration.lineThrough,
            overflow: TextOverflow.ellipsis,
          ),
          maxLines: 1,
        ),
        subtitle: Text(timeAgo),
      ),
    );
  }
}
