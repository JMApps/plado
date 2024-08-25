import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/strings/app_constraints.dart';
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
    final appLocale = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      padding: AppStyles.paddingWithoutTop,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '${appLocale.added} ${DateFormat(AppConstraints.dateTimeFormat).format(taskModel.createDateTime)}',
            style: const TextStyle(
              fontSize: 17,
              fontFamily: AppConstraints.fontRobotoSlab,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            _taskStatus(taskModel.taskStatusIndex, context),
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

  String _taskStatus(int taskStatus, BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    late String statusMessage;
    switch (taskStatus) {
      case 0:
        statusMessage = appLocale.inProgress;
        break;
      case 1:
        statusMessage = '${appLocale.completed}: ${DateFormat(AppConstraints.dateTimeFormat).format(taskModel.completeDateTime)}';
        break;
      case 2:
        statusMessage = appLocale.canceled;
    }
    return statusMessage;
  }
}
