import 'package:flutter/material.dart';

import '../../../core/strings/app_constraints.dart';

class HabitSortState extends ChangeNotifier {
  int _sortIndex = 0;

  int get getSortIndex => _sortIndex;

  String _sort = 'habit_id';

  String get getSort => _sort;

  set setSortIndex(int sortIndex) {
    _sortIndex = sortIndex;
    switch (_sortIndex) {
      case 0:
        _sort = 'habit_id';
        break;
      case 1:
        _sort = 'habit_title';
        break;
      case 2:
        _sort = 'habit_color';
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
