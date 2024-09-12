import 'package:flutter/material.dart';

import '../../../data/models/arguments/statistic_task_args.dart';
import '../lists/static_tasks_list.dart';

class StatisticTaskListPage extends StatelessWidget {
  const StatisticTaskListPage({
    super.key,
    required this.statisticTaskArgs,
  });

  final StatisticTaskArgs statisticTaskArgs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(statisticTaskArgs.title),
      ),
      body: StaticTasksList(taskStatusIndex: statisticTaskArgs.taskStatusIndex),
    );
  }
}
