import 'package:flutter/material.dart';

import '../../../core/routes/name_routes.dart';
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
          style: AppStyles.mainTextRoboto16,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
    );
  }
}
