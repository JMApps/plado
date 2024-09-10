import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:plado/data/models/task_model.dart';
import 'package:provider/provider.dart';

import '../../../core/enums/task_status.dart';
import '../../../core/strings/app_constraints.dart';
import '../../../data/services/notifications/notification_service.dart';
import '../../../domain/usecases/task_use_case.dart';
import '../../state/rest_times_state.dart';
import '../../state/task/task_color_state.dart';
import '../../state/task/task_notification_date_state.dart';
import '../../state/task/task_notification_id_state.dart';
import '../../state/task/task_period_state.dart';
import '../../state/task/task_priority_state.dart';
import '../../state/task/task_remind_state.dart';
import '../../state/task/task_title_state.dart';

class AddTaskButton extends StatefulWidget {
  const AddTaskButton({super.key});

  @override
  State<AddTaskButton> createState() => _AddTaskButtonState();
}

class _AddTaskButtonState extends State<AddTaskButton> {
  DateTime _currentDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    final appColors = Theme.of(context).colorScheme;
    return IconButton(
      onPressed: () {
        if (Provider.of<TaskTitleState>(context, listen: false)
            .getTaskTitle
            .trim()
            .isNotEmpty) {
          if (Provider.of<TaskRemindState>(context, listen: false)
              .getIsRemind) {
            _currentDateTime = DateTime.now();
            if (DateTime.parse(Provider.of<TaskNotificationDateState>(context,
                        listen: false)
                    .getTaskNotificationDate)
                .isAfter(_currentDateTime)) {
              Navigator.of(context).pop();
              _createTask(appLocale.tasks);
            } else {
              _showScaffoldMessage(appColors.inversePrimary,
                  appColors.onSurface, appLocale.selectCorrectDateTime);
            }
          } else {
            Navigator.of(context).pop();
            _createTask(appLocale.tasks);
          }
        } else {
          _showScaffoldMessage(appColors.inversePrimary, appColors.onSurface,
              appLocale.enterTitle);
        }
      },
      tooltip: appLocale.addTask,
      icon: const Icon(Icons.check_circle_outlined),
    );
  }

  void _createTask(String tasks) {
    final String taskTitleState =
        context.read<TaskTitleState>().getTaskTitle.trim();
    final int taskPeriodIndex =
        context.read<TaskPeriodState>().getTaskPeriodIndex;
    final int taskPriorityIndex =
        context.read<TaskPriorityState>().getTaskPriorityIndex;
    final int taskColorIndex = context.read<TaskColorState>().getColorIndex;
    final bool taskIsRemind = context.read<TaskRemindState>().getIsRemind;
    int taskNotificationId =
        context.read<TaskNotificationIdState>().getNotificationId;
    final String taskDateTime =
        context.read<TaskNotificationDateState>().getTaskNotificationDate;

    Map<String, dynamic> restTimePeriods =
        Provider.of<RestTimesState>(context, listen: false)
            .restTaskTimes(taskPeriodIndex);
    DateTime startTime = restTimePeriods[AppConstraints.taskStartDateTime];
    DateTime endTime = restTimePeriods[AppConstraints.taskEndDateTime];

    if (taskIsRemind) {
      final randomNotificationNumber =
          Random().nextInt(AppConstraints.randomNotificationNumber);
      taskNotificationId = randomNotificationNumber;
      NotificationService().scheduleTimeNotifications(
          DateTime.parse(taskDateTime),
          tasks,
          taskTitleState,
          randomNotificationNumber);
    }

    final TaskModel taskModel = TaskModel(
      taskId: 0,
      taskTitle: taskTitleState,
      createDateTime: _currentDateTime,
      completeDateTime: _currentDateTime,
      startDateTime: startTime,
      endDateTime: endTime,
      taskPeriodIndex: taskPeriodIndex,
      taskPriorityIndex: taskPriorityIndex,
      taskStatusIndex: TaskStatus.inProgress.index,
      taskColorIndex: taskColorIndex,
      taskSampleBy: 0,
      notificationId: taskNotificationId,
      notificationDate: taskDateTime,
    );

    Provider.of<TaskUseCase>(context, listen: false).createTask(taskModel: taskModel);
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
