import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/enums/habit_period.dart';
import '../../../core/strings/app_strings.dart';
import '../../state/habit/habit_period_state.dart';

class HabitPeriodSegment extends StatelessWidget {
  const HabitPeriodSegment({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HabitPeriodState>(
      builder: (context, habitPeriodState, _) {
        return SegmentedButton(
          showSelectedIcon: false,
          segments: [
            ButtonSegment(
              value: HabitPeriod.days21.index,
              label: const Text(AppStrings.days21),
              tooltip: AppStrings.days21,
            ),
            ButtonSegment(
              value: HabitPeriod.days40.index,
              label: const Text(AppStrings.days40),
              tooltip: AppStrings.days40,
            ),
            ButtonSegment(
              value: HabitPeriod.days66.index,
              label: const Text(AppStrings.days66),
              tooltip: AppStrings.days66,
            ),
            ButtonSegment(
              value: HabitPeriod.days90.index,
              label: const Text(AppStrings.daya90),
              tooltip: AppStrings.daya90,
            ),
          ],
          selected: {habitPeriodState.getHabitPeriodIndex},
          onSelectionChanged: (newIndex) {
            habitPeriodState.setHabitPeriodIndex = newIndex.first;
          },
        );
      },
    );
  }
}