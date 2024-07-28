import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/strings/app_constraints.dart';

class DateTimeItem extends StatelessWidget {
  const DateTimeItem({
    super.key,
    required this.description,
    required this.dateTime,
    required this.dateFormat,
  });

  final String description;
  final DateTime dateTime;
  final String dateFormat;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$description ${DateFormat(dateFormat).format(dateTime)}',
      style: const TextStyle(
        fontFamily: AppConstraints.fontRobotoSlab,
        fontSize: 14,
      ),
    );
  }
}
