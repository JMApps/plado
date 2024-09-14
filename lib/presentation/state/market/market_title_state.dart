import 'package:flutter/material.dart';

class MarketTitleState extends ChangeNotifier {
  MarketTitleState([String categoryTitle = '']) : _marketTitle = categoryTitle;

  late String _marketTitle;

  String get getMarketTitle => _marketTitle;

  set setMarketTitle(String categoryTitle) {
    _marketTitle = categoryTitle;
    notifyListeners();
  }
}