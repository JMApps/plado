import 'package:flutter/material.dart';
import 'package:plado/data/state/task_data_state.dart';
import 'package:provider/provider.dart';

import '../../../../../core/strings/app_strings.dart';
import '../../../core/styles/app_styles.dart';
import '../../../domain/entities/task_entity.dart';
import '../../state/task/task_color_state.dart';
import '../../state/task/task_notification_date_state.dart';
import '../../state/task/task_notification_id_state.dart';
import '../../state/task/task_period_state.dart';
import '../../state/task/task_priority_state.dart';
import '../../state/task/task_remind_state.dart';
import '../../state/task/task_title_state.dart';
import '../../widgets/main_back_button.dart';
import '../widgets/change_task_button.dart';
import '../widgets/task_color_list.dart';
import '../widgets/task_period_segment.dart';
import '../widgets/task_priority_segment.dart';
import '../widgets/task_remind_date_time.dart';
import '../widgets/task_text_field.dart';
import '../widgets/task_time_indicator.dart';
import '../widgets/text_description.dart';

class UpdateTaskPage extends StatelessWidget {
  const UpdateTaskPage({
    super.key,
    required this.taskModel,
  });

  final TaskEntity taskModel;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).colorScheme;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TaskTitleState(taskModel.taskTitle),
        ),
        ChangeNotifierProvider(
          create: (_) => TaskPeriodState(taskModel.taskPeriodIndex),
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
          title: const Text(AppStrings.changingTask),
          leading: const MainBackButton(),
          actions: [
            IconButton(
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
                          Navigator.of(context).pop();
                          Provider.of<TaskDataState>(context, listen: false).deleteTask(taskId: taskModel.taskId);
                        },
                        child: const Text(AppStrings.delete),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.delete_outline_rounded),
            ),
            ChangeTaskButton(taskId: taskModel.taskId),
          ],
        ),
        body: const SingleChildScrollView(
          padding: AppStyles.padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TaskTimeIndicator(),
              SizedBox(height: 16),
              TaskTextField(),
              TextDescription(text: AppStrings.timeInterval),
              SizedBox(height: 8),
              TaskPeriodSegment(),
              SizedBox(height: 16),
              TextDescription(text: AppStrings.priority),
              SizedBox(height: 8),
              TaskPrioritySegment(),
              SizedBox(height: 16),
              TextDescription(text: AppStrings.color),
              SizedBox(height: 8),
              TaskColorList(),
              SizedBox(height: 16),
              TextDescription(text: AppStrings.remind),
              TaskRemindDateTime(),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
