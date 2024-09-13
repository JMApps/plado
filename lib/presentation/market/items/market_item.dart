import 'package:flutter/material.dart';

import '../../../core/styles/app_styles.dart';
import '../../../domain/entities/market_entity.dart';

class MarketItem extends StatelessWidget {
  const MarketItem({
    super.key,
    required this.marketModel,
    required this.marketItemIndex,
  });

  final MarketEntity marketModel;
  final int marketItemIndex;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: AppStyles.paddingBottomMini,
      child: Text(marketModel.marketTitle),
    );
  }
}
