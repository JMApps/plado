import 'package:flutter/material.dart';

import '../../core/strings/app_constraints.dart';

class TaskSortState extends ChangeNotifier {
  int _sortIndex = 0;

  int get getSortIndex => _sortIndex;

  String _sort = 'task_id';

  String get getSort => _sort;

  set setSortIndex(int sortIndex) {
    _sortIndex = sortIndex;
    switch (_sortIndex) {
      case 0:
        _sort = 'task_id';
        break;
      case 1:
        _sort = 'task_title';
        break;
      case 2:
        _sort = 'task_priority_index';
        break;
      case 3:
        _sort = 'task_color_index';
        break;
      default:
        _sort = 'task_id';
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
