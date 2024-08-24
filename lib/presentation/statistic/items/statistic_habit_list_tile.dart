import 'package:flutter/material.dart';

import '../../../core/routes/name_routes.dart';
import '../../../core/strings/app_constraints.dart';
import '../../../core/styles/app_styles.dart';

class StaticHabitListTile extends StatelessWidget {
  const StaticHabitListTile({
    super.key,
    required this.taskStatus,
    required this.title,
    required this.color,
  });

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
          NameRoutes.statisticHabitListPage,
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
