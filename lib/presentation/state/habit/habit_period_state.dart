import 'package:flutter/material.dart';

class HabitPeriodState extends ChangeNotifier {
  int _habitPeriodIndex = 0;

  int get getHabitPeriodIndex => _habitPeriodIndex;

  set setHabitPeriodIndex(int habitPeriodIndex) {
    _habitPeriodIndex = habitPeriodIndex;
    notifyListeners();
  }
}
