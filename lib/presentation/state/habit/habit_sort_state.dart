import 'package:flutter/material.dart';

import '../../../core/strings/app_constraints.dart';
import '../../../core/strings/database_values.dart';
import '../../../data/repositories/setting_data_repository.dart';
import '../../../domain/usecases/setting_use_case.dart';

class HabitSortState extends ChangeNotifier {
  final SettingUseCase _settingUseCase = SettingUseCase(SettingDataRepository());

  HabitSortState() {
    loadSettings();
  }

  Future<void> loadSettings() async {
    _sortIndex = await _settingUseCase.getSettingIndex(columnName: DatabaseValues.dbSortHabitIndex);
    _orderIndex = await _settingUseCase.getSettingIndex(columnName: DatabaseValues.dbSortOrderHabitIndex);
  }

  late int _sortIndex;

  int get getSortIndex => _sortIndex;

  String _sort = DatabaseValues.dbHabitId;

  String get getSort => _sort;

  set setSortIndex(int sortIndex) {
    _sortIndex = sortIndex;
    switch (_sortIndex) {
      case 0:
        _sort = DatabaseValues.dbHabitId;
        break;
      case 1:
        _sort = DatabaseValues.dbHabitTitle;
        break;
      case 2:
        _sort = DatabaseValues.dbHabitColorIndex;
        break;
    }
    _saveSortValue(DatabaseValues.dbSortHabitIndex, _sortIndex);
    notifyListeners();
  }

  late int _orderIndex;

  int get getOrderIndex => _orderIndex;

  String _order = AppConstraints.descSort;

  String get getOrder => _order;

  set setOrderIndex(int orderIndex) {
    _orderIndex = orderIndex;
    switch (_orderIndex) {
      case 0:
        _order = AppConstraints.descSort;
        break;
      case 1:
        _order = AppConstraints.ascSort;
        break;
      default:
        _order = AppConstraints.descSort;
    }
    _saveSortValue(DatabaseValues.dbSortOrderHabitIndex, _orderIndex);
    notifyListeners();
  }

  Future<void> _saveSortValue(String columnName, int settingIndex) async {
    await _settingUseCase.saveSettingIndex(columnName: columnName, settingIndex: settingIndex);
  }
}
