import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/strings/app_constraints.dart';
import '../../../core/strings/database_values.dart';
import '../../../core/styles/app_styles.dart';
import '../../../domain/entities/habit_entity.dart';
import '../../../domain/usecases/habit_use_case.dart';
import '../../widgets/main_error_text.dart';
import '../../widgets/time_is_empty.dart';
import '../items/static_habit_item.dart';

class StaticHabitsList extends StatelessWidget {
  const StaticHabitsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    return FutureBuilder(
      future: Provider.of<HabitUseCase>(context).getAllHabits(orderBy: '${DatabaseValues.dbHabitId} ${AppConstraints.descSort}'),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return Scrollbar(
            child: ListView.separated(
              padding: AppStyles.paddingMini,
              itemCount: snapshot.data!.length,
              separatorBuilder: (context, index) {
                return const Divider(indent: 16, endIndent: 16);
              },
              itemBuilder: (context, index) {
                final HabitEntity habitModel = snapshot.data![index];
                return StaticHabitItem(habitModel: habitModel);
              },
            ),
          );
        } else if (snapshot.hasError) {
          return MainErrorText(errorText: snapshot.error.toString());
        } else {
          return Container(
            alignment: Alignment.center,
            padding: AppStyles.padding,
            child: TimeIsEmpty(
              title: appLocale.habitsIsEmpty,
              icon: Icons.add_task_rounded,
            ),
          );
        }
      },
    );
  }
}
