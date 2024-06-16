import 'package:flutter/material.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/styles/app_styles.dart';
import '../task/lists/day_task_container.dart';
import '../task/lists/month_task_container.dart';
import '../task/lists/season_task_container.dart';
import '../task/lists/week_task_container.dart';
import '../task/lists/year_task_container.dart';
import '../widgets/fab_add_task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
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
        leading: IconButton(
          onPressed: () {},
          tooltip: AppStrings.sortTasks,
          icon: const Icon(Icons.sort_rounded),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            tooltip: AppStrings.settings,
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () {},
            tooltip: AppStrings.addingHabit,
            icon: const Icon(Icons.task_alt_rounded),
          ),
        ],
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
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          DayTaskContainer(),
          WeekTaskContainer(),
          MonthTaskContainer(),
          SeasonTaskContainer(),
          YearTaskContainer(),
        ],
      ),
      floatingActionButton: const FabAddTask(),
    );
  }
}
