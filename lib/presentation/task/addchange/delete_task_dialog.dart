import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/services/notifications/notification_service.dart';
import '../../../domain/entities/task_entity.dart';
import '../../../domain/usecases/category_use_case.dart';
import '../../../domain/usecases/task_use_case.dart';

class DeleteTaskDialog extends StatefulWidget {
  const DeleteTaskDialog({
    super.key,
    required this.taskModel,
  });

  final TaskEntity taskModel;

  @override
  State<DeleteTaskDialog> createState() => _DeleteTaskDialogState();
}

class _DeleteTaskDialogState extends State<DeleteTaskDialog> {
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
                  Provider.of<CategoryUseCase>(context, listen: false).emptyNotify();
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
