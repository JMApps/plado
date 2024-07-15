import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/strings/app_strings.dart';
import '../../../../../core/styles/app_styles.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestTimesState(
            day: AppStrings.day,
            hour: AppStrings.hours,
            minute: AppStrings.minutes,
          ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.appName),
          actions: [
            FutureBuilder(
              future: Provider.of<TaskDataState>(context).getTasksNumber(taskPeriodIndex: _tabController.index),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text.rich(
                    TextSpan(
                      style: const TextStyle(
                        fontFamily: AppConstraints.fontRobotoSlab,
                      ),
                      children: [
                        TextSpan(
                          text: '${snapshot.data!.inProgress}',
                          style: TextStyle(color: appColors.error),
                        ),
                        TextSpan(
                          text: ' / ',
                          style: TextStyle(color: appColors.onSurface),
                        ),
                        TextSpan(
                          text: '${snapshot.data!.complete}',
                          style: TextStyle(color: appColors.primary),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
              },
            ),
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
            labelStyle: const TextStyle(fontSize: 16, fontFamily: AppConstraints.fontRaleway),
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
            DayTaskList(),
            WeekTaskList(),
            MonthTaskList(),
            SeasonTaskList(),
            YearTaskList(),
          ],
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
      ),
    );
  }
}
