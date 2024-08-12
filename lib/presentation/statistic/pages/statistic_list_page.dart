import 'package:flutter/material.dart';

import '../../../data/models/arguments/graphic_task_args.dart';
import '../lists/static_tasks_list.dart';

class StatisticListPage extends StatelessWidget {
  const StatisticListPage({
    super.key,
    required this.graphicTaskArgs,
  });

  final GraphicTaskArgs graphicTaskArgs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(graphicTaskArgs.title),
      ),
      body: StaticTasksList(taskStatusIndex: graphicTaskArgs.taskStatusIndex),
    );
  }
}
