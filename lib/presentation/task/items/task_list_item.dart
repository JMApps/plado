import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/enums/task_period.dart';
import '../../../core/strings/app_constraints.dart';
import '../../../core/styles/app_styles.dart';
import '../../state/rest_times_state.dart';
import '../lists/tasks_main_list.dart';

class TaskListItem extends StatelessWidget {
  const TaskListItem({
    super.key,
    required this.taskPeriodIndex,
  });

  final int taskPeriodIndex;

  @override
  Widget build(BuildContext context) {
    final restTimeState = Provider.of<RestTimesState>(context).restTaskTimes(taskPeriodIndex);
    final startDate = restTimeState[AppConstraints.taskStartDateTime];
    final endDate = restTimeState[AppConstraints.taskEndDateTime];

    switch (AppStyles.taskPeriodList[taskPeriodIndex]) {
      case TaskPeriod.day:
        return TasksMainList(
          taskPeriodIndex: taskPeriodIndex,
          startDate: startDate,
          endDate: endDate,
        );
      case TaskPeriod.week:
        return TasksMainList(
          taskPeriodIndex: taskPeriodIndex,
          startDate: startDate,
          endDate: endDate,
        );
      case TaskPeriod.month:
        return TasksMainList(
          taskPeriodIndex: taskPeriodIndex,
          startDate: startDate,
          endDate: endDate,
        );
      case TaskPeriod.season:
        return TasksMainList(
          taskPeriodIndex: taskPeriodIndex,
          startDate: startDate,
          endDate: endDate,
        );
      case TaskPeriod.year:
        return TasksMainList(
          taskPeriodIndex: taskPeriodIndex,
          startDate: startDate,
          endDate: endDate,
        );
    }
  }
}
