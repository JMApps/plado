import 'package:flutter/material.dart';

import '../../core/enums/task_period.dart';
import '../../core/enums/task_priority.dart';
import '../../core/enums/task_status.dart';

class UpdateTaskState extends ChangeNotifier {
  UpdateTaskState({
    required TaskPeriod taskPeriod,
    required TaskPriority taskPriority,
    required TaskStatus taskStatus,
    required int colorIndex,
    required DateTime taskNotificationDate,
  })  : _taskPeriod = taskPeriod,
        _taskPriority = taskPriority,
        _taskStatus = taskStatus,
        _colorIndex = colorIndex,
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

  late TaskStatus _taskStatus;

  TaskStatus get getTaskStatus => _taskStatus;

  set setTaskStatus(TaskStatus taskStatus) {
    _taskStatus = taskStatus;
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

  late DateTime _taskNotificationDate;

  DateTime get getTaskNotificationData => _taskNotificationDate;

  set setTaskNotificationDate(DateTime taskNotificationDate) {
    _taskNotificationDate = taskNotificationDate;
    notifyListeners();
  }
}
