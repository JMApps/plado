import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../core/routes/name_routes.dart';
import '../../../domain/usecases/task_use_case.dart';
import '../../task/widgets/task_sort_bottom_sheet.dart';
import '../lists/daily_tasks_main_list.dart';

class DailyTaskPage extends StatefulWidget {
  const DailyTaskPage({super.key});

  @override
  State<DailyTaskPage> createState() => _DailyTaskPageState();
}

class _DailyTaskPageState extends State<DailyTaskPage> {

  @override
  void initState() {
    super.initState();
    _resetDailyTasks();
  }

  _resetDailyTasks() async {
    await Provider.of<TaskUseCase>(context, listen: false).resetDailyTasks();
  }

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocale.dailyTasks),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => const TaskSortBottomSheet(),
              );
            },
            tooltip: appLocale.sortTasks,
            icon: const Icon(Icons.sort),
          ),
        ],
      ),
      body: const DailyTasksMainList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            NameRoutes.createDailyTaskPage,
          );
        },
        tooltip: appLocale.addTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}
