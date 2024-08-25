import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/enums/task_period.dart';
import '../../state/task/task_period_state.dart';

class TaskPeriodSegment extends StatelessWidget {
  const TaskPeriodSegment({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    return Consumer<TaskPeriodState>(
      builder: (context, taskPeriodState, _) {
        return SegmentedButton(
          showSelectedIcon: false,
          segments: [
            ButtonSegment(
              value: TaskPeriod.day.index,
              label: Text(appLocale.day),
              tooltip: appLocale.day,
            ),
            ButtonSegment(
              value: TaskPeriod.week.index,
              label: Text(appLocale.week),
              tooltip: appLocale.week,
            ),
            ButtonSegment(
              value: TaskPeriod.month.index,
              label: Text(appLocale.month),
              tooltip: appLocale.month,
            ),
            ButtonSegment(
              value: TaskPeriod.season.index,
              label: Text(appLocale.season),
              tooltip: appLocale.season,
            ),
            ButtonSegment(
              value: TaskPeriod.year.index,
              label: Text(appLocale.year),
              tooltip: appLocale.year,
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
