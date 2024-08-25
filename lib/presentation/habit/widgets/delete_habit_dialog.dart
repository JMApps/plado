import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/state/habit_data_state.dart';

class DeleteHabitDialog extends StatelessWidget {
  const DeleteHabitDialog({
    super.key,
    required this.habitId,
  });

  final int habitId;

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
                  Provider.of<HabitDataState>(context, listen: false).deleteHabit(habitId: habitId);
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
      icon: const Icon(Icons.delete_outline_rounded),
    );
  }
}
