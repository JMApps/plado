import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:plado/presentation/dailytask/lists/daily_tasks_main_list.dart';

import '../../../core/routes/name_routes.dart';
import '../../task/widgets/task_sort_bottom_sheet.dart';

class DailyTaskPage extends StatelessWidget {
  const DailyTaskPage({super.key});

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
        child: const Icon(Icons.add),
      ),
    );
  }
}
