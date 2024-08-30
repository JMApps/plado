import 'package:flutter/material.dart';

import '../../../core/strings/database_values.dart';
import '../../../data/repositories/setting_data_repository.dart';
import '../../../domain/usecases/setting_use_case.dart';

class TaskSortState extends ChangeNotifier {
  final SettingUseCase _settingUseCase = SettingUseCase(SettingDataRepository());

  TaskSortState() {
    loadSettings();
  }

  Future<void> loadSettings() async {
    _sortIndex = await _settingUseCase.getSettingIndex(columnName: DatabaseValues.dbSortTaskIndex);
    _orderIndex = await _settingUseCase.getSettingIndex(columnName: DatabaseValues.dbSortOrderTaskIndex);
  }

  int _sortIndex = 0;

  int get getSortIndex => _sortIndex;

  set setSortIndex(int sortIndex) {
    _sortIndex = sortIndex;
    _saveSortValue(DatabaseValues.dbSortTaskIndex, _sortIndex);
    notifyListeners();
  }

  int _orderIndex = 0;

  int get getOrderIndex => _orderIndex;

  set setOrderIndex(int orderIndex) {
    _orderIndex = orderIndex;
    _saveSortValue(DatabaseValues.dbSortOrderTaskIndex, _orderIndex);
    notifyListeners();
  }

  Future<void> _saveSortValue(String columnName, int settingIndex) async {
    await _settingUseCase.saveSettingIndex(columnName: columnName, settingIndex: settingIndex);
  }
}
