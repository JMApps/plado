import 'package:flutter/material.dart';

import '../../core/strings/app_constraints.dart';
import '../../data/models/market_model.dart';
import '../entities/market_entity.dart';
import '../repositories/market_repository.dart';

class MarketUseCase extends ChangeNotifier {
  final MarketRepository _marketRepository;

  MarketUseCase(this._marketRepository);

  Future<List<MarketEntity>> fetchAllMarkets({required String orderBy}) async {
    try {
      return await _marketRepository.getAllMarkets(orderBy: orderBy);
    } catch (e) {
      throw Exception('${AppConstraints.errorMessage} $e');
    }
  }

  Future<int> createMarket({required MarketModel marketModel}) async {
    try {
      final int createMarket = await _marketRepository.createMarket(marketModel: marketModel);
      notifyListeners();
      return createMarket;
    } catch (e) {
      throw Exception('${AppConstraints.errorMessage} $e');
    }
  }

  Future<int> updateMarket({required Map<String, dynamic> marketMap, required int marketId}) async {
    try {
      final int updateMarket = await _marketRepository.updateMarket(marketMap: marketMap, marketId: marketId);
      notifyListeners();
      return updateMarket;
    } catch (e) {
      throw Exception('${AppConstraints.errorMessage} $e');
    }
  }

  Future<int> deleteMarket({required int marketId}) async {
    try {
      final int deleteMarket = await _marketRepository.deleteMarket(marketId: marketId);
      notifyListeners();
      return deleteMarket;
    } catch (e) {
      throw Exception('${AppConstraints.errorMessage} $e');
    }
  }
}