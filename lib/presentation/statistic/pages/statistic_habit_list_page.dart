import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../lists/static_habits_list.dart';

class StatisticHabitListPage extends StatelessWidget {
  const StatisticHabitListPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocale.allHabits),
      ),
      body: const StaticHabitsList(),
    );
  }
}
