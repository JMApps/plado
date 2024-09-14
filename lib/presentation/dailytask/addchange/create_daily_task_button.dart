import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../core/enums/task_status.dart';
import '../../../core/strings/app_constraints.dart';
import '../../../data/models/task_model.dart';
import '../../../data/services/notifications/notification_service.dart';
import '../../../domain/usecases/task_use_case.dart';
import '../../state/rest_times_state.dart';
import '../../state/task/task_color_state.dart';
import '../../state/task/task_notification_date_state.dart';
import '../../state/task/task_notification_id_state.dart';
import '../../state/task/task_priority_state.dart';
import '../../state/task/task_remind_state.dart';
import '../../state/task/task_title_state.dart';

class CreateDailyTaskButton extends StatefulWidget {
  const CreateDailyTaskButton({super.key});

  @override
  State<CreateDailyTaskButton> createState() => _CreateDailyTaskButtonState();
}

class _CreateDailyTaskButtonState extends State<CreateDailyTaskButton> {
  final DateTime _currentDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    final appColors = Theme.of(context).colorScheme;
    return IconButton(
      onPressed: () {
        if (Provider.of<TaskTitleState>(context, listen: false).getTaskTitle.trim().isNotEmpty) {
          Navigator.of(context).pop();
          _createTask(appLocale.tasks);
        } else {
          _showScaffoldMessage(appColors.inversePrimary, appColors.onSurface, appLocale.enterTitle);
        }
      },
      tooltip: appLocale.addTask,
      icon: const Icon(Icons.check_circle_outlined),
    );
  }

  void _createTask(String tasks) {
    final String taskTitleState = context.read<TaskTitleState>().getTaskTitle.trim();
    final int taskPriorityIndex = context.read<TaskPriorityState>().getTaskPriorityIndex;
    final int taskColorIndex = context.read<TaskColorState>().getColorIndex;
    final bool taskIsRemind = context.read<TaskRemindState>().getIsRemind;
    int taskNotificationId = context.read<TaskNotificationIdState>().getNotificationId;
    final String taskNotificationDate = context.read<TaskNotificationDateState>().getTaskNotificationDate;

    if (taskIsRemind) {
      final randomNotificationNumber = Random().nextInt(AppConstraints.randomNotificationNumber);
      taskNotificationId = randomNotificationNumber;
      NotificationService().scheduleTimeNotifications(DateTime.parse(taskNotificationDate), tasks, taskTitleState, randomNotificationNumber);
    }

    Map<String, dynamic> restTimePeriods = Provider.of<RestTimesState>(context, listen: false).restCategoryTimes(0);
    DateTime startTime = restTimePeriods[AppConstraints.startDateTime];
    DateTime endTime = restTimePeriods[AppConstraints.endDateTime];

    final TaskModel taskModel = TaskModel(
      taskId: 0,
      taskTitle: taskTitleState,
      createDateTime: _currentDateTime,
      completeDateTime: _currentDateTime,
      startDateTime: startTime,
      endDateTime: endTime,
      taskPriorityIndex: taskPriorityIndex,
      taskPeriodIndex: 0,
      taskStatusIndex: TaskStatus.inProgress.index,
      taskColorIndex: taskColorIndex,
      taskSampleBy: 0,
      notificationId: taskNotificationId,
      notificationDate: taskNotificationDate,
    );

    Provider.of<TaskUseCase>(context, listen: false).createTask(taskModel: taskModel);
  }

  void _showScaffoldMessage(Color color, Color textColor, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        duration: const Duration(milliseconds: 1500),
        content: Text(
          message,
          style: TextStyle(
            fontSize: 18,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
