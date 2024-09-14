import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../core/styles/app_styles.dart';
import '../../state/market/market_title_state.dart';
import 'add_market_button.dart';
import 'market_text_field.dart';

class AddMarketBottomSheet extends StatelessWidget {
  const AddMarketBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MarketTitleState(),
        ),
      ],
      child: SingleChildScrollView(
        padding: AppStyles.paddingWithoutTop,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              appLocale.addingMarket,
              style: AppStyles.mainText,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const MarketTextField(),
            const SizedBox(height: 8),
            const AddMarketButton(),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
