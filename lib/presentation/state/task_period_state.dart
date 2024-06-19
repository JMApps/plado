import 'package:flutter/material.dart';

import '../../core/enums/task_period.dart';

class TaskPeriodState extends ChangeNotifier {
  TaskPeriod _taskPeriod = TaskPeriod.day;

  TaskPeriod get getTaskPeriod => _taskPeriod;

  set setTaskPeriod(TaskPeriod taskPeriod) {
    _taskPeriod = taskPeriod;
    notifyListeners();
  }
}
