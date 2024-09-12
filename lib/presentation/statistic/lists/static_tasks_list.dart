import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../core/styles/app_styles.dart';
import '../../../domain/entities/task_entity.dart';
import '../../../domain/usecases/task_use_case.dart';
import '../../widgets/main_error_text.dart';
import '../../widgets/time_is_empty.dart';
import '../items/static_task_item.dart';

class StaticTasksList extends StatelessWidget {
  const StaticTasksList({
    super.key,
    required this.taskStatusIndex,
  });

  final int taskStatusIndex;

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    return FutureBuilder<List<TaskEntity>>(
      future: Provider.of<TaskUseCase>(context).fetchTaskByStatus(taskStatusIndex: taskStatusIndex),
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
                final TaskEntity taskModel = snapshot.data![index];
                return StaticTaskItem(taskModel: taskModel);
              },
            ),
          );
        } else if (snapshot.hasError) {
          return MainErrorText(errorText: snapshot.error.toString());
        } else {
          return Container(
            alignment: Alignment.center,
            padding: AppStyles.padding,
            child: TimeIsEmpty(
              title: appLocale.tasksIsEmpty,
            ),
          );
        }
      },
    );
  }
}
