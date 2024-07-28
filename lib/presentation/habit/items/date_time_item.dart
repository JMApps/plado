import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/strings/app_constraints.dart';

class DateTimeItem extends StatelessWidget {
  const DateTimeItem({
    super.key,
    required this.description,
    required this.dateTime,
    required this.dateFormat,
    required this.color,
  });

  final String description;
  final DateTime dateTime;
  final String dateFormat;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$description ${DateFormat(dateFormat).format(dateTime)}',
      style: TextStyle(
        fontFamily: AppConstraints.fontRobotoSlab,
        fontSize: 16,
        color: color,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}
