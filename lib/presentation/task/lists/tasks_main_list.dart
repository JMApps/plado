import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/strings/app_strings.dart';
import '../../../../../data/state/task_data_state.dart';
import '../../../../../domain/entities/task_entity.dart';
import '../../../core/styles/app_styles.dart';
import '../../state/task/task_sort_state.dart';
import '../../widgets/main_error_text.dart';
import '../../widgets/time_is_empty.dart';
import '../items/task_item.dart';

class TasksMainList extends StatelessWidget {
  const TasksMainList({
    super.key,
    required this.taskPeriodIndex,
    required this.startDate,
    required this.endDate,
  });

  final int taskPeriodIndex;
  final DateTime startDate;
  final DateTime endDate;

  @override
  Widget build(BuildContext context) {
    final taskSortState = Provider.of<TaskSortState>(context);
    return FutureBuilder<List<TaskEntity>>(
      future: Provider.of<TaskDataState>(context).getTasksByMode(
        taskPeriodIndex: taskPeriodIndex,
        startTime: startDate.toIso8601String(),
        endTime: endDate.toIso8601String(),
        orderBy: '${taskSortState.getSort} ${taskSortState.getOrder}',
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return Scrollbar(
            child: ListView.builder(
              padding: AppStyles.paddingWithoutBottomMini,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final TaskEntity taskModel = snapshot.data![index];
                return TaskItem(
                  taskModel: taskModel,
                  index: index,
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
          return MainErrorText(errorText: snapshot.error.toString());
        } else {
          return const SafeArea(
            child: TimeIsEmpty(title: AppStrings.addFirstTask),
          );
        }
      },
    );
  }
}
