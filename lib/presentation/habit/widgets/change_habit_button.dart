import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/strings/app_constraints.dart';
import '../../../core/strings/app_strings.dart';
import '../../../core/strings/database_values.dart';
import '../../../data/services/notifications/notification_service.dart';
import '../../../data/state/habit_data_state.dart';
import '../../state/habit/habit_color_state.dart';
import '../../state/habit/habit_notification_date_state.dart';
import '../../state/habit/habit_notification_id_state.dart';
import '../../state/habit/habit_period_state.dart';
import '../../state/habit/habit_remind_state.dart';
import '../../state/habit/habit_title_state.dart';
import '../../state/rest_times_state.dart';

class ChangeHabitButton extends StatefulWidget {
  const ChangeHabitButton({
    super.key,
    required this.habitId,
  });

  final int habitId;

  @override
  State<ChangeHabitButton> createState() => _ChangeHabitButtonState();
}

class _ChangeHabitButtonState extends State<ChangeHabitButton> {
  DateTime _currentDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).colorScheme;
    return IconButton(
      onPressed: () {
        if (Provider.of<HabitTitleState>(context, listen: false).getHabitTitle.trim().isNotEmpty) {
          if (Provider.of<HabitRemindState>(context, listen: false).getIsRemind) {
            _currentDateTime = DateTime.now();
            if (DateTime.parse(Provider.of<HabitNotificationDateState>(context, listen: false).getHabitNotificationDate).isAfter(_currentDateTime)) {
              Navigator.of(context).pop();
              _createHabit();
            } else {
              _showScaffoldMessage(appColors.inversePrimary, appColors.onSurface, AppStrings.selectCorrectDateTime);
            }
          } else {
            Navigator.of(context).pop();
            _createHabit();
          }
        } else {
          _showScaffoldMessage(appColors.inversePrimary, appColors.onSurface, AppStrings.enterHabitTitle);
        }
      },
      tooltip: AppStrings.changingHabit,
      icon: const Icon(Icons.check_circle_outlined),
    );
  }

  void _createHabit() {
    final String habitTitleState = context.read<HabitTitleState>().getHabitTitle.trim();
    final int habitPeriodIndex = context.read<HabitPeriodState>().getHabitPeriodIndex;
    final int habitColorIndex = context.read<HabitColorState>().getColorIndex;
    final bool habitIsRemind = context.read<HabitRemindState>().getIsRemind;
    int habitNotificationId = context.read<HabitNotificationIdState>().getNotificationId;
    final String habitDateTime = context.read<HabitNotificationDateState>().getHabitNotificationDate;

    Map<String, dynamic> restTimePeriods = Provider.of<RestTimesState>(context, listen: false).restHabitTimes(habitPeriodIndex);
    DateTime startTime = restTimePeriods[AppConstraints.taskStartDateTime];
    DateTime endTime = restTimePeriods[AppConstraints.taskEndDateTime];

    if (habitIsRemind) {
      final randomNotificationNumber = Random.secure().nextInt(AppConstraints.randomNotificationNumber);
      habitNotificationId = randomNotificationNumber;
      NotificationService().scheduleNotifications(DateTime.parse(habitDateTime), AppStrings.appName, habitTitleState, randomNotificationNumber);
    }

    final Map<String, dynamic> habitMap = {
      DatabaseValues.dbHabitTitle: habitTitleState,
      DatabaseValues.dbHabitCreateDateTime: _currentDateTime.toIso8601String(),
      DatabaseValues.dbHabitCompleteDateTime: _currentDateTime.toIso8601String(),
      DatabaseValues.dbHabitStartDateTime: startTime.toIso8601String(),
      DatabaseValues.dbHabitEndDateTime: endTime.toIso8601String(),
      DatabaseValues.dbHabitPeriodIndex: habitPeriodIndex,
      DatabaseValues.dbHabitColorIndex: habitColorIndex,
      DatabaseValues.dbHabitNotificationId: habitNotificationId,
      DatabaseValues.dbHabitNotificationDate: habitDateTime,
    };

    Provider.of<HabitDataState>(context, listen: false).updateHabit(habitId: widget.habitId, habitMap: habitMap);
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
