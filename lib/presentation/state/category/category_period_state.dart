import 'package:flutter/material.dart';

class CategoryPeriodState extends ChangeNotifier {
  CategoryPeriodState(this._categoryPeriodIndex);

  late int _categoryPeriodIndex;

  int get getCategoryPeriodIndex => _categoryPeriodIndex;

  set setCategoryPeriodIndex(int categoryPeriodIndex) {
    _categoryPeriodIndex = categoryPeriodIndex;
    notifyListeners();
  }
}
