import '../../core/strings/database_values.dart';

class MarketModel {
  final int marketId;
  final String marketTitle;
  final int marketStatusIndex;

  MarketModel({
    required this.marketId,
    required this.marketTitle,
    required this.marketStatusIndex,
  });

  factory MarketModel.fromMap(Map<String, dynamic> map) {
    return MarketModel(
      marketId: map[DatabaseValues.dbMarketId] as int,
      marketTitle: map[DatabaseValues.dbMarketTitle] as String,
      marketStatusIndex: map[DatabaseValues.dbMarketStatusIndex] as int,
    );
  }

  Map<String, dynamic> marketToMap() {
    return {
      DatabaseValues.dbMarketTitle: marketTitle,
      DatabaseValues.dbMarketStatusIndex: marketStatusIndex,
    };
  }
}
