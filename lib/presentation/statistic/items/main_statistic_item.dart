import 'package:flutter/material.dart';
import 'package:plado/presentation/widgets/text_description_bold.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/styles/app_styles.dart';
import '../../../data/models/all_habit_count_model.dart';
import '../../../data/models/all_task_count_model.dart';
import '../../../domain/usecases/habit_use_case.dart';
import '../../../domain/usecases/task_use_case.dart';
import '../../widgets/main_error_text.dart';
import 'statistic_habit_list_tile.dart';
import 'statistic_task_list_tile.dart';

class MainStatisticItem extends StatelessWidget {
  const MainStatisticItem({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    final appColors = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: AppStyles.paddingMini,
      child: Column(
        children: [
          FutureBuilder<AllTaskCountModel>(
            future: Provider.of<TaskUseCase>(context).fetchAllTaskCount(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final AllTaskCountModel allTaskCountModel = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextDescriptionBold(text: appLocale.tasks),
                    StaticTaskListTile(
                      taskStatusIndex: 3,
                      taskStatus: allTaskCountModel.all,
                      title: appLocale.allTasks,
                      color: appColors.inversePrimary,
                    ),
                    const Divider(indent: 16, endIndent: 16),
                    StaticTaskListTile(
                      taskStatusIndex: 0,
                      taskStatus: allTaskCountModel.inProgress,
                      title: appLocale.inProgress,
                      color: appColors.secondaryContainer,
                    ),
                    const Divider(indent: 16, endIndent: 16),
                    StaticTaskListTile(
                      taskStatusIndex: 1,
                      taskStatus: allTaskCountModel.complete,
                      title: appLocale.completed,
                      color: appColors.tertiaryContainer,
                    ),
                    const Divider(indent: 16, endIndent: 16),
                    StaticTaskListTile(
                      taskStatusIndex: 2,
                      taskStatus: allTaskCountModel.canceled,
                      title: appLocale.canceled,
                      color: appColors.errorContainer,
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return MainErrorText(errorText: appLocale.errorGetData);
              } else {
                return Container(
                  padding: AppStyles.padding,
                  alignment: Alignment.center,
                  child: Text(appLocale.tasksIsEmpty),
                );
              }
            },
          ),
          FutureBuilder<AllHabitCountModel>(
            future: Provider.of<HabitUseCase>(context).getAllHabitsNumber(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final AllHabitCountModel allHabitCountModel = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextDescriptionBold(text: appLocale.habits),
                    StaticHabitListTile(
                      taskStatus: allHabitCountModel.all,
                      title: appLocale.allHabits,
                      color: appColors.inversePrimary,
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return MainErrorText(errorText: appLocale.errorGetData);
              } else {
                return Container(
                  padding: AppStyles.padding,
                  alignment: Alignment.center,
                  child: Text(appLocale.habitsIsEmpty),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
