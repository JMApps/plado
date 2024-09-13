import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../core/styles/app_styles.dart';
import '../../../domain/entities/habit_entity.dart';
import '../../../domain/usecases/habit_use_case.dart';
import '../../state/habit/habit_sort_state.dart';
import '../../widgets/main_error_text.dart';
import '../../widgets/time_is_empty.dart';
import '../items/habit_item.dart';

class HabitList extends StatelessWidget {
  const HabitList({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    return Consumer<HabitSortState>(
      builder: (BuildContext context, habitSortState, _) {
        return FutureBuilder<List<HabitEntity>>(
          future: Provider.of<HabitUseCase>(context).getAllHabits(
            orderBy: '${AppStyles.habitSortList[habitSortState.getSortIndex]} ${AppStyles.orderList[habitSortState.getOrderIndex]}',
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return Scrollbar(
                child: ListView.builder(
                  padding: AppStyles.paddingMini,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final HabitEntity habitModel = snapshot.data![index];
                    return HabitItem(
                      habitModel: habitModel,
                      habitIndex: index,
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return MainErrorText(errorText: snapshot.error.toString());
            } else {
              return SafeArea(
                child: TimeIsEmpty(
                  title: appLocale.addFirstHabit,
                  icon: Icons.add_task_rounded,
                ),
              );
            }
          },
        );
      },
    );
  }
}
