import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../core/styles/app_styles.dart';
import '../../../core/enums/task_period.dart';
import '../../../core/routes/name_routes.dart';
import '../../../core/strings/app_constraints.dart';
import '../../../data/models/arguments/create_task_args.dart';
import '../items/task_list_item.dart';
import '../widgets/task_sort_bottom_sheet.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocale.appName),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) => const TaskSortBottomSheet(),
              );
            },
            tooltip: appLocale.sortTasks,
            icon: const Icon(Icons.sort),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelPadding: AppStyles.paddingHorVerMini,
          padding: AppStyles.paddingMicro,
          splashBorderRadius: AppStyles.border,
          labelStyle: const TextStyle(
            fontSize: 16,
            fontFamily: AppConstraints.fontRaleway,
          ),
          tabAlignment: TabAlignment.center,
          isScrollable: true,
          tabs: [
            Text(appLocale.day),
            Text(appLocale.week),
            Text(appLocale.month),
            Text(appLocale.season),
            Text(appLocale.year),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          TaskListItem(taskPeriodIndex: TaskPeriod.day.index),
          TaskListItem(taskPeriodIndex: TaskPeriod.week.index),
          TaskListItem(taskPeriodIndex: TaskPeriod.month.index),
          TaskListItem(taskPeriodIndex: TaskPeriod.season.index),
          TaskListItem(taskPeriodIndex: TaskPeriod.year.index),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        tooltip: appLocale.addTask,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(
            context,
            NameRoutes.createTaskPage,
            arguments: CreateTaskArgs(
              taskPeriodIndex: _tabController.index,
            ),
          );
        },
      ),
    );
  }
}
