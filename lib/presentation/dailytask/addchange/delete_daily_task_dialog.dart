import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/services/notifications/notification_service.dart';
import '../../../domain/entities/task_entity.dart';
import '../../../domain/usecases/task_use_case.dart';

class DeleteDailyTaskDialog extends StatefulWidget {
  const DeleteDailyTaskDialog({
    super.key,
    required this.taskModel,
  });

  final TaskEntity taskModel;

  @override
  State<DeleteDailyTaskDialog> createState() => _DeleteDailyTaskDialogState();
}

class _DeleteDailyTaskDialogState extends State<DeleteDailyTaskDialog> {
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
                  if (widget.taskModel.notificationId > 0) {
                    NotificationService().cancelNotificationWithId(widget.taskModel.notificationId);
                  }
                  Provider.of<TaskUseCase>(context, listen: false).deleteTask(taskId: widget.taskModel.taskId);
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
