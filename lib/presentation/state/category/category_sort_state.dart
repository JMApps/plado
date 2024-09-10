import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../../core/strings/app_constraints.dart';

class CategorySortState extends ChangeNotifier {
  final Box _mainSettingsBox = Hive.box(AppConstraints.keyMainAppSettingsBox);

  CategorySortState() {
    _sortIndex = _mainSettingsBox.get(AppConstraints.keyCategorySortIndex, defaultValue: 0);
    _orderIndex = _mainSettingsBox.get(AppConstraints.keyCategoryOrderIndex, defaultValue: 0);
  }

  late int _sortIndex;

  int get getSortIndex => _sortIndex;

  set setSortIndex(int sortIndex) {
    _sortIndex = sortIndex;
    _saveSetting(AppConstraints.keyCategorySortIndex, _sortIndex);
    notifyListeners();
  }

  late int _orderIndex;

  int get getOrderIndex => _orderIndex;

  set setOrderIndex(int orderIndex) {
    _orderIndex = orderIndex;
    _saveSetting(AppConstraints.keyCategoryOrderIndex, _orderIndex);
    notifyListeners();
  }

  Future<void> _saveSetting(String key, int value) async {
    await _mainSettingsBox.put(key, value);
  }
}
