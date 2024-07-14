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
import '../../state/create_task_state.dart';
import '../../state/rest_times_state.dart';
import '../../widgets/main_back_button.dart';
import '../widgets/rest_time_indicator.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({
    super.key,
    required this.taskPeriod,
  });

  final TaskPeriod taskPeriod;

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final _taskTextController = TextEditingController();
  DateTime _currentTime = DateTime.now();
  DateTime _selectedDate = DateTime.now();

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
          create: (_) => CreateTaskState(widget.taskPeriod),
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
          title: const Text(AppStrings.addingTask),
          leading: const MainBackButton(),
        ),
        body: SingleChildScrollView(
          padding: AppStyles.padding,
          child: Consumer<CreateTaskState>(
            builder: (context, createTaskState, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Consumer<RestTimesState>(
                    builder: (context, restTimesState, _) {
                      return RestTimeIndicator(
                        remainingTime: restTimesState.getRestTimeIndicator(createTaskState.getTaskPeriod)[AppConstraints.remainingTimeString],
                        elapsedPercentage: restTimesState.getRestTimeIndicator(createTaskState.getTaskPeriod)[AppConstraints.elapsedPercentage],
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
                    groupValue: createTaskState.getTaskPeriod,
                    thumbColor: appColors.onPrimary,
                    children: const <TaskPeriod, Widget>{
                      TaskPeriod.day: Text(AppStrings.day),
                      TaskPeriod.week: Text(AppStrings.week),
                      TaskPeriod.month: Text(AppStrings.month),
                      TaskPeriod.season: Text(AppStrings.season),
                      TaskPeriod.year: Text(AppStrings.year),
                    },
                    onValueChanged: (TaskPeriod? taskPeriod) {
                      createTaskState.setTaskPeriod = taskPeriod!;
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    AppStrings.priority,
                    style: TextStyle(fontSize: 17),
                  ),
                  const SizedBox(height: 8),
                  CupertinoSlidingSegmentedControl<TaskPriority>(
                    groupValue: createTaskState.getTaskPriority,
                    thumbColor: appColors.onPrimary,
                    children: const <TaskPriority, Widget>{
                      TaskPriority.low: Text(AppStrings.low),
                      TaskPriority.medium: Text(AppStrings.medium),
                      TaskPriority.high: Text(AppStrings.high),
                    },
                    onValueChanged: (TaskPriority? taskPriority) {
                      createTaskState.setTaskPriority = taskPriority!;
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
                          createTaskState.setColorIndex = index;
                        },
                        child: CircleAvatar(
                          backgroundColor: AppStyles.taskHabitColors[index].withOpacity(Theme.of(context).brightness == Brightness.light ? 1 : 0.5),
                          child: createTaskState.getColorIndex == index ? const Icon(Icons.check_rounded, color: Colors.black) : const SizedBox(),
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
                              onPressed: createTaskState.getIsRemind ? () async {
                                final selectedDate = await showDatePicker(
                                  context: context,
                                  helpText: AppStrings.selectDate,
                                  cancelText: AppStrings.cancel,
                                  confirmText: AppStrings.select,
                                  initialDate: _currentTime,
                                  firstDate: _currentTime,
                                  lastDate: restTimesState.getRestTimeIndicator(createTaskState.getTaskPeriod)[AppConstraints.dateTimeInterval],
                                );
                                if (selectedDate != null) {
                                  _selectedDate = selectedDate;
                                }
                              } : null,
                              icon: const Icon(Icons.date_range),
                              label: const Text(AppStrings.selectDate),
                            ),
                            TextButton.icon(
                              onPressed: createTaskState.getIsRemind ? () async {
                                final selectedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay(hour: _currentTime.hour, minute: _currentTime.minute),
                                  helpText: AppStrings.selectTime,
                                  hourLabelText: AppStrings.hours,
                                  minuteLabelText: AppStrings.minutes,
                                  cancelText: AppStrings.cancel,
                                  confirmText: AppStrings.select,
                                );
                                if (selectedTime != null) {
                                  _selectedDate = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day, selectedTime.hour, selectedTime.minute);
                                }
                                if (_selectedDate.isBefore(_currentTime)) {
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
                      value: createTaskState.getIsRemind,
                      onChanged: (bool onChanged) {
                        createTaskState.setIsRemind = onChanged;
                      },
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      if (_taskTextController.text.trim().isNotEmpty) {
                        if (createTaskState.getIsRemind) {
                          _currentTime = DateTime.now();
                          if (_selectedDate.isAfter(_currentTime)) {
                            _createTask(createTaskState);
                          } else {
                            _showScaffoldMessage(appColors.inversePrimary, appColors.onSurface, AppStrings.selectCorrectTime);
                          }
                        } else {
                          _createTask(createTaskState);
                        }
                      } else {
                        _showScaffoldMessage(appColors.inversePrimary, appColors.onSurface, AppStrings.enterTaskTitle);
                      }
                    },
                    child: const Text(
                      AppStrings.add,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () {
                      if (_taskTextController.text.trim().isNotEmpty) {
                        if (createTaskState.getIsRemind) {
                          _currentTime = DateTime.now();
                          if (_selectedDate.isAfter(_currentTime)) {
                            Navigator.of(context).pop();
                            _createTask(createTaskState);
                          } else {
                            _showScaffoldMessage(appColors.inversePrimary, appColors.onSurface, AppStrings.selectCorrectTime);
                          }
                        } else {
                          Navigator.of(context).pop();
                          _createTask(createTaskState);
                        }
                      } else {
                        _showScaffoldMessage(appColors.inversePrimary, appColors.onSurface, AppStrings.enterTaskTitle);
                      }
                    },
                    child: const Text(
                      AppStrings.addClose,
                      style: TextStyle(fontSize: 18),
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

  void _createTask(CreateTaskState createTaskState) {
    int notificationId = 0;

    if (createTaskState.getIsRemind) {
      final randomNotificationNumber = Random().nextInt(AppConstraints.randomNotificationNumber);
      notificationId = randomNotificationNumber;
      createTaskState.setTaskNotificationDate = _selectedDate.toIso8601String();
      NotificationService().futureNotification(_selectedDate, AppStrings.appName, _taskTextController.text.trim(), randomNotificationNumber);
    }

    final Map<String, dynamic> taskMap = {
      'task_title': _taskTextController.text.trim(),
      'start_date_time': _currentTime.toIso8601String(),
      'end_date_time': _currentTime.toIso8601String(),
      'task_period': createTaskState.getTaskPeriod.index,
      'task_priority_index': createTaskState.getTaskPriority.index,
      'task_status': createTaskState.getTaskStatus.index,
      'task_color_index': createTaskState.getColorIndex,
      'notification_id': notificationId,
      'notification_date': createTaskState.getIsRemind ? createTaskState.getTaskNotificationDate : '',
    };

    Provider.of<TaskDataState>(context, listen: false).createTask(taskMap: taskMap);

    _taskTextController.clear();
    createTaskState.setTaskNotificationDate = '';
    _selectedDate = _currentTime;
    createTaskState.setTaskPeriod = TaskPeriod.day;
    createTaskState.setTaskPriority = TaskPriority.low;
    createTaskState.setColorIndex = 0;
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
