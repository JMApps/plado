import 'package:flutter/material.dart';

import '../../../core/strings/app_constraints.dart';
import '../../../core/strings/database_values.dart';

class HabitSortState extends ChangeNotifier {
  int _sortIndex = 0;

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
    // Save index value
    notifyListeners();
  }

  int _orderIndex = 0;

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
    // Save index value
    notifyListeners();
  }
}
