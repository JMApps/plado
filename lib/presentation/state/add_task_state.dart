import 'package:flutter/material.dart';
import 'package:plado/core/enums/task_status.dart';

import '../../core/enums/task_period.dart';
import '../../core/enums/task_priority.dart';

class AddTaskState extends ChangeNotifier {

  TaskPeriod _taskPeriod = TaskPeriod.day;

  TaskPeriod get getTaskPeriod => _taskPeriod;

  set setTaskPeriod(TaskPeriod taskPeriod) {
    _taskPeriod = taskPeriod;
    notifyListeners();
  }

  TaskPriority _taskPriority = TaskPriority.low;

  TaskPriority get getTaskPriority => _taskPriority;

  set setTaskPriority(TaskPriority taskPriority) {
    _taskPriority = taskPriority;
    notifyListeners();
  }

  TaskStatus _taskStatus = TaskStatus.inProgress;

  TaskStatus get getTaskStatus => _taskStatus;

  set setTaskStatus(TaskStatus taskStatus) {
    _taskStatus = taskStatus;
    notifyListeners();
  }

  int _colorIndex = 0;

  int get getColorIndex => _colorIndex;

  set setColorIndex(int colorIndex) {
    _colorIndex = colorIndex;
    notifyListeners();
  }

  bool _isRemind = false;

  bool get getIsRemind => _isRemind;

  set setIsRemind(bool isRemind) {
    _isRemind = isRemind;
    notifyListeners();
  }

  late DateTime _taskDateTime;

  DateTime get getTaskDateTime => _taskDateTime;

  set setTaskDateTime(DateTime taskDateTime) {
    _taskDateTime = taskDateTime;
    notifyListeners();
  }
}