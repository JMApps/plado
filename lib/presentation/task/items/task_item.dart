import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../../domain/entities/task_entity.dart';
import '../../../core/routes/name_routes.dart';
import '../../../core/strings/app_constraints.dart';
import '../../../core/strings/database_values.dart';
import '../../../core/styles/app_styles.dart';
import '../../../data/models/arguments/task_model_args.dart';
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
    final bool statusTask = taskModel.taskStatusIndex == 0 ? false : true;
    final String timeAgo = timeago.format(taskModel.createDateTime, locale: 'en');
    final taskColor = AppStyles.taskHabitColors[taskModel.taskColorIndex].withOpacity(Theme.of(context).brightness == Brightness.dark ? 0.5 : 1);
    return Card(
      elevation: 0,
      margin: AppStyles.paddingBottomMini,
      child: ListTile(
        onTap: !statusTask ? () {
          Navigator.pushNamed(
            context,
            NameRoutes.updateTaskPage,
            arguments: TaskModelArgs(taskEntity: taskModel),
          );
        } : null,
        shape: AppStyles.shape,
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        contentPadding: AppStyles.paddingRight,
        horizontalTitleGap: 8,
        title: Text(
          taskModel.taskTitle,
          style: TextStyle(
            fontSize: 18,
            decoration: taskModel.taskStatusIndex == 0 ? TextDecoration.none : TextDecoration.lineThrough,
            overflow: TextOverflow.ellipsis,
          ),
          maxLines: 1,
        ),
        subtitle: Text(
          timeAgo,
          style: const TextStyle(
            fontSize: 14,
            fontFamily: AppConstraints.fontRobotoSlab,
          ),
        ),
        leading: Checkbox(
          value: statusTask,
          onChanged: (bool? onChanged) {
            Provider.of<TaskDataState>(context, listen: false).changeTaskStatus(
                taskId: taskModel.taskId,
                taskStatusIndex: taskModel.taskStatusIndex == 0 ? 1 : 0,
                completeDateTime: DateTime.now().toIso8601String());
            if (onChanged!) {
              if (taskModel.notificationId > 0) {
                NotificationService().cancelNotificationWithId(taskModel.notificationId);
                final Map<String, dynamic> taskMap = {
                  DatabaseValues.dbTaskNotificationId: 0,
                };
                Provider.of<TaskDataState>(context, listen: false).updateTask(taskId: taskModel.taskId, taskMap: taskMap);
              }
            }
          },
        ),
        trailing: Icon(
          statusTask ? Icons.check_circle : Icons.circle_rounded,
          color: taskColor,
          size: 20,
        ),
      ),
    );
  }
}
