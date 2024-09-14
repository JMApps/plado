import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plado/core/styles/app_styles.dart';

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
      '$description\n${DateFormat(dateFormat).format(dateTime)}',
      style: AppStyles.mainTextRoboto,
      textAlign: TextAlign.center,
    );
  }
}
