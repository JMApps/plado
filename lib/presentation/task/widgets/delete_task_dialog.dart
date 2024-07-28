import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/strings/app_strings.dart';
import '../../../data/state/task_data_state.dart';

class DeleteTaskDialog extends StatelessWidget {
  const DeleteTaskDialog({
    super.key,
    required this.taskId,
  });

  final int taskId;

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
              AppStrings.deleteTaskContent,
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
                  Navigator.pop(context);
                  Provider.of<TaskDataState>(context, listen: false).deleteTask(taskId: taskId);
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
