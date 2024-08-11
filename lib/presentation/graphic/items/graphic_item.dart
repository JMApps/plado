import 'package:flutter/material.dart';
import 'package:plado/core/styles/app_styles.dart';

import '../../../core/routes/name_routes.dart';
import '../../../core/strings/app_constraints.dart';
import '../../../data/models/arguments/graphic_task_args.dart';

class GraphicItem extends StatelessWidget {
  const GraphicItem({
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
          NameRoutes.graphicListPage,
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
