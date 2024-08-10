import 'package:flutter/material.dart';

import '../../../data/models/arguments/graphic_task_args.dart';
import '../lists/graphic_tasks_list.dart';

class GraphicListPage extends StatelessWidget {
  const GraphicListPage({
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
      body: GraphicTasksList(taskStatusIndex: graphicTaskArgs.taskStatusIndex),
    );
  }
}
