import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/strings/app_strings.dart';
import '../../../core/styles/app_styles.dart';
import '../../../data/models/all_task_count_model.dart';
import '../../../data/state/task_data_state.dart';
import '../../widgets/main_error_text.dart';
import 'statistic_item.dart';

class MainStatisticItem extends StatelessWidget {
  const MainStatisticItem({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: AppStyles.paddingMini,
      child: FutureBuilder<AllTaskCountModel>(
        future: Provider.of<TaskDataState>(context).getAllTasksNumber(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final AllTaskCountModel allTaskCountModel = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GraphicItem(
                  taskStatusIndex: 3,
                  taskStatus: allTaskCountModel.all,
                  title: AppStrings.allTasks,
                  color: appColors.inversePrimary,
                ),
                GraphicItem(
                  taskStatusIndex: 0,
                  taskStatus: allTaskCountModel.inProgress,
                  title: AppStrings.inProgress,
                  color: appColors.secondaryContainer,
                ),
                GraphicItem(
                  taskStatusIndex: 1,
                  taskStatus: allTaskCountModel.complete,
                  title: AppStrings.completed,
                  color: appColors.tertiaryContainer,
                ),
                GraphicItem(
                  taskStatusIndex: 2,
                  taskStatus: allTaskCountModel.canceled,
                  title: AppStrings.canceled,
                  color: appColors.errorContainer,
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return const MainErrorText(errorText: AppStrings.errorGetData);
          } else {
            return Container(
              padding: AppStyles.padding,
              alignment: Alignment.center,
              child: const Text(AppStrings.tasksIsEmpty),
            );
          }
        },
      ),
    );
  }
}
