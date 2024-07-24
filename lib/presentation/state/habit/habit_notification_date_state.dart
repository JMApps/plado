import 'package:flutter/material.dart';

class HabitNotificationDateState extends ChangeNotifier {
  HabitNotificationDateState([String habitNotificationDate = '']) : _habitNotificationDate = habitNotificationDate;

  late String _habitNotificationDate;

  String get getHabitNotificationDate => _habitNotificationDate;

  set setTaskNotificationDate(String habitNotificationDate) {
    _habitNotificationDate = habitNotificationDate;
    notifyListeners();
  }
}