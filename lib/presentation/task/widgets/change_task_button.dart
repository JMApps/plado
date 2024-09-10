import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/strings/app_constraints.dart';
import '../../../core/strings/database_values.dart';
import '../../../data/services/notifications/notification_service.dart';
import '../../../domain/entities/task_entity.dart';
import '../../../domain/usecases/task_use_case.dart';
import '../../state/rest_times_state.dart';
import '../../state/task/task_color_state.dart';
import '../../state/task/task_notification_date_state.dart';
import '../../state/task/task_notification_id_state.dart';
import '../../state/task/task_period_state.dart';
import '../../state/task/task_priority_state.dart';
import '../../state/task/task_remind_state.dart';
import '../../state/task/task_title_state.dart';

class ChangeTaskButton extends StatefulWidget {
  const ChangeTaskButton({
    super.key,
    required this.taskModel,
  });

  final TaskEntity taskModel;

  @override
  State<ChangeTaskButton> createState() => _ChangeTaskButtonState();
}

class _ChangeTaskButtonState extends State<ChangeTaskButton> {
  DateTime _currentDateTime = DateTime.now();
  final NotificationService _notificationService = NotificationService();

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    final appColors = Theme.of(context).colorScheme;
    return IconButton(
      onPressed: () {
        if (Provider.of<TaskTitleState>(context, listen: false).getTaskTitle.trim().isNotEmpty) {
          if (Provider.of<TaskRemindState>(context, listen: false).getIsRemind) {
            _currentDateTime = DateTime.now();
            if (DateTime.parse(Provider.of<TaskNotificationDateState>(context, listen: false).getTaskNotificationDate).isAfter(_currentDateTime)) {
              Navigator.of(context).pop();
              _updateTask(appLocale.tasks);
            } else {
              _showScaffoldMessage(appColors.inversePrimary, appColors.onSurface, appLocale.selectCorrectDateTime);
            }
          } else {
            Navigator.of(context).pop();
            _updateTask(appLocale.tasks);
          }
        } else {
          _showScaffoldMessage(appColors.inversePrimary, appColors.onSurface, appLocale.enterTitle);
        }
      },
      tooltip: appLocale.changingTask,
      icon: const Icon(Icons.check_circle_outlined),
    );
  }

  void _updateTask(String tasks) {
    final String taskTitleState = context.read<TaskTitleState>().getTaskTitle.trim();
    final int taskPeriodIndex = context.read<TaskPeriodState>().getTaskPeriodIndex;
    final int taskPriorityIndex = context.read<TaskPriorityState>().getTaskPriorityIndex;
    final int taskColorIndex = context.read<TaskColorState>().getColorIndex;
    final bool taskIsRemind = context.read<TaskRemindState>().getIsRemind;
    int taskNotificationId = context.read<TaskNotificationIdState>().getNotificationId;
    final String taskNotificationDateTime = context.read<TaskNotificationDateState>().getTaskNotificationDate;

    Map<String, dynamic> restTimePeriods = Provider.of<RestTimesState>(context, listen: false).restTaskTimes(taskPeriodIndex);
    DateTime startTime = restTimePeriods[AppConstraints.taskStartDateTime];
    DateTime endTime = restTimePeriods[AppConstraints.taskEndDateTime];

    if (taskIsRemind && taskNotificationId == 0) {
      final randomNotificationNumber = Random().nextInt(AppConstraints.randomNotificationNumber);
      taskNotificationId = randomNotificationNumber;
      _notificationService.scheduleTimeNotifications(DateTime.parse(taskNotificationDateTime), tasks, taskTitleState, randomNotificationNumber);
    } else if (taskIsRemind && taskNotificationId > 0) {
      _notificationService.scheduleTimeNotifications(DateTime.parse(taskNotificationDateTime), tasks, taskTitleState, taskNotificationId);
    } else {
      _notificationService.cancelNotificationWithId(taskNotificationId);
    }

    final Map<String, dynamic> taskMap = {
      DatabaseValues.dbTaskTitle: taskTitleState,
      DatabaseValues.dbTaskStartDateTime: startTime.toIso8601String(),
      DatabaseValues.dbTaskEndDateTime: endTime.toIso8601String(),
      DatabaseValues.dbTaskPeriodIndex: taskPeriodIndex,
      DatabaseValues.dbTaskPriorityIndex: taskPriorityIndex,
      DatabaseValues.dbTaskColorIndex: taskColorIndex,
      DatabaseValues.dbTaskNotificationId: taskNotificationId,
      DatabaseValues.dbTaskNotificationDate: taskNotificationDateTime,
    };

    Provider.of<TaskUseCase>(context, listen: false).updateTask(taskId: widget.taskModel.taskId, taskMap: taskMap);
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
