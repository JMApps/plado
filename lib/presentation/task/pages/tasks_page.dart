import 'package:flutter/material.dart';

import '../../../../../core/strings/app_strings.dart';
import '../../../../../core/styles/app_styles.dart';
import '../../widgets/fab_add_task.dart';
import '../lists/day_task_list.dart';
import '../lists/month_task_list.dart';
import '../lists/season_task_list.dart';
import '../lists/week_task_list.dart';
import '../lists/year_task_list.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        bottom: TabBar(
          controller: _tabController,
          labelPadding: AppStyles.paddingHorVerMini,
          padding: AppStyles.paddingMicro,
          splashBorderRadius: AppStyles.border,
          labelStyle: const TextStyle(fontSize: 16),
          tabAlignment: TabAlignment.center,
          isScrollable: true,
          tabs: const [
            Text(AppStrings.day),
            Text(AppStrings.week),
            Text(AppStrings.month),
            Text(AppStrings.season),
            Text(AppStrings.year),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            tooltip: AppStrings.sortTasks,
            icon: const Icon(Icons.sort),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          DayTaskList(),
          WeekTaskList(),
          MonthTaskList(),
          SeasonTaskList(),
          YearTaskList(),
        ],
      ),
      floatingActionButton: const FabAddTask(),
    );
  }
}
