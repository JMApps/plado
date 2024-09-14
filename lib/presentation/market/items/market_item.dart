import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/strings/database_values.dart';
import '../../../core/styles/app_styles.dart';
import '../../../domain/entities/market_entity.dart';
import '../../../domain/usecases/market_use_case.dart';
import '../addchange/change_market_bottom_sheet.dart';

class MarketItem extends StatefulWidget {
  const MarketItem({
    super.key,
    required this.marketModel,
    required this.marketItemIndex,
  });

  final MarketEntity marketModel;
  final int marketItemIndex;

  @override
  State<MarketItem> createState() => _MarketItemState();
}

class _MarketItemState extends State<MarketItem> {
  @override
  Widget build(BuildContext context) {
    final bool marketStatus = widget.marketModel.marketStatusIndex == 0 ? false : true;
    return Card(
      elevation: 0,
      margin: AppStyles.paddingBottomMini,
      child: ListTile(
        onTap: () {
          _changeStatus();
        },
        onLongPress: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => AnimatedPadding(
              padding: MediaQuery.of(context).viewInsets,
              duration: const Duration(milliseconds: 250),
              curve: Curves.decelerate,
              child: ChangeMarketBottomSheet(marketModel: widget.marketModel),
            ),
          );
        },
        shape: AppStyles.shape,
        visualDensity: VisualDensity.comfortable,
        title: Text(
          widget.marketModel.marketTitle,
          style: TextStyle(
            decoration: widget.marketModel.marketStatusIndex == 0
                ? TextDecoration.none
                : TextDecoration.lineThrough,
          ),
        ),
        trailing: Checkbox(
          value: marketStatus,
          onChanged: (bool? onChanged) {
            _changeStatus();
          },
        ),
      ),
    );
  }

  _changeStatus() {
    final Map<String, dynamic> marketToMap = {
      DatabaseValues.dbMarketStatusIndex: widget.marketModel.marketStatusIndex == 0 ? 1 : 0,
    };
    Provider.of<MarketUseCase>(context, listen: false).updateMarket(
      marketMap: marketToMap,
      marketId: widget.marketModel.marketId,
    );
  }
}
