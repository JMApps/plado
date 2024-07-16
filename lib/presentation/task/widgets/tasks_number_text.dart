import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/strings/app_constraints.dart';
import '../../../core/strings/app_strings.dart';
import '../../../data/state/task_data_state.dart';

class TasksNumberText extends StatelessWidget {
  const TasksNumberText({super.key, required this.taskPeriodIndex});

  final int taskPeriodIndex;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).colorScheme;
    return FutureBuilder(
      future: Provider.of<TaskDataState>(context).getTasksNumber(taskPeriodIndex: taskPeriodIndex),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Tooltip(
            message: AppStrings.tasksNumber,
            child: Padding(
              padding: const EdgeInsets.only(right: 8, top: 8),
              child: Text.rich(
                textAlign: TextAlign.end,
                TextSpan(
                  style: const TextStyle(
                    fontFamily: AppConstraints.fontRobotoSlab,
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      text: '${snapshot.data!.inProgress} / ',
                      style: TextStyle(color: appColors.error),
                    ),
                    TextSpan(
                      text: '${snapshot.data!.complete}',
                      style: TextStyle(color: appColors.primary),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
      },
    );
  }
}
