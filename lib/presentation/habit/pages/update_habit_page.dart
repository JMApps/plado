import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/strings/app_strings.dart';
import '../../../core/styles/app_styles.dart';
import '../../../domain/entities/habit_entity.dart';
import '../../state/habit/habit_color_state.dart';
import '../../state/habit/habit_notification_date_state.dart';
import '../../state/habit/habit_notification_id_state.dart';
import '../../state/habit/habit_period_state.dart';
import '../../state/habit/habit_remind_state.dart';
import '../../state/habit/habit_title_state.dart';
import '../../task/widgets/text_description.dart';
import '../../widgets/main_back_button.dart';
import '../widgets/change_habit_button.dart';
import '../widgets/habit_color_list.dart';
import '../widgets/habit_period_segment.dart';
import '../widgets/habit_remind_time.dart';
import '../widgets/habit_text_field.dart';

class UpdateHabitPage extends StatelessWidget {
  const UpdateHabitPage({
    super.key,
    required this.habitModel,
  });

  final HabitEntity habitModel;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HabitTitleState(habitModel.habitTitle),
        ),
        ChangeNotifierProvider(
          create: (_) => HabitPeriodState(habitModel.habitPeriodIndex),
        ),
        ChangeNotifierProvider(
          create: (_) => HabitColorState(habitModel.habitColorIndex),
        ),
        ChangeNotifierProvider(
          create: (_) => HabitRemindState(habitModel.notificationId > 0 ? true : false),
        ),
        ChangeNotifierProvider(
          create: (_) => HabitNotificationIdState(habitModel.notificationId),
        ),
        ChangeNotifierProvider(
          create: (_) => HabitNotificationDateState(habitModel.notificationDate),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.addingHabit),
          leading: const MainBackButton(),
          actions: [
            ChangeHabitButton(habitId: habitModel.habitId),
          ],
        ),
        body: const SingleChildScrollView(
          padding: AppStyles.padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HabitTextField(),
              TextDescription(text: AppStrings.dayNumbers),
              SizedBox(height: 8),
              HabitPeriodSegment(),
              SizedBox(height: 16),
              TextDescription(text: AppStrings.color),
              SizedBox(height: 8),
              HabitColorList(),
              SizedBox(height: 16),
              HabitRemindTime(),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
