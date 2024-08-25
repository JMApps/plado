import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/strings/app_constraints.dart';
import '../../../core/strings/database_values.dart';
import '../../../data/services/notifications/notification_service.dart';
import '../../../data/state/habit_data_state.dart';
import '../../state/habit/habit_color_state.dart';
import '../../state/habit/habit_notification_date_state.dart';
import '../../state/habit/habit_notification_id_state.dart';
import '../../state/habit/habit_remind_state.dart';
import '../../state/habit/habit_title_state.dart';

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

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    final appColors = Theme.of(context).colorScheme;
    return IconButton(
      onPressed: () {
        if (Provider.of<HabitTitleState>(context, listen: false).getHabitTitle.trim().isNotEmpty) {
          Navigator.of(context).pop();
          _updateHabit(appLocale.appName);
        } else {
          _showScaffoldMessage(appColors.inversePrimary, appColors.onSurface, appLocale.enterHabitTitle);
        }
      },
      tooltip: appLocale.changingHabit,
      icon: const Icon(Icons.check_circle_outlined),
    );
  }

  void _updateHabit(String appName) {
    final String habitTitleState = context.read<HabitTitleState>().getHabitTitle.trim();
    final int habitColorIndex = context.read<HabitColorState>().getColorIndex;
    final bool habitIsRemind = context.read<HabitRemindState>().getIsRemind;
    int habitNotificationId = context.read<HabitNotificationIdState>().getNotificationId;
    final String habitDateTime = context.read<HabitNotificationDateState>().getHabitNotificationDate;

    if (habitIsRemind) {
      final randomNotificationNumber = Random.secure().nextInt(AppConstraints.randomNotificationNumber);
      habitNotificationId = randomNotificationNumber;
      NotificationService().scheduleNotifications(DateTime.parse(habitDateTime), appName, habitTitleState, randomNotificationNumber);
    }

    final Map<String, dynamic> habitMap = {
      DatabaseValues.dbHabitTitle: habitTitleState,
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
