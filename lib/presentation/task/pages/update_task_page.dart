import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/strings/app_strings.dart';
import '../../../core/enums/task_period.dart';
import '../../../core/enums/task_priority.dart';
import '../../../core/strings/app_constraints.dart';
import '../../../core/styles/app_styles.dart';
import '../../../data/services/notifications/notification_service.dart';
import '../../../data/state/task_data_state.dart';
import '../../../domain/entities/task_entity.dart';
import '../../state/rest_times_state.dart';
import '../../state/update_task_state.dart';
import '../../widgets/main_back_button.dart';
import '../widgets/rest_time_indicator.dart';

class UpdateTaskPage extends StatefulWidget {
  const UpdateTaskPage({
    super.key,
    required this.taskModel,
  });

  final TaskEntity taskModel;

  @override
  State<UpdateTaskPage> createState() => _UpdateTaskPageState();
}

class _UpdateTaskPageState extends State<UpdateTaskPage> {
  late final TextEditingController _taskTextController;
  late DateTime _argDateTime;
  DateTime _currentDateTime = DateTime.now();
  late DateTime _startTime;
  late DateTime _endTime;

  @override
  void initState() {
    super.initState();
    _taskTextController = TextEditingController(text: widget.taskModel.taskTitle);
  }

  @override
  void dispose() {
    _taskTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).colorScheme;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UpdateTaskState(
            taskPeriodIndex: AppStyles.taskPeriodList[widget.taskModel.taskPeriodIndex],
            taskPriorityIndex: AppStyles.taskPriorityList[widget.taskModel.taskPriorityIndex],
            colorIndex: widget.taskModel.taskColorIndex,
            isRemind: widget.taskModel.notificationId > 0 ? true : false,
            notificationId: widget.taskModel.notificationId,
            taskNotificationDate: widget.taskModel.notificationDate,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => RestTimesState(
            day: AppStrings.shortDay,
            hour: AppStrings.shortHour,
            minute: AppStrings.shortMinute,
          ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.updatingTask),
          leading: const MainBackButton(),
        ),
        body: SingleChildScrollView(
          padding: AppStyles.padding,
          child: Consumer<UpdateTaskState>(
            builder: (context, updateTaskState, _) {
              if (widget.taskModel.notificationDate.isNotEmpty) {
                _argDateTime = DateTime.parse(widget.taskModel.notificationDate);
              } else {
                _argDateTime = DateTime.now();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Consumer<RestTimesState>(
                    builder: (context, restTimesState, _) {
                      _startTime = restTimesState.getRestTimeIndicator(updateTaskState.getTaskPeriod)[AppConstraints.startDateTime];
                      _endTime = restTimesState.getRestTimeIndicator(updateTaskState.getTaskPeriod)[AppConstraints.endDateTime];
                      return RestTimeIndicator(
                        remainingTime: restTimesState.getRestTimeIndicator(updateTaskState.getTaskPeriod)[AppConstraints.remainingTimeString],
                        elapsedPercentage: restTimesState.getRestTimeIndicator(updateTaskState.getTaskPeriod)[AppConstraints.elapsedPercentage],
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _taskTextController,
                    autofocus: true,
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    maxLength: 75,
                    decoration: const InputDecoration(
                      hintText: AppStrings.taskHint,
                    ),
                  ),
                  const Text(
                    AppStrings.timeMode,
                    style: TextStyle(fontSize: 17),
                  ),
                  const SizedBox(height: 8),
                  CupertinoSlidingSegmentedControl<TaskPeriod>(
                    groupValue: updateTaskState.getTaskPeriod,
                    thumbColor: appColors.onPrimary,
                    children: const <TaskPeriod, Widget>{
                      TaskPeriod.day: Text(AppStrings.day),
                      TaskPeriod.week: Text(AppStrings.week),
                      TaskPeriod.month: Text(AppStrings.month),
                      TaskPeriod.season: Text(AppStrings.season),
                      TaskPeriod.year: Text(AppStrings.year),
                    },
                    onValueChanged: (TaskPeriod? taskPeriod) {
                      updateTaskState.setTaskPeriod = taskPeriod!;
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    AppStrings.priority,
                    style: TextStyle(fontSize: 17),
                  ),
                  const SizedBox(height: 8),
                  CupertinoSlidingSegmentedControl<TaskPriority>(
                    groupValue: updateTaskState.getTaskPriority,
                    thumbColor: appColors.onPrimary,
                    children: const <TaskPriority, Widget>{
                      TaskPriority.low: Text(AppStrings.low),
                      TaskPriority.medium: Text(AppStrings.medium),
                      TaskPriority.high: Text(AppStrings.high),
                    },
                    onValueChanged: (TaskPriority? taskPriority) {
                      updateTaskState.setTaskPriority = taskPriority!;
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    AppStrings.color,
                    style: TextStyle(fontSize: 17),
                  ),
                  const SizedBox(height: 8),
                  GridView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 10,
                      crossAxisSpacing: 8,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          updateTaskState.setColorIndex = index;
                        },
                        child: CircleAvatar(
                          backgroundColor: AppStyles.taskHabitColors[index].withOpacity(Theme.of(context).brightness == Brightness.light ? 1 : 0.5),
                          child: updateTaskState.getColorIndex == index ? const Icon(Icons.check_rounded, color: Colors.black) : const SizedBox(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    AppStrings.remind,
                    style: TextStyle(fontSize: 17),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
                    title: Consumer<RestTimesState>(
                      builder: (context, restTimesState, _) {
                        return Row(
                          children: [
                            TextButton.icon(
                              onPressed: updateTaskState.getIsRemind ? () async {
                                final selectedDate = await showDatePicker(
                                  context: context,
                                  helpText: AppStrings.selectDate,
                                  cancelText: AppStrings.cancel,
                                  confirmText: AppStrings.select,
                                  initialDate: _argDateTime,
                                  firstDate: _currentDateTime,
                                  lastDate: _endTime,
                                );
                                if (selectedDate != null) {
                                  _argDateTime = selectedDate;
                                }
                              } : null,
                              icon: const Icon(Icons.date_range),
                              label: const Text(AppStrings.selectDate),
                            ),
                            TextButton.icon(
                              onPressed: updateTaskState.getIsRemind ? () async {
                                final selectedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay(hour: _argDateTime.hour, minute: _argDateTime.minute),
                                  helpText: AppStrings.selectTime,
                                  hourLabelText: AppStrings.hours,
                                  minuteLabelText: AppStrings.minutes,
                                  cancelText: AppStrings.cancel,
                                  confirmText: AppStrings.select,
                                );
                                if (selectedTime != null) {
                                  _argDateTime = DateTime(_argDateTime.year, _argDateTime.month, _argDateTime.day, selectedTime.hour, selectedTime.minute);
                                }
                                if (_argDateTime.isBefore(_currentDateTime)) {
                                  if (!context.mounted) return;
                                  _showScaffoldMessage(appColors.inversePrimary, appColors.onSurface, AppStrings.selectCorrectTime);
                                }
                              } : null,
                              icon: const Icon(Icons.access_time),
                              label: const Text(AppStrings.selectTime),
                            ),
                          ],
                        );
                      },
                    ),
                    trailing: Switch(
                      value: updateTaskState.getIsRemind,
                      onChanged: (bool onChanged) {
                        updateTaskState.setIsRemind = onChanged;
                        if (!onChanged) {
                          NotificationService().cancelNotificationWithId(widget.taskModel.notificationId);
                        }
                      },
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      if (_taskTextController.text.trim().isNotEmpty) {
                        if (updateTaskState.getIsRemind) {
                          _currentDateTime = DateTime.now();
                          if (_argDateTime.isAfter(_currentDateTime)) {
                            Navigator.of(context).pop();
                            _updateTask(updateTaskState);
                          } else {
                            _showScaffoldMessage(appColors.inversePrimary, appColors.onSurface, AppStrings.selectCorrectTime);
                          }
                        } else {
                          Navigator.of(context).pop();
                          _updateTask(updateTaskState);
                        }
                      } else {
                        _showScaffoldMessage(appColors.inversePrimary, appColors.onSurface, AppStrings.enterTaskTitle);
                      }
                    },
                    child: const Text(
                      AppStrings.change,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  OutlinedButton(onPressed: () {
                    Navigator.of(context).pop();
                    Provider.of<TaskDataState>(context, listen: false).deleteTask(taskId: widget.taskModel.taskId);
                  },
                    child: Text(AppStrings.delete,
                      style: TextStyle(
                        fontSize: 18,
                        color: appColors.error
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _updateTask(UpdateTaskState updateTaskState) {
    int notificationId = 0;

    if (updateTaskState.getIsRemind) {
      final randomNotificationNumber = Random().nextInt(AppConstraints.randomNotificationNumber);
      notificationId = randomNotificationNumber;
      updateTaskState.setTaskNotificationDate = _argDateTime.toIso8601String();
      NotificationService().futureNotification(_argDateTime, AppStrings.appName, _taskTextController.text.trim(), randomNotificationNumber);
    }

    final Map<String, dynamic> taskMap = {
      'task_title': _taskTextController.text.trim(),
      'start_date_time': _startTime.toIso8601String(),
      'end_date_time': _endTime.toIso8601String(),
      'task_period_index': updateTaskState.getTaskPeriod.index,
      'task_priority_index': updateTaskState.getTaskPriority.index,
      'task_color_index': updateTaskState.getColorIndex,
      'notification_id': notificationId,
      'notification_date': updateTaskState.getIsRemind ? updateTaskState.getTaskNotificationDate : '',
    };
    Provider.of<TaskDataState>(context, listen: false).updateTask(taskId: widget.taskModel.taskId, taskMap: taskMap);
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
