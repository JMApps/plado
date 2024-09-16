import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../core/enums/task_status.dart';
import '../../../core/strings/app_constraints.dart';
import '../../../data/models/task_model.dart';
import '../../../data/services/notifications/notification_service.dart';
import '../../../domain/entities/category_entity.dart';
import '../../../domain/usecases/category_use_case.dart';
import '../../../domain/usecases/task_use_case.dart';
import '../../state/rest_times_state.dart';
import '../../state/task/task_color_state.dart';
import '../../state/task/task_notification_date_state.dart';
import '../../state/task/task_notification_id_state.dart';
import '../../state/task/task_priority_state.dart';
import '../../state/task/task_remind_state.dart';
import '../../state/task/task_title_state.dart';

class CreateTaskButton extends StatefulWidget {
  const CreateTaskButton({
    super.key,
    required this.categoryModel,
  });

  final CategoryEntity categoryModel;

  @override
  State<CreateTaskButton> createState() => _CreateTaskButtonState();
}

class _CreateTaskButtonState extends State<CreateTaskButton> {
  DateTime _currentDateTime = DateTime.now();

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
              _createTask(appLocale.tasks);
            } else {
              _showScaffoldMessage(appColors.inversePrimary, appColors.onSurface, appLocale.selectCorrectDateTime);
            }
          } else {
            Navigator.of(context).pop();
            _createTask(appLocale.tasks);
          }
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

    Map<String, dynamic> restTimePeriods = Provider.of<RestTimesState>(context, listen: false).restCategoryTimes(widget.categoryModel.categoryPeriodIndex);
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
      taskPeriodIndex: widget.categoryModel.categoryPeriodIndex,
      taskStatusIndex: TaskStatus.inProgress.index,
      taskColorIndex: taskColorIndex,
      taskSampleBy: widget.categoryModel.categoryId,
      notificationId: taskNotificationId,
      notificationDate: taskNotificationDate,
    );

    Provider.of<TaskUseCase>(context, listen: false).createTask(taskModel: taskModel);
    Provider.of<CategoryUseCase>(context, listen: false).emptyNotify();
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
