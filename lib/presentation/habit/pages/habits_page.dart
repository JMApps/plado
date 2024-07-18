import 'package:flutter/material.dart';

import '../../../core/routes/name_routes.dart';
import '../../../core/strings/app_strings.dart';
import '../lists/habit_list.dart';

class HabitsPage extends StatelessWidget {
  const HabitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.habits),
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
    );
  }
}
