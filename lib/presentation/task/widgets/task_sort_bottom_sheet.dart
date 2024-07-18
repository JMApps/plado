import 'package:flutter/material.dart';

import '../../../core/strings/app_strings.dart';
import '../../../core/styles/app_styles.dart';
import 'task_order_item.dart';
import 'task_sort_item.dart';

class TaskSortBottomSheet extends StatelessWidget {
  const TaskSortBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: AppStyles.paddingWithoutTopMini,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
            title: Text(
              AppStrings.sortTasks,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: Icon(Icons.sort),
          ),
          TaskSortItem(title: AppStrings.sortByAddTime, index: 0),
          TaskSortItem(title: AppStrings.sortByTitle, index: 1),
          TaskSortItem(title: AppStrings.sortByPriority, index: 2),
          TaskSortItem(title: AppStrings.sortByColor, index: 3),
          ListTile(
            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
            title: Text(
              AppStrings.order,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: Icon(Icons.sort_by_alpha),
          ),
          TaskOrderItem(title: AppStrings.firstNew, orderIndex: 0),
          TaskOrderItem(title: AppStrings.firstOld, orderIndex: 1),
        ],
      ),
    );
  }
}
