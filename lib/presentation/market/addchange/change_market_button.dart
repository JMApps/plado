import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:plado/core/strings/database_values.dart';
import 'package:provider/provider.dart';

import '../../../core/styles/app_styles.dart';
import '../../../domain/entities/market_entity.dart';
import '../../../domain/usecases/market_use_case.dart';
import '../../state/market/market_title_state.dart';

class ChangeMarketButton extends StatelessWidget {
  const ChangeMarketButton({
    super.key,
    required this.marketModel,
  });

  final MarketEntity marketModel;

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    return OutlinedButton(
      onPressed: () async {
        final String marketTitle = Provider.of<MarketTitleState>(context, listen: false).getMarketTitle;

        final Map<String, dynamic> marketMap = {
          DatabaseValues.dbMarketTitle: marketTitle,
        };

        if (marketTitle.isNotEmpty) {
          if (marketTitle != marketModel.marketTitle) {
            Navigator.of(context).pop();
            await Provider.of<MarketUseCase>(context, listen: false).updateMarket(marketMap: marketMap, marketId: marketModel.marketId);
          } else {
            Navigator.pop(context);
          }
        } else {
          Navigator.pop(context);
        }
      },
      child: Text(
        appLocale.change,
        style: AppStyles.mainText,
      ),
    );
  }
}
