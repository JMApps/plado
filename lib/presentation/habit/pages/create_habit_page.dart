import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/strings/app_strings.dart';
import '../../../core/styles/app_styles.dart';
import '../../state/habit/habit_color_state.dart';
import '../../state/habit/habit_notification_date_state.dart';
import '../../state/habit/habit_notification_id_state.dart';
import '../../state/habit/habit_period_state.dart';
import '../../state/habit/habit_remind_state.dart';
import '../../state/habit/habit_title_state.dart';
import '../../task/widgets/text_description.dart';
import '../../widgets/main_back_button.dart';
import '../widgets/add_habit_button.dart';
import '../widgets/habit_color_list.dart';
import '../widgets/habit_period_segment.dart';
import '../widgets/habit_remind_time.dart';
import '../widgets/habit_text_field.dart';

class CreateHabitPage extends StatelessWidget {
  const CreateHabitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HabitTitleState(),
        ),
        ChangeNotifierProvider(
          create: (_) => HabitPeriodState(),
        ),
        ChangeNotifierProvider(
          create: (_) => HabitColorState(),
        ),
        ChangeNotifierProvider(
          create: (_) => HabitRemindState(),
        ),
        ChangeNotifierProvider(
          create: (_) => HabitNotificationIdState(),
        ),
        ChangeNotifierProvider(
          create: (_) => HabitNotificationDateState(DateTime.now().toIso8601String()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.addingHabit),
          leading: const MainBackButton(),
          actions: const [
            AddHabitButton(),
          ],
        ),
        body: const SingleChildScrollView(
          padding: AppStyles.padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HabitTextField(autofocusState: true),
              TextDescription(text: AppStrings.dayNumbers),
              SizedBox(height: 8),
              HabitPeriodSegment(),
              SizedBox(height: 16),
              Divider(indent: 16, endIndent: 16),
              SizedBox(height: 8),
              HabitColorList(),
              SizedBox(height: 8),
              Divider(indent: 16, endIndent: 16),
              HabitRemindTime(),
              Divider(indent: 16, endIndent: 16),
            ],
          ),
        ),
      ),
    );
  }
}
