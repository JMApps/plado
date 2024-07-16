import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/strings/app_strings.dart';
import '../../../../../core/styles/app_styles.dart';
import '../../../core/enums/task_period.dart';
import '../../../core/routes/name_routes.dart';
import '../../../core/strings/app_constraints.dart';
import '../../../data/models/arguments/create_task_args.dart';
import '../../../data/state/task_data_state.dart';
import '../../state/rest_times_state.dart';
import '../lists/day_task_list.dart';
import '../lists/month_task_list.dart';
import '../lists/season_task_list.dart';
import '../lists/week_task_list.dart';
import '../lists/year_task_list.dart';
import '../widgets/sort_bottom_sheet.dart';

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
    final appColors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) => const SortBottomSheet(),
              );
            },
            tooltip: AppStrings.sortTasks,
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
          tabs: const [
            Text(AppStrings.day),
            Text(AppStrings.week),
            Text(AppStrings.month),
            Text(AppStrings.season),
            Text(AppStrings.year),
          ],
        ),
      ),
      body: Consumer<RestTimesState>(
        builder: (context, restTimeState, _) {
          return TabBarView(
            controller: _tabController,
            children: [
              DayTaskList(
                startDate: restTimeState.getRestTimeIndicator(TaskPeriod.day)[AppConstraints.startDateTime],
                endDate: restTimeState.getRestTimeIndicator(TaskPeriod.day)[AppConstraints.endDateTime],
              ),
              WeekTaskList(
                startDate: restTimeState.getRestTimeIndicator(TaskPeriod.week)[AppConstraints.startDateTime],
                endDate: restTimeState.getRestTimeIndicator(TaskPeriod.week)[AppConstraints.endDateTime],
              ),
              MonthTaskList(
                startDate: restTimeState.getRestTimeIndicator(TaskPeriod.month)[AppConstraints.startDateTime],
                endDate: restTimeState.getRestTimeIndicator(TaskPeriod.month)[AppConstraints.endDateTime],
              ),
              SeasonTaskList(
                startDate: restTimeState.getRestTimeIndicator(TaskPeriod.season)[AppConstraints.startDateTime],
                endDate: restTimeState.getRestTimeIndicator(TaskPeriod.season)[AppConstraints.endDateTime],
              ),
              YearTaskList(
                startDate: restTimeState.getRestTimeIndicator(TaskPeriod.year)[AppConstraints.startDateTime],
                endDate: restTimeState.getRestTimeIndicator(TaskPeriod.year)[AppConstraints.endDateTime],
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        tooltip: AppStrings.addTask,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(
            context,
            NameRoutes.createTaskPage,
            arguments: CreateTaskArgs(
              taskPeriod: AppStyles.taskPeriodList[_tabController.index],
            ),
          );
        },
      ),
    );
  }
}
