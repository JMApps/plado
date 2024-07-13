import 'package:flutter/material.dart';

import '../../core/enums/task_period.dart';
import '../../core/enums/task_priority.dart';
import '../../core/enums/task_status.dart';

class CreateTaskState extends ChangeNotifier {

  CreateTaskState(this._taskPeriod);

  late TaskPeriod _taskPeriod;

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

  final TaskStatus _taskStatus = TaskStatus.inProgress;

  TaskStatus get getTaskStatus => _taskStatus;

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

  late String _taskNotificationDate;

  String get getTaskNotificationDate => _taskNotificationDate;

  set setTaskNotificationDate(String taskNotificationDate) {
    _taskNotificationDate = taskNotificationDate;
    notifyListeners();
  }
}