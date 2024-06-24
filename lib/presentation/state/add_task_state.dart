import 'package:flutter/material.dart';

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

  int _colorIndex = 0;

  int get getColorIndex => _colorIndex;

  set setColorIndex(int colorIndex) {
    _colorIndex = colorIndex;
    notifyListeners();
  }
}