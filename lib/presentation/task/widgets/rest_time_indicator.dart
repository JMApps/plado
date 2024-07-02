import 'package:flutter/material.dart';
import 'package:plado/core/strings/app_strings.dart';

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
              child: Text('${AppStrings.remaining} $remainingTime'),
            ),
            Card(
              child: Padding(
                padding: AppStyles.paddingHorizontalMini,
                child: Text('${(elapsedPercentage - 100).toStringAsFixed(2)}%'),
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
