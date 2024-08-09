import 'package:flutter/material.dart';
import 'package:plado/core/strings/app_constraints.dart';
import 'package:provider/provider.dart';

import '../../../core/strings/app_strings.dart';
import '../../../core/styles/app_styles.dart';
import '../../../data/models/all_task_count_model.dart';
import '../../../data/state/task_data_state.dart';
import '../../widgets/main_error_text.dart';

class MainGraphicItem extends StatefulWidget {
  const MainGraphicItem({super.key});

  @override
  State<MainGraphicItem> createState() => _MainGraphicItemState();
}

class _MainGraphicItemState extends State<MainGraphicItem> {
  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: AppStyles.padding,
      child: FutureBuilder<AllTaskCountModel>(
        future: Provider.of<TaskDataState>(context).getAllTasksNumber(),
        builder: (context, snapshot) {
          final AllTaskCountModel allTaskCountModel = snapshot.data!;
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListTile(
                  title: const Text('Все задачи'),
                  trailing: CircleAvatar(
                    backgroundColor: appColors.inversePrimary,
                    child: Text(
                      allTaskCountModel.all.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: AppConstraints.fontRobotoSlab,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: const Text('Задачи в процессе'),
                  trailing: CircleAvatar(
                    backgroundColor: Colors.amber.withOpacity(0.75),
                    child: Text(
                      allTaskCountModel.inProgress.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: AppConstraints.fontRobotoSlab,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: const Text('Завершенные задачи'),
                  trailing: CircleAvatar(
                    backgroundColor: Colors.teal.withOpacity(0.75),
                    child: Text(
                      allTaskCountModel.complete.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: AppConstraints.fontRobotoSlab,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: const Text('Незавершенные задачи'),
                  trailing: CircleAvatar(
                    backgroundColor: Colors.red.withOpacity(0.75),
                    child: Text(
                      allTaskCountModel.canceled.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: AppConstraints.fontRobotoSlab,
                      ),
                    ),
                  ),
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
