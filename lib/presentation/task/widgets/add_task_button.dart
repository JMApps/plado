import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/enums/task_status.dart';
import '../../../core/strings/app_constraints.dart';
import '../../../core/strings/app_strings.dart';
import '../../../core/strings/database_values.dart';
import '../../../data/services/notifications/notification_service.dart';
import '../../../data/state/task_data_state.dart';
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
    final appColors = Theme.of(context).colorScheme;
    return IconButton(
      onPressed: () {
        if (Provider.of<TaskTitleState>(context, listen: false).getTaskTitle.trim().isNotEmpty) {
          if (Provider.of<TaskRemindState>(context, listen: false).getIsRemind) {
            _currentDateTime = DateTime.now();
            if (DateTime.parse(Provider.of<TaskNotificationDateState>(context, listen: false).getTaskNotificationDate).isAfter(_currentDateTime)) {
              Navigator.of(context).pop();
              _createTask();
            } else {
              _showScaffoldMessage(appColors.inversePrimary, appColors.onSurface, AppStrings.selectCorrectDateTime);
            }
          } else {
            Navigator.of(context).pop();
            _createTask();
          }
        } else {
          _showScaffoldMessage(appColors.inversePrimary, appColors.onSurface, AppStrings.enterTaskTitle);
        }
      },
      tooltip: AppStrings.addTask,
      icon: const Icon(Icons.check_circle_outlined),
    );
  }
  void _createTask() {
    final String taskTitleState = context.read<TaskTitleState>().getTaskTitle.trim();
    final int taskPeriodIndex = context.read<TaskPeriodState>().getTaskPeriodIndex;
    final int taskPriorityIndex = context.read<TaskPriorityState>().getTaskPriorityIndex;
    final int taskColorIndex = context.read<TaskColorState>().getColorIndex;
    final bool taskIsRemind = context.read<TaskRemindState>().getIsRemind;
    int taskNotificationId = context.read<TaskNotificationIdState>().getNotificationId;
    final String taskDateTime = context.read<TaskNotificationDateState>().getTaskNotificationDate;

    Map<String, dynamic> restTimePeriods = Provider.of<RestTimesState>(context, listen: false).restTaskTimes(taskPeriodIndex);
    DateTime startTime = restTimePeriods[AppConstraints.startTaskDateTime];
    DateTime endTime = restTimePeriods[AppConstraints.endTaskDateTime];

    if (taskIsRemind) {
      final randomNotificationNumber = Random().nextInt(AppConstraints.randomNotificationNumber);
      taskNotificationId = randomNotificationNumber;
      NotificationService().scheduleNotifications(DateTime.parse(taskDateTime), AppStrings.appName, taskTitleState, randomNotificationNumber);
    }

    final Map<String, dynamic> taskMap = {
      DatabaseValues.dbTaskTitle: taskTitleState,
      DatabaseValues.dbTaskCreateDateTime: _currentDateTime.toIso8601String(),
      DatabaseValues.dbTaskCompleteDateTime: _currentDateTime.toIso8601String(),
      DatabaseValues.dbTaskStartDateTime: startTime.toIso8601String(),
      DatabaseValues.dbTaskEndDateTime: endTime.toIso8601String(),
      DatabaseValues.dbTaskPeriodIndex: taskPeriodIndex,
      DatabaseValues.dbTaskPriorityIndex: taskPriorityIndex,
      DatabaseValues.dbTaskStatusIndex: TaskStatus.inProgress.index,
      DatabaseValues.dbTaskColorIndex: taskColorIndex,
      DatabaseValues.dbTaskNotificationId: taskNotificationId,
      DatabaseValues.dbTaskNotificationDate: taskDateTime,
    };

    Provider.of<TaskDataState>(context, listen: false).createTask(taskMap: taskMap);
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
