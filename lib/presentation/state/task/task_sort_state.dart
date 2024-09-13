import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/strings/app_constraints.dart';

class TaskSortState extends ChangeNotifier {
  final Box _mainSettingsBox = Hive.box(AppConstraints.keyMainAppSettingsBox);

  TaskSortState() {
    _sortIndex = _mainSettingsBox.get(AppConstraints.keyTaskSortIndex, defaultValue: 0);
    _orderIndex = _mainSettingsBox.get(AppConstraints.keyTaskOrderIndex, defaultValue: 0);
  }

  late int _sortIndex;

  int get getSortIndex => _sortIndex;

  set setSortIndex(int sortIndex) {
    _sortIndex = sortIndex;
    _saveSetting(AppConstraints.keyTaskSortIndex, sortIndex);
    notifyListeners();
  }

  late int _orderIndex;

  int get getOrderIndex => _orderIndex;

  set setOrderIndex(int orderIndex) {
    _orderIndex = orderIndex;
    _saveSetting(AppConstraints.keyTaskOrderIndex, orderIndex);
    notifyListeners();
  }

  Future<void> _saveSetting(String key, int value) async {
    await _mainSettingsBox.put(key, value);
  }
}
