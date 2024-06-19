import 'package:flutter/material.dart';

import '../../../../core/routes/name_routes.dart';
import '../../../../core/strings/app_strings.dart';
import '../../data/models/arguments/add_task_args.dart';

class FabAddTask extends StatelessWidget {
  const FabAddTask({super.key, required this.timeModeIndex});

  final int timeModeIndex;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      tooltip: AppStrings.addTask,
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      child: const Icon(Icons.add),
      onPressed: () {
        Navigator.pushNamed(context, NameRoutes.createTaskPage, arguments: AddTaskArgs(timeModeIndex: timeModeIndex));
      },
    );
  }
}
