import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../core/styles/app_styles.dart';
import '../../../domain/entities/market_entity.dart';
import '../../../domain/usecases/market_use_case.dart';
import '../../state/market/market_sort_state.dart';
import '../../widgets/main_error_text.dart';
import '../../widgets/time_is_empty.dart';
import '../items/market_item.dart';

class MainMarketList extends StatelessWidget {
  const MainMarketList({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    return Consumer<MarketSortState>(
      builder: (BuildContext context, marketSortState, _) {
        return FutureBuilder<List<MarketEntity>>(
          future: Provider.of<MarketUseCase>(context).fetchAllMarkets(
            orderBy: '${AppStyles.marketSortList[marketSortState.getSortIndex]} ${AppStyles.orderList[marketSortState.getOrderIndex]}',
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return Scrollbar(
                child: ListView.builder(
                  padding: AppStyles.paddingWithoutBottomMini,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final MarketEntity marketModel = snapshot.data![index];
                    return MarketItem(
                      marketModel: marketModel,
                      marketItemIndex: index,
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return MainErrorText(errorText: snapshot.error.toString());
            } else {
              return SafeArea(
                child: TimeIsEmpty(
                  title: appLocale.addFirstMarket,
                  icon: Icons.sell_outlined,
                ),
              );
            }
          },
        );
      },
    );
  }
}
