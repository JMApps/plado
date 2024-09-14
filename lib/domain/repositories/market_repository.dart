import '../../data/models/market_model.dart';
import '../entities/market_entity.dart';

abstract class MarketRepository {
  Future<List<MarketEntity>> getAllMarkets({required String orderBy});

  Future<int> clearList();

  Future<int> createMarket({required MarketModel marketModel});

  Future<int> updateMarket({required Map<String, dynamic> marketMap, required int marketId});

  Future<int> deleteMarket({required int marketId});
}