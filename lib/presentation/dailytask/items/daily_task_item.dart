import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../../domain/entities/task_entity.dart';
import '../../../core/routes/name_routes.dart';
import '../../../core/strings/app_constraints.dart';
import '../../../core/strings/database_values.dart';
import '../../../core/styles/app_styles.dart';
import '../../../data/models/arguments/task_model_args.dart';
import '../../../data/services/notifications/notification_service.dart';
import '../../../domain/usecases/task_use_case.dart';

class DailyTaskItem extends StatelessWidget {
  const DailyTaskItem({
    super.key,
    required this.taskModel,
    required this.index,
  });

  final TaskEntity taskModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    final bool statusTask = taskModel.taskStatusIndex == 0 ? false : true;
    final String timeAgo = timeago.format(taskModel.createDateTime, locale: appLocale.localeName);
    final taskColor = AppStyles.appColorList[taskModel.taskColorIndex].withOpacity(Theme.of(context).brightness == Brightness.dark ? 0.5 : 1);
    return Card(
      elevation: 0,
      margin: AppStyles.paddingBottomMini,
      color: AppStyles.priorityColors[taskModel.taskPriorityIndex].withOpacity(0.075),
      child: ListTile(
        shape: AppStyles.shape,
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        contentPadding: AppStyles.paddingRight,
        horizontalTitleGap: 8,
        onTap: !statusTask ? () {
          Navigator.pushNamed(
            context,
            NameRoutes.updateDailyTaskPage,
            arguments: TaskModelArgs(taskModel: taskModel),
          );
        } : null,
        title: Text(
          taskModel.taskTitle,
          style: TextStyle(
            fontSize: 18,
            decoration: taskModel.taskStatusIndex == 0 ? TextDecoration.none : TextDecoration.lineThrough,
          ),
          maxLines: 3,
        ),
        subtitle: Text(
          timeAgo,
          style: const TextStyle(
            fontSize: 12,
            fontFamily: AppConstraints.fontRobotoSlab,
          ),
        ),
        leading: Checkbox(
          value: statusTask,
          onChanged: (bool? onChanged) {
            final Map<String, dynamic> taskMap = {
              DatabaseValues.dbTaskStatusIndex: taskModel.taskStatusIndex == 0 ? 1 : 0,
              DatabaseValues.dbHabitCompleteDateTime: DateTime.now().toIso8601String(),
            };
            Provider.of<TaskUseCase>(context, listen: false).updateTask(
              taskMap: taskMap,
              taskId: taskModel.taskId,
            );
            if (onChanged!) {
              if (taskModel.notificationId > 0) {
                NotificationService().cancelNotificationWithId(taskModel.notificationId);
              }
            } else {
              if (taskModel.notificationId > 0) {
                NotificationService().scheduleTimeNotifications(DateTime.parse(taskModel.notificationDate), appLocale.tasks, taskModel.taskTitle, taskModel.notificationId);
              }
            }
          },
        ),
        trailing: Icon(
          statusTask ? Icons.check_circle : Icons.circle_rounded,
          color: taskColor,
          size: 22.5,
        ),
      ),
    );
  }
}
