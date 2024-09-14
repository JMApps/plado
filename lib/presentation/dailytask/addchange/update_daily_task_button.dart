import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../core/strings/app_constraints.dart';
import '../../../core/strings/database_values.dart';
import '../../../data/services/notifications/notification_service.dart';
import '../../../domain/entities/task_entity.dart';
import '../../../domain/usecases/task_use_case.dart';
import '../../state/task/task_color_state.dart';
import '../../state/task/task_notification_date_state.dart';
import '../../state/task/task_notification_id_state.dart';
import '../../state/task/task_priority_state.dart';
import '../../state/task/task_remind_state.dart';
import '../../state/task/task_title_state.dart';

class UpdateDailyTaskButton extends StatefulWidget {
  const UpdateDailyTaskButton({
    super.key,
    required this.taskModel,
  });

  final TaskEntity taskModel;

  @override
  State<UpdateDailyTaskButton> createState() => _UpdateDailyTaskButtonState();
}

class _UpdateDailyTaskButtonState extends State<UpdateDailyTaskButton> {
  final NotificationService _notificationService = NotificationService();

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    final appColors = Theme.of(context).colorScheme;
    return IconButton(
      onPressed: () {
        if (Provider.of<TaskTitleState>(context, listen: false).getTaskTitle.trim().isNotEmpty) {
          Navigator.of(context).pop();
          _updateTask(appLocale.dailyTasks);
        } else {
          _showScaffoldMessage(appColors.inversePrimary, appColors.onSurface, appLocale.enterTitle);
        }
      },
      tooltip: appLocale.changeTask,
      icon: const Icon(Icons.check_circle_outlined),
    );
  }

  void _updateTask(String tasks) {
    final String taskTitleState = context.read<TaskTitleState>().getTaskTitle.trim();
    final int taskPriorityIndex = context.read<TaskPriorityState>().getTaskPriorityIndex;
    final int taskColorIndex = context.read<TaskColorState>().getColorIndex;
    final bool taskIsRemind = context.read<TaskRemindState>().getIsRemind;
    int taskNotificationId = context.read<TaskNotificationIdState>().getNotificationId;
    final String taskNotificationDateTime = context.read<TaskNotificationDateState>().getTaskNotificationDate;

    if (taskIsRemind && taskNotificationId == 0) {
      final randomNotificationNumber = Random().nextInt(AppConstraints.randomNotificationNumber);
      taskNotificationId = randomNotificationNumber;
      _notificationService.scheduleTimeNotifications(DateTime.parse(taskNotificationDateTime), tasks, taskTitleState, randomNotificationNumber);
    } else if (taskIsRemind && taskNotificationId > 0) {
      _notificationService.scheduleTimeNotifications(DateTime.parse(taskNotificationDateTime), tasks, taskTitleState, taskNotificationId);
    } else {
      _notificationService.cancelNotificationWithId(taskNotificationId);
      taskNotificationId = 0;
    }

    final Map<String, dynamic> taskMap = {
      DatabaseValues.dbTaskTitle: taskTitleState,
      DatabaseValues.dbTaskPriorityIndex: taskPriorityIndex,
      DatabaseValues.dbTaskColorIndex: taskColorIndex,
      DatabaseValues.dbTaskNotificationId: taskNotificationId,
      DatabaseValues.dbTaskNotificationDate: taskNotificationDateTime,
    };

    Provider.of<TaskUseCase>(context, listen: false).updateTask(taskMap: taskMap, taskId: widget.taskModel.taskId);
  }

  void _showScaffoldMessage(Color color, Color textColor, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        duration: const Duration(seconds: 1),
        content: Text(
          message,
          style: TextStyle(
            fontSize: 17,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
