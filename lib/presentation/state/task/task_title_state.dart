import 'package:flutter/material.dart';

class TaskTitleState extends ChangeNotifier {
  TaskTitleState([String taskTitle = '']) : _taskTitle = taskTitle;

  late String _taskTitle;

  String get getTaskTitle => _taskTitle;

  set setTaskTitle(String taskTitle) {
    _taskTitle = taskTitle;
    notifyListeners();
  }
}