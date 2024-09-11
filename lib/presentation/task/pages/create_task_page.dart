import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../core/styles/app_styles.dart';
import '../../../domain/entities/category_entity.dart';
import '../../state/task/task_color_state.dart';
import '../../state/task/task_notification_date_state.dart';
import '../../state/task/task_notification_id_state.dart';
import '../../state/task/task_priority_state.dart';
import '../../state/task/task_remind_state.dart';
import '../../state/task/task_title_state.dart';
import '../../widgets/main_back_button.dart';
import '../../widgets/text_description.dart';
import '../addchange/create_task_button.dart';
import '../addchange/task_color_list.dart';
import '../addchange/task_priority_segment.dart';
import '../addchange/task_remind_date_time.dart';
import '../addchange/task_text_field.dart';
import '../widgets/task_time_indicator.dart';

class CreateTaskPage extends StatelessWidget {
  const CreateTaskPage({
    super.key,
    required this.categoryModel,
  });

  final CategoryEntity categoryModel;

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TaskTitleState(),
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
          actions: [
            CreateTaskButton(categoryModel: categoryModel),
          ],
        ),
        body: SingleChildScrollView(
          padding: AppStyles.padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TaskTimeIndicator(periodIndex: categoryModel.categoryPeriodIndex),
              const SizedBox(height: 8),
              const Divider(indent: 16, endIndent: 16),
              const SizedBox(height: 8),
              const TaskTextField(),
              TextDescription(text: appLocale.priority),
              const SizedBox(height: 8),
              const TaskPrioritySegment(),
              const SizedBox(height: 16),
              TextDescription(text: appLocale.color),
              const SizedBox(height: 8),
              const TaskColorList(),
              const SizedBox(height: 8),
              const Divider(indent: 16, endIndent: 16),
              TaskRemindDateTime(periodIndex: categoryModel.categoryPeriodIndex),
              const Divider(indent: 16, endIndent: 16),
            ],
          ),
        ),
      ),
    );
  }
}
