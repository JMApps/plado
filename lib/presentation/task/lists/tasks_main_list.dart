import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/entities/task_entity.dart';
import '../../../core/styles/app_styles.dart';
import '../../../domain/entities/category_entity.dart';
import '../../../domain/usecases/task_use_case.dart';
import '../../state/task/task_sort_state.dart';
import '../../widgets/main_error_text.dart';
import '../../widgets/time_is_empty.dart';
import '../items/task_item.dart';

class TasksMainList extends StatelessWidget {
  const TasksMainList({
    super.key,
    required this.categoryModel,
  });

  final CategoryEntity categoryModel;

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    return Consumer<TaskSortState>(
      builder: (BuildContext context, taskSortState, _) {
        return FutureBuilder<List<TaskEntity>>(
          future: Provider.of<TaskUseCase>(context).fetchTaskByCategoryId(
            categoryId: categoryModel.categoryId,
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
                child: TimeIsEmpty(
                  title: appLocale.addFirstTask,
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
