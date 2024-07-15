import 'package:flutter/material.dart';
import 'package:plado/core/strings/app_constraints.dart';

import '../../../core/strings/app_strings.dart';
import '../../../core/styles/app_styles.dart';

class RestTimeIndicator extends StatelessWidget {
  const RestTimeIndicator({
    super.key,
    required this.remainingTime,
    required this.elapsedPercentage,
  });

  final String remainingTime;
  final double elapsedPercentage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                '${AppStrings.remaining} $remainingTime',
                style: const TextStyle(
                  fontSize: 17,
                  fontFamily: AppConstraints.fontRobotoSlab,
                ),
              ),
            ),
            Card(
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
