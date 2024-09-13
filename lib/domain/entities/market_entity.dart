import 'package:plado/data/models/market_model.dart';

class MarketEntity {
  final int marketId;
  final String marketTitle;
  final int marketStatusIndex;

  MarketEntity({
    required this.marketId,
    required this.marketTitle,
    required this.marketStatusIndex,
  });

  factory MarketEntity.fromModel(MarketModel marketModel) {
    return MarketEntity(
      marketId: marketModel.marketId,
      marketTitle: marketModel.marketTitle,
      marketStatusIndex: marketModel.marketStatusIndex,
    );
  }
}
