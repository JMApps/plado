import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/styles/app_styles.dart';
import '../../../domain/entities/task_entity.dart';
import '../../state/task/task_color_state.dart';
import '../../state/task/task_notification_date_state.dart';
import '../../state/task/task_notification_id_state.dart';
import '../../state/task/task_priority_state.dart';
import '../../state/task/task_remind_state.dart';
import '../../state/task/task_title_state.dart';
import '../../widgets/main_back_button.dart';
import '../addchange/delete_task_dialog.dart';
import '../addchange/task_color_list.dart';
import '../addchange/task_priority_segment.dart';
import '../addchange/task_remind_date_time.dart';
import '../addchange/task_text_field.dart';
import '../addchange/update_task_button.dart';
import '../widgets/task_time_indicator.dart';
import '../../widgets/text_description.dart';

class UpdateTaskPage extends StatelessWidget {
  const UpdateTaskPage({
    super.key,
    required this.taskModel,
  });

  final TaskEntity taskModel;

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TaskTitleState(taskModel.taskTitle),
        ),
        ChangeNotifierProvider(
          create: (_) => TaskPriorityState(taskModel.taskPriorityIndex),
        ),
        ChangeNotifierProvider(
          create: (_) => TaskColorState(taskModel.taskColorIndex),
        ),
        ChangeNotifierProvider(
          create: (_) => TaskRemindState(taskModel.notificationId > 0 ? true : false),
        ),
        ChangeNotifierProvider(
          create: (_) => TaskNotificationIdState(taskModel.notificationId),
        ),
        ChangeNotifierProvider(
          create: (_) => TaskNotificationDateState(taskModel.notificationDate),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(appLocale.changingTask),
          leading: const MainBackButton(),
          actions: [
            DeleteTaskDialog(taskModel: taskModel),
            UpdateTaskButton(taskModel: taskModel),
          ],
        ),
        body: SingleChildScrollView(
          padding: AppStyles.padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TaskTimeIndicator(periodIndex: taskModel.taskPeriodIndex),
              const SizedBox(height: 16),
              const TaskTextField(),
              TextDescription(text: appLocale.priority),
              const SizedBox(height: 8),
              const TaskPrioritySegment(),
              const SizedBox(height: 16),
              TextDescription(text: appLocale.color),
              const SizedBox(height: 8),
              const TaskColorList(),
              const SizedBox(height: 16),
              TaskRemindDateTime(periodIndex: taskModel.taskPeriodIndex),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
