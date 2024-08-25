import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/state/task_data_state.dart';

class DeleteTaskDialog extends StatelessWidget {
  const DeleteTaskDialog({
    super.key,
    required this.taskId,
  });

  final int taskId;

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
              appLocale.deleteTaskContent,
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
                  Provider.of<TaskDataState>(context, listen: false).deleteTask(taskId: taskId);
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
