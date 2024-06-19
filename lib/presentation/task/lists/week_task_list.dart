import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/strings/app_strings.dart';
import '../../../../../data/state/task_data_state.dart';
import '../../../../../domain/entities/task_entity.dart';
import '../../../core/enums/task_period.dart';
import '../../../core/styles/app_styles.dart';
import '../../state/rest_times_state.dart';
import '../../state/task_sort_state.dart';
import '../../widgets/main_error_text.dart';
import '../../widgets/time_is_empty.dart';
import '../items/task_item.dart';
import '../widgets/percent_time.dart';

class WeekTaskList extends StatelessWidget {
  const WeekTaskList({super.key});

  @override
  Widget build(BuildContext context) {
    final sortState = Provider.of<TaskSortState>(context);
    return Column(
      children: [
        PercentTime(percentage: Provider.of<RestTimesState>(context).calculateElapsedWeekPercentage()),
        Expanded(
          child: FutureBuilder<List<TaskEntity>>(
            future: Provider.of<TaskDataState>(context).getTasksByMode(
              taskPeriod: TaskPeriod.week.name,
              orderBy: '${sortState.getSort} ${sortState.getOrder}',
            ),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return ListView.builder(
                  padding: AppStyles.paddingMini,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final TaskEntity taskModel = snapshot.data![index];
                    return TaskItem(taskModel: taskModel, index: index);
                  },
                );
              } else if (snapshot.hasError) {
                return MainErrorText(errorText: snapshot.error.toString());
              } else {
                return const SafeArea(
                  child: TimeIsEmpty(title: AppStrings.addFirstTask),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
