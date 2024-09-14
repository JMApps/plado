import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../core/styles/app_styles.dart';
import '../../state/task/task_notification_date_state.dart';
import '../../state/task/task_remind_state.dart';

class DailyTaskRemindDateTime extends StatefulWidget {
  const DailyTaskRemindDateTime({super.key});

  @override
  State<DailyTaskRemindDateTime> createState() =>
      _DailyTaskRemindDateTimeState();
}

class _DailyTaskRemindDateTimeState extends State<DailyTaskRemindDateTime> {
  DateTime _currentDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    return Consumer2<TaskRemindState, TaskNotificationDateState>(
      builder: (context, remindState, dateState, _) {
        return ListTile(
          shape: AppStyles.shape,
          visualDensity: VisualDensity.comfortable,
          contentPadding: EdgeInsets.zero,
          onTap: remindState.getIsRemind ? () async {
            final selectedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
              helpText: appLocale.selectTime,
              hourLabelText: appLocale.hours,
              minuteLabelText: appLocale.minutes,
              cancelText: appLocale.cancel,
              confirmText: appLocale.select,
            );
            if (selectedTime != null) {
              _currentDateTime = DateTime(_currentDateTime.year, _currentDateTime.month, _currentDateTime.day, selectedTime.hour, selectedTime.minute);
              dateState.setTaskNotificationDate = _currentDateTime.toIso8601String();
            }
          } : null,
          title: Text(
            appLocale.remindDaily,
            style: AppStyles.mainText,
          ),
          leading: const Icon(
            Icons.notifications_active_outlined,
            size: 30,
          ),
          trailing: Switch(
            value: remindState.getIsRemind,
            onChanged: (bool? onChanged) {
              remindState.setIsRemind = onChanged!;
            },
          ),
        );
      },
    );
  }
}
