import 'package:flutter/material.dart';

import '../../../core/strings/app_strings.dart';
import '../lists/static_habits_list.dart';

class StatisticHabitListPage extends StatelessWidget {
  const StatisticHabitListPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.allHabits),
      ),
      body: const StaticHabitsList(),
    );
  }
}
