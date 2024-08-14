import 'package:flutter/material.dart';

import '../../core/styles/app_styles.dart';

class DescriptionText extends StatelessWidget {
  const DescriptionText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppStyles.paddingMini,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
