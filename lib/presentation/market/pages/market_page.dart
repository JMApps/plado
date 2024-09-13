import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/market_data_repository.dart';
import '../../../data/services/plado_database_service.dart';
import '../../../domain/usecases/market_use_case.dart';
import '../lists/main_market_list.dart';
import '../widgets/market_sort_bottom_sheet.dart';

class MarketPage extends StatelessWidget {
  const MarketPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MarketUseCase(MarketDataRepository(PladoDatabaseService())),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(appLocale.purchases),
          actions: [
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (_) => const MarketSortBottomSheet(),
                );
              },
              icon: const Icon(Icons.sort),
            ),
          ],
        ),
        body: const MainMarketList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
