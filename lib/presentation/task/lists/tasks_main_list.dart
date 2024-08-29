import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

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
    final appLocale = AppLocalizations.of(context)!;
    return Consumer<TaskSortState>(
      builder: (BuildContext context, taskSortState, _) {
        return FutureBuilder<List<TaskEntity>>(
          future: Provider.of<TaskDataState>(context).getTasksByMode(
            taskPeriodIndex: taskPeriodIndex,
            startTime: startDate.toIso8601String(),
            endTime: endDate.toIso8601String(),
            orderBy: '${AppStyles.taskSortList[taskSortState.getSortIndex]} ${AppStyles.orderList[taskSortState.getOrderIndex]}',
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
              return SafeArea(
                child: TimeIsEmpty(title: appLocale.addFirstTask),
              );
            }
          },
        );
      },
    );
  }
}
