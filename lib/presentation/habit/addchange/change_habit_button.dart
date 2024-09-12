import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/strings/app_constraints.dart';
import '../../../core/strings/database_values.dart';
import '../../../core/styles/app_styles.dart';
import '../../../data/services/notifications/notification_service.dart';
import '../../../domain/entities/habit_entity.dart';
import '../../../domain/usecases/habit_use_case.dart';
import '../../state/habit/habit_color_state.dart';
import '../../state/habit/habit_notification_date_state.dart';
import '../../state/habit/habit_notification_id_state.dart';
import '../../state/habit/habit_remind_state.dart';
import '../../state/habit/habit_title_state.dart';

class ChangeHabitButton extends StatefulWidget {
  const ChangeHabitButton({
    super.key,
    required this.habitModel,
  });

  final HabitEntity habitModel;

  @override
  State<ChangeHabitButton> createState() => _ChangeHabitButtonState();
}

class _ChangeHabitButtonState extends State<ChangeHabitButton> {
  final NotificationService _notificationService = NotificationService();

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    final appColors = Theme.of(context).colorScheme;
    return IconButton(
      onPressed: () {
        if (Provider.of<HabitTitleState>(context, listen: false).getHabitTitle.trim().isNotEmpty) {
          Navigator.of(context).pop();
          _updateHabit(appLocale.habits);
        } else {
          _showScaffoldMessage(appColors.inversePrimary, appColors.onSurface, appLocale.enterTitle);
        }
      },
      tooltip: appLocale.changingHabit,
      icon: const Icon(Icons.check_circle_outlined),
    );
  }

  void _updateHabit(String habits) {
    final String habitTitleState = context.read<HabitTitleState>().getHabitTitle.trim();
    final int habitColorIndex = context.read<HabitColorState>().getColorIndex;
    final bool habitIsRemind = context.read<HabitRemindState>().getIsRemind;
    int habitNotificationId = context.read<HabitNotificationIdState>().getNotificationId;
    final String habitNotificationDateTime = context.read<HabitNotificationDateState>().getHabitNotificationDate;

    if (habitIsRemind && habitNotificationId == 0) {
      final randomNotificationNumber = Random().nextInt(AppConstraints.randomNotificationNumber);
      habitNotificationId = randomNotificationNumber;
      _notificationService.scheduleDailyNotifications(AppStyles.habitPeriodDayList[widget.habitModel.habitPeriodIndex], DateTime.parse(habitNotificationDateTime), habits, habitTitleState, randomNotificationNumber);
    } else if (habitIsRemind && habitNotificationId > 0) {
      _notificationService.scheduleDailyNotifications(AppStyles.habitPeriodDayList[widget.habitModel.habitPeriodIndex], DateTime.parse(habitNotificationDateTime), habits, habitTitleState, habitNotificationId);
    } else {
      _notificationService.cancelNotificationWithCount(habitNotificationId, AppStyles.habitPeriodDayList[widget.habitModel.habitPeriodIndex]);
    }

    final Map<String, dynamic> habitMap = {
      DatabaseValues.dbHabitTitle: habitTitleState,
      DatabaseValues.dbHabitColorIndex: habitColorIndex,
      DatabaseValues.dbHabitNotificationId: habitNotificationId,
      DatabaseValues.dbHabitNotificationDate: habitNotificationDateTime,
    };

    Provider.of<HabitUseCase>(context, listen: false).updateHabit(habitId: widget.habitModel.habitId, habitMap: habitMap);
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
