import 'package:flutter/material.dart';

class TaskPriorityState extends ChangeNotifier {
  TaskPriorityState([int taskPriorityIndex = 0]) : _taskPriorityIndex = taskPriorityIndex;

  late int _taskPriorityIndex;

  int get getTaskPriorityIndex => _taskPriorityIndex;

  set setTaskPriorityIndex(int taskPriorityIndex) {
    _taskPriorityIndex = taskPriorityIndex;
    notifyListeners();
  }
}