import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/strings/app_constraints.dart';
import '../../../core/strings/app_strings.dart';
import '../../../core/styles/app_styles.dart';
import '../../state/rest_times_state.dart';
import '../../state/task/task_period_state.dart';

class TaskTimeIndicator extends StatefulWidget {
  const TaskTimeIndicator({super.key});

  @override
  State<TaskTimeIndicator> createState() => _TaskTimeIndicatorState();
}

class _TaskTimeIndicatorState extends State<TaskTimeIndicator> {
  late double _elapsedPercentage;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).colorScheme;
    return Consumer2<RestTimesState, TaskPeriodState>(
      builder: (context, restTimeState, taskPeriodState, _) {
        Map<String, dynamic> restTimePeriods = restTimeState.restTaskTimes(taskPeriodState.getTaskPeriodIndex);
        Duration remainingTime = restTimePeriods[AppConstraints.taskRemaininDateTime];
        _elapsedPercentage = restTimePeriods[AppConstraints.taskElapsedPercentage];

        int days = remainingTime.inDays;
        int hours = remainingTime.inHours % 24;
        int minutes = remainingTime.inMinutes % 60;

        List<String> parts = [];

        if (days > 0) parts.add('$days ${AppStrings.shortDay}');
        if (hours > 0) parts.add('$hours ${AppStrings.shortHour}');
        if (minutes > 0) parts.add('$minutes ${AppStrings.shortMinute}');
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      style: const TextStyle(
                        fontFamily: AppConstraints.fontRobotoSlab,
                      ),
                      children: [
                        TextSpan(
                          text: '${AppStrings.remaining} ',
                          style: TextStyle(
                            color: appColors.onSurface,
                            fontSize: 17,
                          ),
                        ),
                        TextSpan(
                          text: parts.join(' '),
                          style: TextStyle(
                            color: appColors.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Tooltip(
                  message: AppStrings.remainingDayPercent,
                  child: Card(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    child: Padding(
                      padding: AppStyles.paddingHorizontalMini,
                      child: Text(
                        '${(_elapsedPercentage - 100).toStringAsFixed(2)}%',
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: AppConstraints.fontRobotoSlab,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: _elapsedPercentage / 100,
              minHeight: 5,
              borderRadius: AppStyles.border,
            ),
          ],
        );
      },
    );
  }
}
