import 'package:flutter/material.dart';

import '../../../core/styles/app_styles.dart';

class PercentTime extends StatelessWidget {
  const PercentTime({super.key, required this.percentage});

  final double percentage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    bool isLightTheme = theme.brightness == Brightness.light;
    return Padding(
      padding: AppStyles.paddingWithoutBottomMini,
      child: LinearProgressIndicator(
        backgroundColor: theme.colorScheme.inversePrimary.withOpacity(0.25),
        valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.outline.withOpacity(isLightTheme ? 1 : 0.5)),
        value: percentage / 100,
        borderRadius: BorderRadius.circular(25),
      ),
    );
  }
}
