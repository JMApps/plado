import 'package:flutter/material.dart';

import '../../../core/styles/app_styles.dart';

class RestTimeIndicator extends StatelessWidget {
  const RestTimeIndicator({
    super.key,
    required this.remainingTitle,
    required this.remainingTime,
    required this.elapsedPercentage,
  });

  final String remainingTitle;
  final String remainingTime;
  final double elapsedPercentage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$remainingTitle $remainingTime'),
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
