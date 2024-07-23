import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/strings/app_constraints.dart';
import '../../../core/strings/app_strings.dart';
import '../../state/rest_times_state.dart';
import '../../state/task/task_notification_date_state.dart';
import '../../state/task/task_period_state.dart';
import '../../state/task/task_remind_state.dart';

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
    _argDateTime = DateTime.parse(context.read<TaskNotificationDateState>().getTaskNotificationDate);
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).colorScheme;
    return Consumer2<TaskRemindState, TaskNotificationDateState>(
      builder: (context, remindState, dateState, _) {
        return ListTile(
          contentPadding: EdgeInsets.zero,
          visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
          title: Row(
            children: [
              TextButton.icon(
                onPressed: remindState.getIsRemind ? () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    helpText: AppStrings.selectDate,
                    cancelText: AppStrings.cancel,
                    confirmText: AppStrings.select,
                    initialDate: _currentDateTime,
                    firstDate: _currentDateTime,
                    lastDate: Provider.of<RestTimesState>(context, listen: false).restTaskTimes(context.read<TaskPeriodState>().getTaskPeriodIndex)[AppConstraints.endDateTime],
                  );
                  if (selectedDate != null) {
                    _argDateTime = selectedDate;
                    dateState.setTaskNotificationDate = selectedDate.toIso8601String();
                  }
                } : null,
                icon: const Icon(Icons.date_range),
                label: const Text(AppStrings.selectDate),
              ),
              TextButton.icon(
                onPressed: remindState.getIsRemind ? () async {
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
                    _argDateTime = DateTime(_argDateTime.year, _argDateTime.month, _argDateTime.day, selectedTime.hour, selectedTime.minute);
                    dateState.setTaskNotificationDate = _argDateTime.toIso8601String();
                  }
                  if (_argDateTime.isBefore(_currentDateTime)) {
                    if (!context.mounted) return;
                    _showScaffoldMessage(appColors.inversePrimary, appColors.onSurface, AppStrings.selectCorrectDateTime);
                  }
                } : null,
                icon: const Icon(Icons.access_time),
                label: const Text(AppStrings.selectTime),
              ),
            ],
          ),
          trailing: Switch(
            value: remindState.getIsRemind,
            onChanged: (bool onChanged) {
              remindState.setIsRemind = onChanged;
            },
          ),
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
