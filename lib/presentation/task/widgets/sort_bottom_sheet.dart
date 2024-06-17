import 'package:flutter/material.dart';

import '../../../core/strings/app_strings.dart';
import '../../../core/styles/app_styles.dart';
import 'order_item.dart';
import 'sort_item.dart';

class SortBottomSheet extends StatelessWidget {
  const SortBottomSheet({super.key});

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
          SortItem(title: AppStrings.sortByAddTime, index: 0),
          SortItem(title: AppStrings.sortTitle, index: 1),
          SortItem(title: AppStrings.sortByPriority, index: 2),
          SortItem(title: AppStrings.sortByColor, index: 3),
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
          OrderItem(title: AppStrings.firstNew, orderIndex: 0),
          OrderItem(title: AppStrings.firstOld, orderIndex: 1),
        ],
      ),
    );
  }
}
