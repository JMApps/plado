import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/routes/name_routes.dart';
import '../lists/habit_list.dart';
import '../widgets/habit_sort_bottom_sheet.dart';

class HabitsPage extends StatelessWidget {
  const HabitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocale.habits),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) => const HabitSortBottomSheet(),
              );
            },
            tooltip: appLocale.sortHabits,
            icon: const Icon(Icons.sort),
          ),
        ],
      ),
      body: const HabitList(),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        tooltip: appLocale.addHabit,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(
            context,
            NameRoutes.createHabitPage,
          );
        },
      ),
    );
  }
}
