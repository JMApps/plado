import 'package:flutter/material.dart';
import 'package:plado/core/styles/app_styles.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final appLocale = AppLocalizations.of(context)!;
    return Consumer2<HabitRemindState, HabitNotificationDateState>(
      builder: (context, habitRemindState, habitNotificationDateState, _) {
        return ListTile(
          visualDensity: VisualDensity.comfortable,
          shape: AppStyles.shape,
          onTap: habitRemindState.getIsRemind ? () async {
            final selectedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay(hour: _argDateTime.hour, minute: _argDateTime.minute),
              helpText: appLocale.selectTime,
              hourLabelText: appLocale.hours,
              minuteLabelText: appLocale.minutes,
              cancelText: appLocale.cancel,
              confirmText: appLocale.select,
            );
            if (selectedTime != null) {
              _argDateTime = DateTime(_currentDateTime.year, _currentDateTime.month, _currentDateTime.day, selectedTime.hour, selectedTime.minute);
              habitNotificationDateState.setTaskNotificationDate = _argDateTime.toIso8601String();
            }
          } : null,
          title: Text(
            appLocale.remindDaily,
            style: AppStyles.mainText,
          ),
          leading: const Icon(
            Icons.notifications_active_outlined,
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
