import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/strings/app_constraints.dart';
import '../../../core/strings/app_strings.dart';
import '../../../core/styles/app_styles.dart';
import '../../../domain/entities/task_entity.dart';

class TaskStaticDetail extends StatelessWidget {
  const TaskStaticDetail({
    super.key,
    required this.taskModel,
  });

  final TaskEntity taskModel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppStyles.paddingWithoutTop,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '${AppStrings.added} ${DateFormat(AppConstraints.dateTimeFormat).format(taskModel.createDateTime)}',
            style: const TextStyle(
              fontSize: 17,
              fontFamily: AppConstraints.fontRobotoSlab,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            _taskStatus(taskModel.taskStatusIndex),
            style: const TextStyle(
              fontSize: 17,
              fontFamily: AppConstraints.fontRobotoSlab,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _taskStatus(int taskStatus) {
    late String statusMessage;
    switch (taskStatus) {
      case 0:
        statusMessage = AppStrings.inProgress;
        break;
      case 1:
        statusMessage = '${AppStrings.completed}: ${DateFormat(AppConstraints.dateTimeFormat).format(taskModel.completeDateTime)}';
        break;
      case 2:
        statusMessage = AppStrings.canceled;
    }
    return statusMessage;
  }
}
