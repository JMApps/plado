import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

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
              label: Text(
                appLocale.day,
                overflow: TextOverflow.fade,
              ),
              tooltip: appLocale.day,
            ),
            ButtonSegment(
              value: TaskPeriod.week.index,
              label: Text(
                appLocale.week,
                overflow: TextOverflow.fade,
              ),
              tooltip: appLocale.week,
            ),
            ButtonSegment(
              value: TaskPeriod.month.index,
              label: Text(
                appLocale.month,
                overflow: TextOverflow.fade,
              ),
              tooltip: appLocale.month,
            ),
            ButtonSegment(
              value: TaskPeriod.season.index,
              label: Text(
                appLocale.season,
                overflow: TextOverflow.fade,
              ),
              tooltip: appLocale.season,
            ),
            ButtonSegment(
              value: TaskPeriod.year.index,
              label: Text(
                appLocale.year,
                overflow: TextOverflow.ellipsis,
              ),
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
