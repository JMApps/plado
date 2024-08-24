import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/strings/app_constraints.dart';
import '../../../core/strings/app_strings.dart';
import '../../../core/strings/database_values.dart';
import '../../../core/styles/app_styles.dart';
import '../../../data/state/habit_data_state.dart';
import '../../../domain/entities/habit_entity.dart';
import '../../widgets/main_error_text.dart';
import '../../widgets/time_is_empty.dart';
import '../items/static_habit_item.dart';

class StaticHabitsList extends StatelessWidget {
  const StaticHabitsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<HabitDataState>(context).getAllHabits(orderBy: '${DatabaseValues.dbHabitId} ${AppConstraints.descSort}'),
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
            child: const TimeIsEmpty(
              title: AppStrings.habitsIsEmpty,
            ),
          );
        }
      },
    );
  }
}
