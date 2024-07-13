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
  DateTime _selectedDate = DateTime.now();
  DateTime _currentDateTime = DateTime.now();

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
                                  initialDate: _currentDateTime,
                                  firstDate: _currentDateTime,
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
                                  initialTime: TimeOfDay(hour: _currentDateTime.hour, minute: _currentDateTime.minute),
                                  helpText: AppStrings.selectTime,
                                  hourLabelText: AppStrings.hours,
                                  minuteLabelText: AppStrings.minutes,
                                  cancelText: AppStrings.cancel,
                                  confirmText: AppStrings.select,
                                );
                                if (selectedTime != null) {
                                  _selectedDate = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day, selectedTime.hour, selectedTime.minute);
                                }
                                if (!context.mounted) return;
                                if (_selectedDate.hour < _currentDateTime.hour || (_selectedDate.hour == _currentDateTime.hour && _selectedDate.minute <= _currentDateTime.minute)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: appColors.inversePrimary,
                                      content: Text(
                                        AppStrings.selectCorrectTime,
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: appColors.onSurface,
                                        ),
                                      ),
                                    ),
                                  );
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
                          _currentDateTime = DateTime.now();
                          if (_selectedDate.hour >= _currentDateTime.hour && _selectedDate.minute > _currentDateTime.minute) {
                            final notificationId = Random().nextInt(AppConstraints.randomNotificationNumber);
                            _createTask(createTaskState, notificationId);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: appColors.inversePrimary,
                                content: Text(
                                  AppStrings.selectCorrectTime,
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: appColors.onSurface,
                                  ),
                                ),
                              ),
                            );
                          }
                        } else {
                          _createTask(createTaskState);
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: appColors.inversePrimary,
                            duration: const Duration(milliseconds: 350),
                            content: Text(
                              AppStrings.enterTaskTitle,
                              style: TextStyle(
                                fontSize: 17,
                                color: appColors.onSurface,
                              ),
                            ),
                          ),
                        );
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
                          _currentDateTime = DateTime.now();
                          if (_selectedDate.hour >= _currentDateTime.hour && _selectedDate.minute > _currentDateTime.minute) {
                            Navigator.of(context).pop();
                            final notificationId = Random().nextInt(AppConstraints.randomNotificationNumber);
                            _createTask(createTaskState, notificationId);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: appColors.inversePrimary,
                                content: Text(
                                  AppStrings.selectCorrectTime,
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: appColors.onSurface,
                                  ),
                                ),
                              ),
                            );
                          }
                        } else {
                          Navigator.of(context).pop();
                          _createTask(createTaskState);
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: appColors.inversePrimary,
                            duration: const Duration(milliseconds: 350),
                            content: Text(
                              AppStrings.enterTaskTitle,
                              style: TextStyle(
                                fontSize: 17,
                                color: appColors.onSurface,
                              ),
                            ),
                          ),
                        );
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

  _createTask(CreateTaskState createTaskState, [int notificationId = 0]) {
    if (createTaskState.getIsRemind) {
      createTaskState.setTaskNotificationDate = _selectedDate.toIso8601String();
      NotificationService().futureNotification(DateTime.parse(createTaskState.getTaskNotificationDate), AppStrings.appName, _taskTextController.text.trim(), notificationId);
    }
    final Map<String, dynamic> taskMap = {
      'task_title': _taskTextController.text.trim(),
      'start_date_time': _currentDateTime.toIso8601String(),
      'end_date_time': _currentDateTime.toIso8601String(),
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
    _selectedDate = _currentDateTime;
    createTaskState.setTaskPeriod = TaskPeriod.day;
    createTaskState.setTaskPriority = TaskPriority.low;
    createTaskState.setColorIndex = 0;
    createTaskState.setIsRemind = false;
  }
}
