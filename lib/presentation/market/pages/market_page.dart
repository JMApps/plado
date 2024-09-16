import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../core/strings/app_constraints.dart';
import '../../../core/strings/database_values.dart';
import '../../../core/styles/app_styles.dart';
import '../../../domain/entities/market_entity.dart';
import '../../../domain/usecases/market_use_case.dart';
import '../addchange/add_market_bottom_sheet.dart';
import '../lists/main_market_list.dart';
import '../widgets/market_sort_bottom_sheet.dart';

class MarketPage extends StatelessWidget {
  const MarketPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocale.purchases),
        actions: [
          Consumer<MarketUseCase>(
            builder: (BuildContext context, marketUseCase, _) {
              return FutureBuilder<List<MarketEntity>>(
                future: marketUseCase.fetchAllMarkets(orderBy: '${DatabaseValues.dbMarketId} ${AppConstraints.descSort}'),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text(
                              appLocale.warning,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                            content: Text(
                              appLocale.clearMessage,
                              style: AppStyles.mainText,
                            ),
                            actions: [
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(appLocale.cancel),
                              ),
                              OutlinedButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  await Provider.of<MarketUseCase>(context, listen: false).fetchClearList();
                                },
                                child: Text(
                                  appLocale.clear,
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      tooltip: appLocale.clear,
                      icon: const Icon(Icons.clear),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              );
            },
          ),
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => const MarketSortBottomSheet(),
              );
            },
            tooltip: appLocale.sortMarket,
            icon: const Icon(Icons.sort),
          ),
        ],
      ),
      body: const MainMarketList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => AnimatedPadding(
              padding: MediaQuery.of(context).viewInsets,
              duration: const Duration(milliseconds: 250),
              curve: Curves.decelerate,
              child: const AddMarketBottomSheet(),
            ),
          );
        },
        tooltip: appLocale.addMarket,
        child: const Icon(Icons.add),
      ),
    );
  }
}
