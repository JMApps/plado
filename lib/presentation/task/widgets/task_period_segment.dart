import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/enums/task_period.dart';
import '../../../core/strings/app_strings.dart';
import '../../state/task/task_period_state.dart';

class TaskPeriodSegment extends StatelessWidget {
  const TaskPeriodSegment({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskPeriodState>(
      builder: (context, taskPeriodState, _) {
        return SegmentedButton(
          showSelectedIcon: false,
          segments: [
            ButtonSegment(
              value: TaskPeriod.day.index,
              label: const Text(AppStrings.day),
              tooltip: AppStrings.day,
            ),
            ButtonSegment(
              value: TaskPeriod.week.index,
              label: const Text(AppStrings.week),
              tooltip: AppStrings.week,
            ),
            ButtonSegment(
              value: TaskPeriod.month.index,
              label: const Text(AppStrings.month),
              tooltip: AppStrings.month,
            ),
            ButtonSegment(
              value: TaskPeriod.season.index,
              label: const Text(AppStrings.season),
              tooltip: AppStrings.season,
            ),
            ButtonSegment(
              value: TaskPeriod.year.index,
              label: const Text(AppStrings.year),
              tooltip: AppStrings.year,
            ),
          ],
          selected: {taskPeriodState.getTaskPeriodIndex},
          onSelectionChanged: (newIndex) {
            taskPeriodState.setTaskPeriodIndex = newIndex.first;
          },
        );
      },
    );
  }
}
