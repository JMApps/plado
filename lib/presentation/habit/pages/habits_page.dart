import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/routes/name_routes.dart';
import '../../../core/strings/app_strings.dart';
import '../../../data/models/arguments/create_task_args.dart';
import '../../../data/state/habit_data_state.dart';
import '../../../domain/entities/habit_entity.dart';

class HabitsPage extends StatelessWidget {
  const HabitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.habits),
      ),
      body: FutureBuilder<List<HabitEntity>>(
        future: Provider.of<HabitDataState>(context).getAllHabits(orderBy: orderBy),
        builder: (context, snapshot) {
          return const SizedBox();
        },
      ),
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
