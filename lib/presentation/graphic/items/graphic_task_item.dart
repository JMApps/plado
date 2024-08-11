import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plado/core/strings/app_strings.dart';

import '../../../core/strings/app_constraints.dart';
import '../../../core/styles/app_styles.dart';
import '../../../domain/entities/task_entity.dart';

class GraphicTaskItem extends StatelessWidget {
  const GraphicTaskItem({
    super.key,
    required this.taskModel,
  });

  final TaskEntity taskModel;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).colorScheme;
    return Container(
      margin: AppStyles.paddingBottomMini,
      decoration: BoxDecoration(
        color: appColors.inversePrimary.withOpacity(0.15),
        borderRadius: AppStyles.border,
      ),
      child: ListTile(
        title: Text(taskModel.taskTitle),
        subtitle: Row(
          children: [
            Container(
              padding: AppStyles.paddingMicro,
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.5),
                borderRadius: AppStyles.borderMini,
              ),
              child: Text(
                DateFormat(AppConstraints.dateTimeFormat)
                    .format(taskModel.createDateTime),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: AppStyles.paddingMicro,
              decoration: BoxDecoration(
                color: Colors.teal.withOpacity(0.5),
                borderRadius: AppStyles.borderMini,
              ),
              child: Text(_taskStatusText(taskModel.taskStatusIndex)),
            ),
          ],
        ),
      ),
    );
  }

  String _taskStatusText(int taskStatusIndex) {
    late String statusText;
    switch (taskStatusIndex) {
      case 0:
        statusText = AppStrings.inProgress;
      case 1:
        statusText = AppStrings.complete;
        break;
      case 2:
        statusText = AppStrings.canceled;
        break;
    }
    return statusText;
  }
}
