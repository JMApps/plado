import 'package:flutter/material.dart';

import '../../../core/strings/app_constraints.dart';
import '../../../core/strings/app_strings.dart';
import '../../../core/styles/app_styles.dart';

class RestTimeIndicator extends StatelessWidget {
  const RestTimeIndicator({
    super.key,
    required this.remainingTime,
    required this.elapsedPercentage,
  });

  final Duration remainingTime;
  final double elapsedPercentage;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).colorScheme;

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
                    '${(elapsedPercentage - 100).toStringAsFixed(2)}%',
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
          value: elapsedPercentage / 100,
          minHeight: 7.5,
          borderRadius: AppStyles.border,
        ),
      ],
    );
  }
}
