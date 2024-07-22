import 'package:flutter/material.dart';

class TaskNotificationDateState extends ChangeNotifier {
  TaskNotificationDateState([String taskNotificationDate = '']) : _taskNotificationDate = taskNotificationDate;

  late String _taskNotificationDate;

  String get getTaskNotificationDate => _taskNotificationDate;

  set setTaskNotificationDate(String taskNotificationDate) {
    _taskNotificationDate = taskNotificationDate;
    notifyListeners();
  }
}