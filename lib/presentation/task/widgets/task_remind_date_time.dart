import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/strings/app_constraints.dart';
import '../../../core/styles/app_styles.dart';
import '../../state/rest_times_state.dart';
import '../../state/task/task_notification_date_state.dart';
import '../../state/task/task_period_state.dart';
import '../../state/task/task_remind_state.dart';
import '../../widgets/description_text.dart';

class TaskRemindDateTime extends StatefulWidget {
  const TaskRemindDateTime({super.key});

  @override
  State<TaskRemindDateTime> createState() => _TaskRemindDateTimeState();
}

class _TaskRemindDateTimeState extends State<TaskRemindDateTime> {
  final DateTime _currentDateTime = DateTime.now();
  late DateTime _argDateTime;

  @override
  void initState() {
    super.initState();
    _argDateTime = DateTime.parse(Provider.of<TaskNotificationDateState>(context, listen: false).getTaskNotificationDate);
  }

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    final appColors = Theme.of(context).colorScheme;
    return Consumer2<TaskRemindState, TaskNotificationDateState>(
      builder: (context, remindState, dateState, _) {
        return Column(
          children: [
            SwitchListTile(
              shape: AppStyles.shape,
              visualDensity: VisualDensity.comfortable,
              title: DescriptionText(text: appLocale.remind),
              value: remindState.getIsRemind,
              onChanged: (bool onChanged) {
                remindState.setIsRemind = onChanged;
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                  onPressed: remindState.getIsRemind ? () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      helpText: appLocale.selectDate,
                      cancelText: appLocale.cancel,
                      confirmText: appLocale.select,
                      initialDate: _currentDateTime,
                      firstDate: _currentDateTime,
                      lastDate: Provider.of<RestTimesState>(context, listen: false).restTaskTimes(context.read<TaskPeriodState>().getTaskPeriodIndex)[AppConstraints.taskEndDateTime],);
                    if (selectedDate != null) {
                      _argDateTime = selectedDate;dateState.setTaskNotificationDate = selectedDate.toIso8601String();
                    }
                  } : null,
                  icon: const Icon(Icons.date_range),
                  label: Text(appLocale.selectDate,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                TextButton.icon(
                  onPressed: remindState.getIsRemind ? () async {
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
                      _argDateTime = DateTime(_argDateTime.year, _argDateTime.month, _argDateTime.day, selectedTime.hour, selectedTime.minute);
                      dateState.setTaskNotificationDate = _argDateTime.toIso8601String();
                    }
                    if (_argDateTime.isBefore(_currentDateTime)) {
                      if (!context.mounted) return;
                      _showScaffoldMessage(appColors.inversePrimary, appColors.onSurface, appLocale.selectCorrectDateTime);}
                  } : null,
                  icon: const Icon(Icons.access_time),
                  label: Text(appLocale.selectTime,
                  style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _showScaffoldMessage(Color color, Color textColor, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        duration: const Duration(seconds: 1),
        content: Text(
          message,
          style: TextStyle(
            fontSize: 17,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
