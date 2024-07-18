import 'package:flutter/material.dart';

import '../../../core/strings/app_strings.dart';
import '../../../core/styles/app_styles.dart';
import 'habit_order_item.dart';
import 'habit_sort_item.dart';

class HabitSortBottomSheet extends StatelessWidget {
  const HabitSortBottomSheet({super.key});

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
              AppStrings.sortHabits,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: Icon(Icons.sort),
          ),
          HabitSortItem(title: AppStrings.sortByAddTime, index: 0),
          HabitSortItem(title: AppStrings.sortByTitle, index: 1),
          HabitSortItem(title: AppStrings.sortByColor, index: 3),
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
          HabitOrderItem(title: AppStrings.firstNew, orderIndex: 0),
          HabitOrderItem(title: AppStrings.firstOld, orderIndex: 1),
        ],
      ),
    );
  }
}
