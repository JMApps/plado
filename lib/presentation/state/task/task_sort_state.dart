import 'package:flutter/material.dart';

import '../../../core/strings/app_constraints.dart';
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

  late int _sortIndex;

  int get getSortIndex => _sortIndex;

  String _sort = DatabaseValues.dbTaskId;

  String get getSort => _sort;

  set setSortIndex(int sortIndex) {
    _sortIndex = sortIndex;
    switch (_sortIndex) {
      case 0:
        _sort = DatabaseValues.dbTaskId;
        break;
      case 1:
        _sort = DatabaseValues.dbTaskTitle;
        break;
      case 2:
        _sort = DatabaseValues.dbTaskPriorityIndex;
        break;
      case 3:
        _sort = DatabaseValues.dbTaskColorIndex;
        break;
      default:
        _sort = DatabaseValues.dbTaskId;
    }
    _saveSortValue(DatabaseValues.dbSortTaskIndex, _sortIndex);
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
    _saveSortValue(DatabaseValues.dbSortOrderTaskIndex, _orderIndex);
    notifyListeners();
  }

  Future<void> _saveSortValue(String columnName, int settingIndex) async {
    await _settingUseCase.saveSettingIndex(columnName: columnName, settingIndex: settingIndex);
  }
}
