import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/styles/app_styles.dart';
import '../../state/habit/habit_color_state.dart';
import '../../state/habit/habit_notification_date_state.dart';
import '../../state/habit/habit_notification_id_state.dart';
import '../../state/habit/habit_period_state.dart';
import '../../state/habit/habit_remind_state.dart';
import '../../state/habit/habit_title_state.dart';
import '../../widgets/text_description.dart';
import '../../widgets/main_back_button.dart';
import '../addchange/create_habit_button.dart';
import '../addchange/habit_color_list.dart';
import '../addchange/habit_period_segment.dart';
import '../addchange/habit_remind_time.dart';
import '../addchange/habit_text_field.dart';

class CreateHabitPage extends StatelessWidget {
  const CreateHabitPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
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
          title: Text(appLocale.addingHabit),
          leading: const MainBackButton(),
          actions: const [
            CreateHabitButton(),
          ],
        ),
        body: SingleChildScrollView(
          padding: AppStyles.padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const HabitTextField(),
              TextDescription(text: appLocale.dayNumbers),
              const SizedBox(height: 8),
              const HabitPeriodSegment(),
              const SizedBox(height: 16),
              const Divider(indent: 16, endIndent: 16),
              const SizedBox(height: 8),
              const HabitColorList(),
              const SizedBox(height: 8),
              const Divider(indent: 16, endIndent: 16),
              const HabitRemindTime(),
              const Divider(indent: 16, endIndent: 16),
            ],
          ),
        ),
      ),
    );
  }
}
