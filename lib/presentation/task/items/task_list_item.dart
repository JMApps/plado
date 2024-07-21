import 'package:flutter/material.dart';
import 'package:plado/core/styles/app_styles.dart';
import 'package:provider/provider.dart';

import '../../../core/enums/task_period.dart';
import '../../../core/strings/app_constraints.dart';
import '../../state/rest_times_state.dart';
import '../lists/day_task_list.dart';
import '../lists/month_task_list.dart';
import '../lists/season_task_list.dart';
import '../lists/week_task_list.dart';
import '../lists/year_task_list.dart';

class TaskListItem extends StatelessWidget {
  const TaskListItem({
    super.key,
    required this.taskPeriodIndex,
  });

  final int taskPeriodIndex;

  @override
  Widget build(BuildContext context) {
    final restTimeState = Provider.of<RestTimesState>(context);
    final startDate = restTimeState.restTaskTimes(taskPeriodIndex)[AppConstraints.startDateTime];
    final endDate = restTimeState.restTaskTimes(taskPeriodIndex)[AppConstraints.endDateTime];

    switch (AppStyles.taskPeriodList[taskPeriodIndex]) {
      case TaskPeriod.day:
        return DayTaskList(
          startDate: startDate,
          endDate: endDate,
        );
      case TaskPeriod.week:
        return WeekTaskList(
          startDate: startDate,
          endDate: endDate,
        );
      case TaskPeriod.month:
        return MonthTaskList(
          startDate: startDate,
          endDate: endDate,
        );
      case TaskPeriod.season:
        return SeasonTaskList(
          startDate: startDate,
          endDate: endDate,
        );
      case TaskPeriod.year:
        return YearTaskList(
          startDate: startDate,
          endDate: endDate,
        );
    }
  }
}
