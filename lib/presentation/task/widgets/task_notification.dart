import 'package:flutter/material.dart';

import '../../../core/strings/app_strings.dart';

class TaskNotification extends StatefulWidget {
  const TaskNotification({super.key});

  @override
  State<TaskNotification> createState() => _TaskNotificationState();
}

class _TaskNotificationState extends State<TaskNotification> {
  final DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: _dateTime,
          firstDate: _dateTime,
          lastDate: DateTime(_dateTime.year, 12, 31),
        );
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        final DateTime pickedDateTime = DateTime(
          pickedDate!.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime!.hour,
          pickedTime.minute,
        );
      },
      tooltip: AppStrings.remind,
      icon: const Icon(Icons.notifications_active_outlined),
    );
  }
}
