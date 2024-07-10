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
  final _notificationService = NotificationService();
  DateTime _currentTime = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

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
    final taskDataState = Provider.of<TaskDataState>(context, listen: false);
    final appColors = Theme.of(context).colorScheme;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UpdateTaskState(
            taskPeriod: AppStyles.taskPeriodList[widget.taskModel.taskPeriodIndex],
            taskPriority: AppStyles.taskPriorityList[widget.taskModel.taskPriorityIndex],
            taskStatus: AppStyles.taskStatusList[widget.taskModel.taskStatusIndex],
            colorIndex: widget.taskModel.taskColorIndex,
            taskNotificationDate: DateTime.parse(widget.taskModel.notificationDate?? ''),
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
            builder: (BuildContext context, updateTaskState, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Consumer<RestTimesState>(
                    builder: (context, restTimesState, _) {
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
                              onPressed: updateTaskState.getIsRemind
                                  ? () async {
                                      _currentTime = DateTime.now();
                                      _currentTime = (await showDatePicker(
                                        context: context,
                                        helpText: AppStrings.selectDate,
                                        cancelText: AppStrings.cancel,
                                        confirmText: AppStrings.select,
                                        initialDate: _currentTime,
                                        firstDate: _currentTime,
                                        lastDate: restTimesState.getRestTimeIndicator(updateTaskState.getTaskPeriod)[AppConstraints.dateTimeInterval],
                                      ))!;
                                    }
                                  : null,
                              icon: const Icon(Icons.date_range),
                              label: const Text(AppStrings.selectDate),
                            ),
                            TextButton.icon(
                              onPressed: updateTaskState.getIsRemind
                                  ? () async {
                                      TimeOfDay now = TimeOfDay.now();
                                      _selectedTime = (await showTimePicker(
                                        context: context,
                                        initialTime: now,
                                        helpText: AppStrings.selectTime,
                                        hourLabelText: AppStrings.hours,
                                        minuteLabelText: AppStrings.minutes,
                                        cancelText: AppStrings.cancel,
                                        confirmText: AppStrings.select,
                                      ))!;
                                      if (!context.mounted) return;
                                      if (_selectedTime.hour < now.hour ||
                                          (_selectedTime.hour == now.hour && _selectedTime.minute < now.minute)) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(backgroundColor: appColors.inversePrimary,
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
                                    }
                                  : null,
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
                      },
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      if (_taskTextController.text.trim().isNotEmpty) {
                        _currentTime = DateTime.now();
                        final notificationId = Random().nextInt(1000000);
                        final Map<String, dynamic> taskMap = {
                          'task_title': _taskTextController.text.trim(),
                          'start_date_time': _currentTime.toIso8601String(),
                          'end_date_time': _currentTime.toIso8601String(),
                          'task_period': updateTaskState.getTaskPeriod.name,
                          'task_priority_index': updateTaskState.getTaskPriority.index,
                          'task_status': updateTaskState.getTaskStatus.name,
                          'task_color_index': updateTaskState.getColorIndex,
                          'notification_id': updateTaskState.getIsRemind ? notificationId : 0,
                        };
                        if (updateTaskState.getIsRemind) {
                          _notificationService.futureNotification(DateTime(_currentTime.year, _currentTime.month, _currentTime.day, _selectedTime.hour, _selectedTime.minute), AppStrings.appName, _taskTextController.text.trim(), notificationId);
                        }
                        taskDataState.createTask(taskMap: taskMap);
                        _taskTextController.clear();
                        updateTaskState.setTaskPeriod = TaskPeriod.day;
                        updateTaskState.setTaskPriority = TaskPriority.low;
                        updateTaskState.setColorIndex = 0;
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
                        _currentTime = DateTime.now();
                        final notificationId = Random().nextInt(1000000);
                        Navigator.of(context).pop();
                        final Map<String, dynamic> taskMap = {
                          'task_title': _taskTextController.text.trim(),
                          'start_date_time': _currentTime.toIso8601String(),
                          'end_date_time': _currentTime.toIso8601String(),
                          'task_period': updateTaskState.getTaskPeriod.name,
                          'task_priority_index': updateTaskState.getTaskPriority.index,
                          'task_status': updateTaskState.getTaskStatus.name,
                          'task_color_index': updateTaskState.getColorIndex,
                          'notification_id': updateTaskState.getIsRemind ? notificationId : 0,
                        };
                        if (updateTaskState.getIsRemind) {
                          _notificationService.futureNotification(DateTime(_currentTime.year, _currentTime.month, _currentTime.day, _selectedTime.hour, _selectedTime.minute), AppStrings.appName, _taskTextController.text.trim(), notificationId);
                        }
                        taskDataState.createTask(taskMap: taskMap);
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
}
