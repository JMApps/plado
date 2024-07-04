import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/strings/app_strings.dart';
import '../../../core/enums/task_period.dart';
import '../../../core/enums/task_priority.dart';
import '../../../core/strings/app_constraints.dart';
import '../../../core/styles/app_styles.dart';
import '../../../data/state/task_data_state.dart';
import '../../state/add_task_state.dart';
import '../../state/rest_times_state.dart';
import '../../widgets/main_back_button.dart';
import '../widgets/rest_time_indicator.dart';
import '../widgets/task_notification.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({
    super.key,
    required this.timeModeIndex,
  });

  final int timeModeIndex;

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _taskTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AddTaskState(),
        ),
        ChangeNotifierProvider(
          create: (_) => RestTimesState(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.addingTask),
          leading: const MainBackButton(),
        ),
        body: SingleChildScrollView(
          padding: AppStyles.padding,
          child: Consumer<AddTaskState>(
            builder: (BuildContext context, addTaskState, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Consumer<RestTimesState>(
                    builder: (BuildContext context, restTimesState, _) {
                      late Widget restIndicator;
                      switch (addTaskState.getTaskPeriod.index) {
                        case 0:
                          restIndicator = RestTimeIndicator(
                            remainingTime: restTimesState.calculateElapsedDayPercentage()[AppConstraints.remainingTime],
                            elapsedPercentage: restTimesState.calculateElapsedDayPercentage()[AppConstraints.elapsedPercentage],
                          );
                          break;
                        case 1:
                          restIndicator = RestTimeIndicator(
                            remainingTime: restTimesState.calculateElapsedWeekPercentage()[AppConstraints.remainingTime],
                            elapsedPercentage: restTimesState.calculateElapsedWeekPercentage()[AppConstraints.elapsedPercentage],
                          );
                          break;
                        case 2:
                          restIndicator = RestTimeIndicator(
                            remainingTime: restTimesState.calculateElapsedMonthPercentage()[AppConstraints.remainingTime],
                            elapsedPercentage: restTimesState.calculateElapsedMonthPercentage()[AppConstraints.elapsedPercentage],
                          );
                          break;
                        case 3:
                          restIndicator = RestTimeIndicator(
                            remainingTime: restTimesState.calculateElapsedSeasonPercentage(restTimesState.getCurrentSeason())[AppConstraints.remainingTime],
                            elapsedPercentage: restTimesState.calculateElapsedSeasonPercentage(restTimesState.getCurrentSeason())[AppConstraints.elapsedPercentage],
                          );
                          break;
                        case 4:
                          restIndicator = RestTimeIndicator(
                            remainingTime: restTimesState.calculateElapsedYearPercentage()[AppConstraints.remainingTime],
                            elapsedPercentage: restTimesState.calculateElapsedYearPercentage()[AppConstraints.elapsedPercentage],
                          );
                          break;
                      }
                      return restIndicator;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _taskTextController,
                    textCapitalization: TextCapitalization.sentences,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    maxLength: 50,
                    decoration: const InputDecoration(
                      hintText: AppStrings.taskHint,
                    ),
                  ),
                  const Text(AppStrings.timeMode),
                  const SizedBox(height: 8),
                  CupertinoSlidingSegmentedControl<TaskPeriod>(
                    groupValue: addTaskState.getTaskPeriod,
                    thumbColor: theme.colorScheme.onPrimary,
                    children: const <TaskPeriod, Widget>{
                      TaskPeriod.day: Text(AppStrings.day),
                      TaskPeriod.week: Text(AppStrings.week),
                      TaskPeriod.month: Text(AppStrings.month),
                      TaskPeriod.season: Text(AppStrings.season),
                      TaskPeriod.year: Text(AppStrings.year),
                    },
                    onValueChanged: (TaskPeriod? taskPeriod) {
                      addTaskState.setTaskPeriod = taskPeriod!;
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(AppStrings.priority),
                  const SizedBox(height: 8),
                  CupertinoSlidingSegmentedControl<TaskPriority>(
                    groupValue: addTaskState.getTaskPriority,
                    thumbColor: theme.colorScheme.onPrimary,
                    children: const <TaskPriority, Widget>{
                      TaskPriority.low: Text(AppStrings.low),
                      TaskPriority.medium: Text(AppStrings.medium),
                      TaskPriority.high: Text(AppStrings.high),
                    },
                    onValueChanged: (TaskPriority? taskPriority) {
                      addTaskState.setTaskPriority = taskPriority!;
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(AppStrings.color),
                  const SizedBox(height: 8),
                  GridView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 10,
                      crossAxisSpacing: 8,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          addTaskState.setColorIndex = index;
                        },
                        child: CircleAvatar(
                          backgroundColor: AppStyles.tashabColors[index]
                              .withOpacity(theme.brightness == Brightness.light
                              ? 1
                              : 0.5),
                          child: addTaskState.getColorIndex == index
                              ? const Icon(Icons.check_rounded,
                              color: Colors.black)
                              : const SizedBox(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () {
                      if (_taskTextController.text
                          .trim()
                          .isNotEmpty) {
                        final Map<String, dynamic> taskMap = {
                          'task_title': _taskTextController.text.trim(),
                          'start_date_time': DateTime.now().toIso8601String(),
                          'end_date_time': DateTime.now().toIso8601String(),
                          'task_period': addTaskState.getTaskPeriod.name,
                          'task_priority_index': addTaskState.getTaskPriority
                              .index,
                          'task_status': addTaskState.getTaskStatus.name,
                          'task_color_index': addTaskState.getColorIndex,
                          'notification_id': 0,
                        };
                        Provider.of<TaskDataState>(context, listen: false)
                            .createTask(taskMap: taskMap);
                        _taskTextController.clear();
                        addTaskState.setTaskPeriod = TaskPeriod.day;
                        addTaskState.setTaskPriority = TaskPriority.low;
                        addTaskState.setColorIndex = 0;
                      } else {
                        // Set edit text error
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
                      if (_taskTextController.text
                          .trim()
                          .isNotEmpty) {
                        Navigator.of(context).pop();
                        final Map<String, dynamic> taskMap = {
                          'task_title': _taskTextController.text.trim(),
                          'start_date_time': DateTime.now().toIso8601String(),
                          'end_date_time': DateTime.now().toIso8601String(),
                          'task_period': addTaskState.getTaskPeriod.name,
                          'task_priority_index':
                          addTaskState.getTaskPriority.index,
                          'task_status': addTaskState.getTaskStatus.name,
                          'task_color_index': addTaskState.getColorIndex,
                          'notification_id': 0,
                        };
                        Provider.of<TaskDataState>(context, listen: false)
                            .createTask(taskMap: taskMap);
                      } else {
                        // Set edit text error
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
