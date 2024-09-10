import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/styles/app_styles.dart';
import 'category_order_item.dart';
import 'category_sort_item.dart';

class CategorySortBottomSheet extends StatelessWidget {
  const CategorySortBottomSheet({super.key});

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
            visualDensity: VisualDensity.compact,
            title: Text(
              appLocale.sortCategoryTasks,
              style: AppStyles.mainTextBold,
            ),
            leading: const Icon(Icons.sort),
          ),
          CategorySortItem(title: appLocale.sortByAddTime, index: 0),
          CategorySortItem(title: appLocale.sortByColor, index: 1),
          ListTile(
            visualDensity: VisualDensity.compact,
            title: Text(
              appLocale.order,
              style: AppStyles.mainTextBold,
            ),
            leading: const Icon(Icons.sort_by_alpha),
          ),
          CategoryOrderItem(title: appLocale.firstNew, orderIndex: 0),
          CategoryOrderItem(title: appLocale.firstOld, orderIndex: 1),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
