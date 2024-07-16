import 'package:flutter/material.dart';

import '../../core/strings/app_constraints.dart';

class MainBottomItemText extends StatelessWidget {
  const MainBottomItemText({
    super.key,
    required this.itemText,
  });

  final String itemText;

  @override
  Widget build(BuildContext context) {
    return Text(
      itemText,
      style: const TextStyle(
        fontFamily: AppConstraints.fontRaleway,
      ),
    );
  }
}
