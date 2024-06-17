import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/enums/task/task_mode.dart';
import '../../../../../core/strings/app_strings.dart';
import '../../../../../data/state/task_data_state.dart';
import '../../../../../domain/entities/task_entity.dart';
import '../../state/task_sort_state.dart';
import '../../widgets/main_error_text.dart';
import '../../widgets/time_is_empty.dart';
import '../items/task_item.dart';

class MonthTaskList extends StatelessWidget {
  const MonthTaskList({super.key});

  @override
  Widget build(BuildContext context) {
    final sortState = Provider.of<TaskSortState>(context);
    return FutureBuilder<List<TaskEntity>>(
      future: Provider.of<TaskDataState>(context).getTasksByMode(
        taskMode: TaskMode.month,
        orderBy: '${sortState.getSort} ${sortState.getOrder}',
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return ListView.builder(
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
    );
  }
}
