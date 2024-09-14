import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../core/enums/market_status.dart';
import '../../../core/styles/app_styles.dart';
import '../../../data/models/market_model.dart';
import '../../../domain/usecases/market_use_case.dart';
import '../../state/market/market_title_state.dart';

class AddMarketButton extends StatelessWidget {
  const AddMarketButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    return OutlinedButton(
      onPressed: () async {
        final String marketTitle = Provider.of<MarketTitleState>(context, listen: false).getMarketTitle;

        final MarketModel marketModel = MarketModel(
          marketId: 0,
          marketTitle: marketTitle,
          marketStatusIndex: MarketStatus.inProgress.index,
        );

        if (marketTitle.isNotEmpty) {
          Navigator.of(context).pop();
          await Provider.of<MarketUseCase>(context, listen: false).createMarket(marketModel: marketModel);
        }
      },
      child: Text(
        appLocale.add,
        style: AppStyles.mainText,
      ),
    );
  }
}
