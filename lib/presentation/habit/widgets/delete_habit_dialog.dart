import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/strings/app_strings.dart';
import '../../../data/state/habit_data_state.dart';

class DeleteHabitDialog extends StatelessWidget {
  const DeleteHabitDialog({
    super.key,
    required this.habitId,
  });

  final int habitId;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).colorScheme;
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(
              AppStrings.warning,
              style: TextStyle(
                color: appColors.error,
              ),
            ),
            content: const Text(
              AppStrings.deleteHabitContent,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            actions: [
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(AppStrings.cancel),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.of(context).pop;
                  Provider.of<HabitDataState>(context, listen: false).deleteHabit(habitId: habitId);
                },
                child: const Text(AppStrings.delete),
              ),
            ],
          ),
        );
      },
      icon: const Icon(Icons.delete_outline_rounded),
    );
  }
}
