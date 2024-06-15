import 'package:flutter/material.dart';

import '../../../../../core/strings/app_strings.dart';
import '../../widgets/fab_add_habit.dart';
import '../../widgets/main_back_button.dart';

class HabitsPage extends StatelessWidget {
  const HabitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.listHabits),
        leading: const MainBackButton(),
      ),
      body: Container(),
      floatingActionButton: const FabAddHabit(),
    );
  }
}
