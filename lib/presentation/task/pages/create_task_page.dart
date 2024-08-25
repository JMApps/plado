import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/styles/app_styles.dart';
import '../../state/task/task_color_state.dart';
import '../../state/task/task_notification_date_state.dart';
import '../../state/task/task_notification_id_state.dart';
import '../../state/task/task_period_state.dart';
import '../../state/task/task_priority_state.dart';
import '../../state/task/task_remind_state.dart';
import '../../state/task/task_title_state.dart';
import '../../widgets/main_back_button.dart';
import '../widgets/add_task_button.dart';
import '../widgets/task_color_list.dart';
import '../widgets/task_period_segment.dart';
import '../widgets/task_priority_segment.dart';
import '../widgets/task_remind_date_time.dart';
import '../widgets/task_text_field.dart';
import '../widgets/task_time_indicator.dart';
import '../widgets/text_description.dart';

class CreateTaskPage extends StatelessWidget {
  const CreateTaskPage({
    super.key,
    required this.taskPeriodIndex,
  });

  final int taskPeriodIndex;

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TaskTitleState(),
        ),
        ChangeNotifierProvider(
          create: (_) => TaskPeriodState(taskPeriodIndex),
        ),
        ChangeNotifierProvider(
          create: (_) => TaskPriorityState(),
        ),
        ChangeNotifierProvider(
          create: (_) => TaskColorState(),
        ),
        ChangeNotifierProvider(
          create: (_) => TaskRemindState(),
        ),
        ChangeNotifierProvider(
          create: (_) => TaskNotificationIdState(),
        ),
        ChangeNotifierProvider(
          create: (_) => TaskNotificationDateState(DateTime.now().toIso8601String()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(appLocale.addingTask),
          leading: const MainBackButton(),
          actions: const [
            AddTaskButton(),
          ],
        ),
        body: SingleChildScrollView(
          padding: AppStyles.padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const TaskTimeIndicator(),
              const SizedBox(height: 8),
              const Divider(indent: 16, endIndent: 16),
              const SizedBox(height: 8),
              const TaskTextField(),
              TextDescription(text: appLocale.timeInterval),
              const SizedBox(height: 8),
              const TaskPeriodSegment(),
              const SizedBox(height: 16),
              TextDescription(text: appLocale.priority),
              const SizedBox(height: 8),
              const TaskPrioritySegment(),
              const SizedBox(height: 16),
              TextDescription(text: appLocale.color),
              const SizedBox(height: 8),
              const TaskColorList(),
              const SizedBox(height: 8),
              const Divider(indent: 16, endIndent: 16),
              const TaskRemindDateTime(),
              const Divider(indent: 16, endIndent: 16),
            ],
          ),
        ),
      ),
    );
  }
}
