import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:plado/presentation/market/addchange/delete_market_button.dart';
import 'package:provider/provider.dart';

import '../../../core/styles/app_styles.dart';
import '../../../domain/entities/market_entity.dart';
import '../../state/market/market_title_state.dart';
import 'change_market_button.dart';
import 'market_text_field.dart';

class ChangeMarketBottomSheet extends StatelessWidget {
  const ChangeMarketBottomSheet({
    super.key,
    required this.marketModel,
  });

  final MarketEntity marketModel;

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MarketTitleState(marketModel.marketTitle),
        ),
      ],
      child: SingleChildScrollView(
        padding: AppStyles.paddingWithoutTop,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              appLocale.changingMarket,
              style: AppStyles.mainText,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const MarketTextField(),
            const SizedBox(height: 8),
            ChangeMarketButton(marketModel: marketModel),
            const SizedBox(height: 8),
            DeleteMarketButton(marketId: marketModel.marketId),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
