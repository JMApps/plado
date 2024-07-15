import 'package:flutter/material.dart';
import 'package:plado/core/strings/app_constraints.dart';
import 'package:plado/core/styles/app_styles.dart';

class PercentTime extends StatelessWidget {
  const PercentTime({super.key, required this.percentage});

  final double percentage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    bool isLightTheme = theme.brightness == Brightness.light;
    return Padding(
      padding: AppStyles.paddingWithoutBottomMini,
      child: Row(
        children: [
          const SizedBox(width: 16),
          CircularProgressIndicator(
            backgroundColor: theme.colorScheme.error.withOpacity(0.25),
            valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.outline.withOpacity(isLightTheme ? 1 : 0.5)),
            strokeCap: StrokeCap.round,
            value: percentage / 100,
          ),
          const SizedBox(width: 4),
          Text(
            '${(-percentage / 100).toStringAsFixed(2)}%',
            style: const TextStyle(
              fontFamily: AppConstraints.fontRobotoSlab,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}
