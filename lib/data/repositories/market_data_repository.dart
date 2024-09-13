import 'package:sqflite/sqflite.dart';

import '../../core/strings/database_values.dart';
import '../../domain/entities/market_entity.dart';
import '../../domain/repositories/market_repository.dart';
import '../models/market_model.dart';
import '../services/plado_database_service.dart';

class MarketDataRepository implements MarketRepository {
  final PladoDatabaseService _pladoDatabaseService;

  MarketDataRepository(this._pladoDatabaseService);

  @override
  Future<List<MarketEntity>> getAllMarkets({required String orderBy}) async {
    final Database database = await _pladoDatabaseService.db;
    final List<Map<String, Object?>> resources = await database.query(DatabaseValues.dbMarketTableName, orderBy: orderBy);
    final List<MarketEntity> allMarkets = resources.isNotEmpty ? resources.map((e) => MarketEntity.fromModel(MarketModel.fromMap(e))).toList() : [];
    return allMarkets;
  }

  @override
  Future<int> createMarket({required MarketModel marketModel}) async {
    final Database database = await _pladoDatabaseService.db;
    final int createMarket = await database.insert(DatabaseValues.dbMarketTableName, marketModel.marketToMap());
    return createMarket;
  }

  @override
  Future<int> updateMarket({required Map<String, dynamic> marketMap, required int marketId}) async {
    final Database database = await _pladoDatabaseService.db;
    final int updateMarket = await database.update(DatabaseValues.dbMarketTableName, marketMap, where: '${DatabaseValues.dbMarketId} = ?', whereArgs: [marketId], conflictAlgorithm: ConflictAlgorithm.replace);
    return updateMarket;
  }

  @override
  Future<int> deleteMarket({required int marketId}) async {
    final Database database = await _pladoDatabaseService.db;
    final int deleteMarket = await database.delete(DatabaseValues.dbMarketTableName, where: '${DatabaseValues.dbMarketId} = ?', whereArgs: [marketId]);
    return deleteMarket;
  }
}