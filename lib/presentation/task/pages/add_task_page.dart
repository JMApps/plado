import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/strings/app_strings.dart';
import '../../../core/enums/task_period.dart';
import '../../../core/enums/task_priority.dart';
import '../../../core/enums/task_status.dart';
import '../../../core/styles/app_styles.dart';
import '../../../data/state/task_data_state.dart';
import '../../state/task_color_state.dart';
import '../../state/task_period_state.dart';
import '../../state/task_priority_state.dart';
import '../../widgets/main_back_button.dart';

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
  final _taskTextDescController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TaskPeriodState(),
        ),
        ChangeNotifierProvider(
          create: (_) => TaskPriorityState(),
        ),
        ChangeNotifierProvider(
          create: (_) => TaskColorState(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.addingTask),
          leading: const MainBackButton(),
        ),
        body: SingleChildScrollView(
          padding: AppStyles.padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _taskTextController,
                autofocus: true,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: AppStrings.taskHint,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _taskTextDescController,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  hintText: AppStrings.taskDescription,
                ),
              ),
              const SizedBox(height: 16),
              const Text(AppStrings.timeMode),
              const SizedBox(height: 8),
              Consumer<TaskPeriodState>(
                builder: (BuildContext context, taskPeriodState, _) {
                  return CupertinoSlidingSegmentedControl<TaskPeriod>(
                    groupValue: taskPeriodState.getTaskPeriod,
                    thumbColor: theme.colorScheme.onPrimary,
                    children: const <TaskPeriod, Widget>{
                      TaskPeriod.day: Text(AppStrings.day),
                      TaskPeriod.week: Text(AppStrings.week),
                      TaskPeriod.month: Text(AppStrings.month),
                      TaskPeriod.season: Text(AppStrings.season),
                      TaskPeriod.year: Text(AppStrings.year),
                    },
                    onValueChanged: (TaskPeriod? taskPeriod) {
                      taskPeriodState.setTaskPeriod = taskPeriod!;
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              const Text(AppStrings.priority),
              const SizedBox(height: 8),
              Consumer<TaskPriorityState>(
                builder: (BuildContext context, taskPriorityState, _) {
                  return CupertinoSlidingSegmentedControl<TaskPriority>(
                    groupValue: taskPriorityState.getTaskPriority,
                    thumbColor: theme.colorScheme.onPrimary,
                    children: const <TaskPriority, Widget>{
                      TaskPriority.low: Text(AppStrings.low),
                      TaskPriority.medium: Text(AppStrings.medium),
                      TaskPriority.high: Text(AppStrings.high),
                    },
                    onValueChanged: (TaskPriority? taskPriority) {
                      taskPriorityState.setTaskPriority = taskPriority!;
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              const Text(AppStrings.color),
              const SizedBox(height: 8),
              Consumer<TaskColorState>(
                builder: (BuildContext context, taskColorState, _) {
                  return GridView.builder(
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
                          taskColorState.setColorIndex = index;
                        },
                        child: CircleAvatar(
                          backgroundColor: AppStyles.tashabColors[index].withOpacity(theme.brightness == Brightness.light ? 1 : 0.5),
                          child: taskColorState.getColorIndex == index ? const Icon(Icons.check_rounded, color: Colors.black) : const SizedBox(),
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              Builder(
                builder: (context) {
                  return OutlinedButton(
                    onPressed: () {
                      if (_taskTextController.text.trim().isNotEmpty) {
                        Navigator.of(context).pop();
                        final Map<String, dynamic> taskMap = {
                          'task_title': _taskTextController.text.trim(),
                          'task_description': _taskTextDescController.text.trim(),
                          'start_date_time': DateTime.now().toIso8601String(),
                          'end_date_time': DateTime.now().toIso8601String(),
                          'task_period': context.read<TaskPeriodState>().getTaskPeriod.name,
                          'task_priority_index': context.read<TaskPriorityState>().getTaskPriority.index,
                          'task_status': TaskStatus.inProgress.name,
                          'task_color_index': context.read<TaskColorState>().getColorIndex,
                        };
                        context.read<TaskDataState>().createTask(taskMap: taskMap);
                      } else {
                        // Set edit text error
                      }
                    },
                    child: const Text(
                      AppStrings.add,
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
