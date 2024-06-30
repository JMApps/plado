import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/strings/app_strings.dart';
import '../../../core/enums/task_period.dart';
import '../../../core/enums/task_priority.dart';
import '../../../core/styles/app_styles.dart';
import '../../../data/state/task_data_state.dart';
import '../../state/add_task_state.dart';
import '../../state/rest_times_state.dart';
import '../../widgets/main_back_button.dart';
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
          actions: const [
            TaskNotification(),
          ],
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
                      return Column(
                        children: [
                          Text('До конца дня осталось: '),
                          const SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: restTimesState.calculateElapsedDayPercentage() / 100,
                            minHeight: 15,
                            borderRadius: AppStyles.border,
                          ),
                        ],
                      );
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
                  const SizedBox(height: 8),
                  const Text(AppStrings.color),
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
                          addTaskState.setColorIndex = index;
                        },
                        child: CircleAvatar(
                          backgroundColor: AppStyles.tashabColors[index].withOpacity(theme.brightness == Brightness.light ? 1 : 0.5),
                          child: addTaskState.getColorIndex == index ? const Icon(Icons.check_rounded, color: Colors.black) : const SizedBox(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () {
                      if (_taskTextController.text.trim().isNotEmpty) {
                        final Map<String, dynamic> taskMap = {
                          'task_title': _taskTextController.text.trim(),
                          'start_date_time': DateTime.now().toIso8601String(),
                          'end_date_time': DateTime.now().toIso8601String(),
                          'task_period': addTaskState.getTaskPeriod.name,
                          'task_priority_index': addTaskState.getTaskPriority.index,
                          'task_status': addTaskState.getTaskStatus.name,
                          'task_color_index': addTaskState.getColorIndex,
                          'notification_id': 0,
                        };
                        Provider.of<TaskDataState>(context, listen: false).createTask(taskMap: taskMap);
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
                      if (_taskTextController.text.trim().isNotEmpty) {
                        Navigator.of(context).pop();
                        final Map<String, dynamic> taskMap = {
                          'task_title': _taskTextController.text.trim(),
                          'start_date_time': DateTime.now().toIso8601String(),
                          'end_date_time': DateTime.now().toIso8601String(),
                          'task_period': addTaskState.getTaskPeriod.name,
                          'task_priority_index': addTaskState.getTaskPriority.index,
                          'task_status': addTaskState.getTaskStatus.name,
                          'task_color_index': addTaskState.getColorIndex,
                          'notification_id': 0,
                        };
                        Provider.of<TaskDataState>(context, listen: false).createTask(taskMap: taskMap);
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
