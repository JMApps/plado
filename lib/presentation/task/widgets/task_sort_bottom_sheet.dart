import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/styles/app_styles.dart';
import '../items/task_order_item.dart';
import '../items/task_sort_item.dart';

class TaskSortBottomSheet extends StatelessWidget {
  const TaskSortBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      padding: AppStyles.paddingWithoutTopMini,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            title: Text(
              appLocale.sortTasks,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: const Icon(Icons.sort),
          ),
          TaskSortItem(title: appLocale.sortByAddTime, index: 0),
          TaskSortItem(title: appLocale.sortByTitle, index: 1),
          TaskSortItem(title: appLocale.sortByPriority, index: 2),
          TaskSortItem(title: appLocale.sortByColor, index: 3),
          ListTile(
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            title: Text(
              appLocale.order,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: const Icon(Icons.sort_by_alpha),
          ),
          TaskOrderItem(title: appLocale.firstNew, orderIndex: 0),
          TaskOrderItem(title: appLocale.firstOld, orderIndex: 1),
        ],
      ),
    );
  }
}
