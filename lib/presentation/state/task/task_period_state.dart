import 'package:flutter/material.dart';

class TaskPeriodState extends ChangeNotifier {

  TaskPeriodState(this._taskPeriodIndex);

  late int _taskPeriodIndex;

  int get getTaskPeriodIndex => _taskPeriodIndex;

  set setTaskPeriodIndex(int taskPeriodIndex) {
    _taskPeriodIndex = taskPeriodIndex;
    notifyListeners();
  }
}