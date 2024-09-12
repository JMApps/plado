import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/enums/habit_period.dart';
import '../../state/habit/habit_period_state.dart';

class HabitPeriodSegment extends StatelessWidget {
  const HabitPeriodSegment({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    return Consumer<HabitPeriodState>(
      builder: (context, habitPeriodState, _) {
        return SegmentedButton(
          showSelectedIcon: false,
          segments: [
            ButtonSegment(
              value: HabitPeriod.days21.index,
              label: Text(appLocale.days21),
              tooltip: appLocale.days21,
            ),
            ButtonSegment(
              value: HabitPeriod.days40.index,
              label: Text(appLocale.days40),
              tooltip: appLocale.days40,
            ),
            ButtonSegment(
              value: HabitPeriod.days66.index,
              label: Text(appLocale.days66),
              tooltip: appLocale.days66,
            ),
            ButtonSegment(
              value: HabitPeriod.days90.index,
              label: Text(appLocale.days90),
              tooltip: appLocale.days90,
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