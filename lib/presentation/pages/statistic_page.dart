import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../core/styles/app_styles.dart';
import '../../data/models/counts/all_task_count_model.dart';
import '../../domain/usecases/habit_use_case.dart';
import '../../domain/usecases/task_use_case.dart';
import '../statistic/items/statistic_habit_list_tile.dart';
import '../statistic/items/statistic_task_list_tile.dart';
import '../widgets/main_error_text.dart';
import '../widgets/text_description_bold.dart';

class StatisticPage extends StatefulWidget {
  const StatisticPage({super.key});

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateExpiredTasks();
  }

  _updateExpiredTasks() async {
    if (mounted) {
      final taskUseCase = Provider.of<TaskUseCase>(context, listen: false);
      await taskUseCase.updateCompletedTasks();
      await taskUseCase.updateExpiredTasks();
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    final appColors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocale.statistics),
      ),
      body: SingleChildScrollView(
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
            FutureBuilder<int>(
              future: Provider.of<HabitUseCase>(context).getAllHabitsNumber(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextDescriptionBold(text: appLocale.habits),
                      StaticHabitListTile(
                        taskStatus: snapshot.data!,
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
      ),
    );
  }
}
