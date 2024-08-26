import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../core/enums/task_priority.dart';
import '../../state/task/task_priority_state.dart';

class TaskPrioritySegment extends StatelessWidget {
  const TaskPrioritySegment({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    return Consumer<TaskPriorityState>(
      builder: (context, taskPriorityState, _) {
        return SegmentedButton(
          segments: [
            ButtonSegment(
              value: TaskPriority.low.index,
              label: Text(
                appLocale.low,
                overflow: TextOverflow.ellipsis,
              ),
              tooltip: appLocale.low,
            ),
            ButtonSegment(
              value: TaskPriority.medium.index,
              label: Text(
                appLocale.medium,
                overflow: TextOverflow.ellipsis,
              ),
              tooltip: appLocale.medium,
            ),
            ButtonSegment(
              value: TaskPriority.high.index,
              label: Text(
                appLocale.high,
                overflow: TextOverflow.ellipsis,
              ),
              tooltip: appLocale.high,
            ),
          ],
          selected: {taskPriorityState.getTaskPriorityIndex},
          onSelectionChanged: (newIndex) {
            taskPriorityState.setTaskPriorityIndex = newIndex.first;
          },
        );
      },
    );
  }
}
