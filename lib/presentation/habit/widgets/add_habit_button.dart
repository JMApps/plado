import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/strings/app_constraints.dart';
import '../../../core/strings/database_values.dart';
import '../../../core/styles/app_styles.dart';
import '../../../data/services/notifications/notification_service.dart';
import '../../../data/state/habit_data_state.dart';
import '../../state/habit/habit_color_state.dart';
import '../../state/habit/habit_notification_date_state.dart';
import '../../state/habit/habit_notification_id_state.dart';
import '../../state/habit/habit_period_state.dart';
import '../../state/habit/habit_remind_state.dart';
import '../../state/habit/habit_title_state.dart';
import '../../state/rest_times_state.dart';

class AddHabitButton extends StatefulWidget {
  const AddHabitButton({super.key});

  @override
  State<AddHabitButton> createState() => _AddHabitButtonState();
}

class _AddHabitButtonState extends State<AddHabitButton> {
  final DateTime _currentDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    final appColors = Theme.of(context).colorScheme;
    return IconButton(
      onPressed: () {
        if (Provider.of<HabitTitleState>(context, listen: false).getHabitTitle.trim().isNotEmpty) {
          Navigator.of(context).pop();
          _createHabit(appLocale.habits);
        } else {
          _showScaffoldMessage(appColors.inversePrimary, appColors.onSurface, appLocale.enterHabitTitle);
        }
      },
      tooltip: appLocale.addHabit,
      icon: const Icon(Icons.check_circle_outlined),
    );
  }

  void _createHabit(String habits) {
    final String habitTitleState = context.read<HabitTitleState>().getHabitTitle.trim();
    final int habitPeriodIndex = context.read<HabitPeriodState>().getHabitPeriodIndex;
    final int habitColorIndex = context.read<HabitColorState>().getColorIndex;
    final bool habitIsRemind = context.read<HabitRemindState>().getIsRemind;
    int habitNotificationId = context.read<HabitNotificationIdState>().getNotificationId;
    final String habitDateTime = context.read<HabitNotificationDateState>().getHabitNotificationDate;
    final List<int> completeDays = List.generate(AppStyles.habitPeriodDayList[habitPeriodIndex], (index) => 0);

    Map<String, dynamic> restTimePeriods = Provider.of<RestTimesState>(context, listen: false).restHabitTimes(habitPeriodIndex);
    DateTime startTime = restTimePeriods[AppConstraints.habitStartDateTime];
    DateTime endTime = restTimePeriods[AppConstraints.habitEndDateTime];

    if (habitIsRemind) {
      final randomNotificationNumber = Random.secure().nextInt(AppConstraints.randomNotificationNumber);
      habitNotificationId = randomNotificationNumber;
      NotificationService().scheduleDailyNotifications(AppStyles.habitPeriodDayList[habitPeriodIndex], DateTime.parse(habitDateTime), habits, habitTitleState, randomNotificationNumber);
    }

    final Map<String, dynamic> habitMap = {
      DatabaseValues.dbHabitTitle: habitTitleState,
      DatabaseValues.dbHabitCreateDateTime: _currentDateTime.toIso8601String(),
      DatabaseValues.dbHabitCompleteDateTime: _currentDateTime.toIso8601String(),
      DatabaseValues.dbHabitStartDateTime: startTime.toIso8601String(),
      DatabaseValues.dbHabitEndDateTime: endTime.toIso8601String(),
      DatabaseValues.dbHabitPeriodIndex: habitPeriodIndex,
      DatabaseValues.dbHabitColorIndex: habitColorIndex,
      DatabaseValues.dbHabitCompletedDays: completeDays.toString(),
      DatabaseValues.dbHabitNotificationId: habitNotificationId,
      DatabaseValues.dbHabitNotificationDate: habitDateTime,
    };

    Provider.of<HabitDataState>(context, listen: false).createHabit(habitMap: habitMap);
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
