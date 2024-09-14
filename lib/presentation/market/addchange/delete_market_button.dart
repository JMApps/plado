import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../core/styles/app_styles.dart';
import '../../../domain/usecases/market_use_case.dart';

class DeleteMarketButton extends StatelessWidget {
  const DeleteMarketButton({
    super.key,
    required this.marketId,
  });

  final int marketId;

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    return OutlinedButton(
      onPressed: () async {
        Navigator.pop(context);
        await Provider.of<MarketUseCase>(context, listen: false).deleteMarket(marketId: marketId);
      },
      child: Text(
        appLocale.delete,
        style: AppStyles.mainText,
      ),
    );
  }
}
