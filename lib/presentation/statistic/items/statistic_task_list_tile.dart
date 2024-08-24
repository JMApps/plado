import 'package:flutter/material.dart';

import '../../../core/routes/name_routes.dart';
import '../../../core/strings/app_constraints.dart';
import '../../../core/styles/app_styles.dart';
import '../../../data/models/arguments/graphic_task_args.dart';

class StaticTaskListTile extends StatelessWidget {
  const StaticTaskListTile({
    super.key,
    required this.taskStatusIndex,
    required this.taskStatus,
    required this.title,
    required this.color,
  });

  final int taskStatusIndex;
  final int taskStatus;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity.compact,
      shape: AppStyles.shape,
      onTap: () {
        Navigator.pushNamed(
          context,
          NameRoutes.statisticTaskListPage,
          arguments: GraphicTaskArgs(
            taskStatusIndex: taskStatusIndex,
            title: title,
          ),
        );
      },
      title: Text(title),
      leading: CircleAvatar(
        backgroundColor: color,
        child: Text(
          taskStatus.toString(),
          style: const TextStyle(
            fontSize: 16,
            fontFamily: AppConstraints.fontRobotoSlab,
          ),
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
    );
  }
}
