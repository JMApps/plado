import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/styles/app_styles.dart';
import '../../../data/services/notifications/notification_service.dart';
import '../../../domain/entities/habit_entity.dart';
import '../../../domain/usecases/habit_use_case.dart';

class DeleteHabitDialog extends StatelessWidget {
  const DeleteHabitDialog({
    super.key,
    required this.habitModel,
  });

  final HabitEntity habitModel;

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    final appColors = Theme.of(context).colorScheme;
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(
              appLocale.warning,
              style: TextStyle(
                color: appColors.error,
              ),
            ),
            content: Text(
              appLocale.deleteHabitContent,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            actions: [
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(appLocale.cancel),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  if (habitModel.notificationId > 0) {
                    NotificationService().cancelNotificationWithCount(habitModel.notificationId, AppStyles.habitPeriodDayList[habitModel.habitPeriodIndex]);
                  }
                  Provider.of<HabitUseCase>(context, listen: false).deleteHabit(habitId: habitModel.habitId);
                },
                child: Text(
                  appLocale.delete,
                  style: TextStyle(
                    color: appColors.error,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      tooltip: appLocale.delete,
      icon: const Icon(Icons.delete_outline_rounded),
    );
  }
}
