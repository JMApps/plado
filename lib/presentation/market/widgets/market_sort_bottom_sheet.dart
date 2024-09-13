import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/styles/app_styles.dart';
import 'market_order_item.dart';
import 'market_sort_item.dart';

class MarketSortBottomSheet extends StatelessWidget {
  const MarketSortBottomSheet({super.key});

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
              appLocale.sortMarket,
              style: AppStyles.mainTextBold,
            ),
            leading: const Icon(Icons.sort),
          ),
          MarketSortItem(title: appLocale.sortByAddTime, index: 0),
          MarketSortItem(title: appLocale.sortByTitle, index: 1),
          ListTile(
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            title: Text(
              appLocale.order,
              style: AppStyles.mainTextBold,
            ),
            leading: const Icon(Icons.sort_by_alpha),
          ),
          MarketOrderItem(title: appLocale.firstNew, orderIndex: 0),
          MarketOrderItem(title: appLocale.firstOld, orderIndex: 1),
        ],
      ),
    );
  }
}
