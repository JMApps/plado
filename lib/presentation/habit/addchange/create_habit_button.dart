import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../core/strings/app_constraints.dart';
import '../../../core/styles/app_styles.dart';
import '../../../data/models/habit_model.dart';
import '../../../data/services/notifications/notification_service.dart';
import '../../../domain/usecases/habit_use_case.dart';
import '../../state/habit/habit_color_state.dart';
import '../../state/habit/habit_notification_date_state.dart';
import '../../state/habit/habit_notification_id_state.dart';
import '../../state/habit/habit_period_state.dart';
import '../../state/habit/habit_remind_state.dart';
import '../../state/habit/habit_title_state.dart';
import '../../state/rest_times_state.dart';

class CreateHabitButton extends StatefulWidget {
  const CreateHabitButton({super.key});

  @override
  State<CreateHabitButton> createState() => _CreateHabitButtonState();
}

class _CreateHabitButtonState extends State<CreateHabitButton> {
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
          _showScaffoldMessage(appColors.inversePrimary, appColors.onSurface, appLocale.enterTitle);
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
    final String habitNotificationDate = context.read<HabitNotificationDateState>().getHabitNotificationDate;
    final List<int> completeDays = List.generate(AppStyles.habitPeriodDayList[habitPeriodIndex], (index) => 0);

    Map<String, dynamic> restTimePeriods = Provider.of<RestTimesState>(context, listen: false).restHabitTimes(habitPeriodIndex);
    DateTime startTime = restTimePeriods[AppConstraints.habitStartDateTime];
    DateTime endTime = restTimePeriods[AppConstraints.habitEndDateTime];

    if (habitIsRemind) {
      final randomNotificationNumber = Random.secure().nextInt(AppConstraints.randomNotificationNumber);
      habitNotificationId = randomNotificationNumber;
      NotificationService().scheduleDailyNotifications(AppStyles.habitPeriodDayList[habitPeriodIndex], DateTime.parse(habitNotificationDate), habits, habitTitleState, randomNotificationNumber);
    }

    final HabitModel habitModel = HabitModel(
      habitId: 0,
      habitTitle: habitTitleState,
      createDateTime: _currentDateTime,
      completeDateTime: _currentDateTime,
      startDateTime: startTime,
      endDateTime: endTime,
      habitPeriodIndex: habitPeriodIndex,
      habitColorIndex: habitColorIndex,
      completedDays: completeDays.toString(),
      notificationId: habitNotificationId,
      notificationDate: habitNotificationDate,
    );

    Provider.of<HabitUseCase>(context, listen: false).createHabit(habitModel: habitModel);
  }

  void _showScaffoldMessage(Color color, Color textColor, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        duration: const Duration(seconds: 1),
        content: Text(
          message,
          style: TextStyle(
            fontSize: 18,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
