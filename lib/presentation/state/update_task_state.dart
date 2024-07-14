import 'package:flutter/material.dart';

import '../../core/enums/task_period.dart';
import '../../core/enums/task_priority.dart';

class UpdateTaskState extends ChangeNotifier {
  UpdateTaskState({
    required TaskPeriod taskPeriod,
    required TaskPriority taskPriority,
    required int colorIndex,
    required bool isRemind,
    required int notificationId,
    required String taskNotificationDate,
  })  : _taskPeriod = taskPeriod,
        _taskPriority = taskPriority,
        _colorIndex = colorIndex,
        _isRemind = isRemind,
        _notificationId = notificationId,
        _taskNotificationDate = taskNotificationDate;

  late TaskPeriod _taskPeriod;

  TaskPeriod get getTaskPeriod => _taskPeriod;

  set setTaskPeriod(TaskPeriod taskPeriod) {
    _taskPeriod = taskPeriod;
    notifyListeners();
  }

  late TaskPriority _taskPriority;

  TaskPriority get getTaskPriority => _taskPriority;

  set setTaskPriority(TaskPriority taskPriority) {
    _taskPriority = taskPriority;
    notifyListeners();
  }

  late int _colorIndex;

  int get getColorIndex => _colorIndex;

  set setColorIndex(int colorIndex) {
    _colorIndex = colorIndex;
    notifyListeners();
  }

  late bool _isRemind;

  bool get getIsRemind => _isRemind;

  set setIsRemind(bool isRemind) {
    _isRemind = isRemind;
    notifyListeners();
  }

  late final int _notificationId;

  int get getNotificationId => _notificationId;

  late String _taskNotificationDate;

  String get getTaskNotificationDate => _taskNotificationDate;

  set setTaskNotificationDate(String taskNotificationDate) {
    _taskNotificationDate = taskNotificationDate;
    notifyListeners();
  }
}
