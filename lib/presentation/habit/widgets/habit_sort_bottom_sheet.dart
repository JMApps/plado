import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/styles/app_styles.dart';
import 'habit_order_item.dart';
import 'habit_sort_item.dart';

class HabitSortBottomSheet extends StatelessWidget {
  const HabitSortBottomSheet({super.key});

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
              appLocale.sortHabits,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: const Icon(Icons.sort),
          ),
          HabitSortItem(title: appLocale.sortByAddTime, index: 0),
          HabitSortItem(title: appLocale.sortByTitle, index: 1),
          HabitSortItem(title: appLocale.sortByColor, index: 2),
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
          HabitOrderItem(title: appLocale.firstNew, orderIndex: 0),
          HabitOrderItem(title: appLocale.firstOld, orderIndex: 1),
        ],
      ),
    );
  }
}
