import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/strings/app_strings.dart';
import '../../../core/styles/app_styles.dart';
import '../../../data/state/task_data_state.dart';
import '../../../domain/entities/task_entity.dart';
import '../../widgets/main_error_text.dart';
import '../../widgets/time_is_empty.dart';
import '../items/graphic_task_item.dart';

class GraphicTasksList extends StatelessWidget {
  const GraphicTasksList({
    super.key,
    required this.taskStatusIndex,
  });

  final int taskStatusIndex;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<TaskDataState>(context).getTaskByStatus(statusIndex: taskStatusIndex),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return Scrollbar(
            child: ListView.builder(
              padding: AppStyles.paddingMini,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final TaskEntity taskModel = snapshot.data![index];
                return GraphicTaskItem(taskModel: taskModel);
              },
            ),
          );
        } else if (snapshot.hasError) {
          return MainErrorText(errorText: snapshot.error.toString());
        } else {
          return Container(
            alignment: Alignment.center,
            padding: AppStyles.padding,
            child: const TimeIsEmpty(title: AppStrings.tasksIsEmpty),
          );
        }
      },
    );
  }
}
