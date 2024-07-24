import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/routes/name_routes.dart';
import '../../../core/strings/app_strings.dart';
import '../../state/habit/habit_color_state.dart';
import '../../state/habit/habit_notification_date_state.dart';
import '../../state/habit/habit_notification_id_state.dart';
import '../../state/habit/habit_period_state.dart';
import '../../state/habit/habit_title_state.dart';
import '../lists/habit_list.dart';
import '../widgets/habit_sort_bottom_sheet.dart';

class HabitsPage extends StatelessWidget {
  const HabitsPage({super.key});

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
          create: (_) => HabitNotificationIdState(),
        ),
        ChangeNotifierProvider(
          create: (_) => HabitNotificationDateState(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.habits),
          actions: [
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => const HabitSortBottomSheet(),
                );
              },
              tooltip: AppStrings.sortHabits,
              icon: const Icon(Icons.sort),
            ),
          ],
        ),
        body: const HabitList(),
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          tooltip: AppStrings.addingHabit,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(
              context,
              NameRoutes.createHabitPage,
            );
          },
        ),
      ),
    );
  }
}
