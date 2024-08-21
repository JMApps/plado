import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/strings/app_strings.dart';
import '../../state/habit/habit_notification_date_state.dart';
import '../../state/habit/habit_remind_state.dart';

class HabitRemindTime extends StatefulWidget {
  const HabitRemindTime({super.key});

  @override
  State<HabitRemindTime> createState() => _HabitRemindTimeState();
}

class _HabitRemindTimeState extends State<HabitRemindTime> {
  final DateTime _currentDateTime = DateTime.now();
  late DateTime _argDateTime;

  @override
  void initState() {
    super.initState();
    _argDateTime = DateTime.parse(Provider.of<HabitNotificationDateState>(context, listen: false).getHabitNotificationDate);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<HabitRemindState, HabitNotificationDateState>(
      builder: (context, habitRemindState, habitNotificationDateState, _) {
        return ListTile(
          contentPadding: EdgeInsets.zero,
          visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
          title: const Text(
            AppStrings.dailyHabitNotification,
            style: TextStyle(fontSize: 17),
          ),
          leading: IconButton(
            onPressed: habitRemindState.getIsRemind ? () async {
              final selectedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay(hour: _argDateTime.hour, minute: _argDateTime.minute),
                helpText: AppStrings.selectTime,
                hourLabelText: AppStrings.hours,
                minuteLabelText: AppStrings.minutes,
                cancelText: AppStrings.cancel,
                confirmText: AppStrings.select,
              );
              if (selectedTime != null) {
                _argDateTime = DateTime(_currentDateTime.year, _currentDateTime.month, _currentDateTime.day, selectedTime.hour, selectedTime.minute);
                habitNotificationDateState.setTaskNotificationDate = _argDateTime.toIso8601String();
              }
            } : null,
            icon: const Icon(
              Icons.access_time,
            ),
          ),
          trailing: Switch(
            value: habitRemindState.getIsRemind,
            onChanged: (bool onChanged) {
              habitRemindState.setIsRemind = onChanged;
            },
          ),
        );
      },
    );
  }
}
