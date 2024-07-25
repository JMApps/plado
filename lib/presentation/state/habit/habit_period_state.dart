import 'package:flutter/material.dart';

class HabitPeriodState extends ChangeNotifier {
  HabitPeriodState([int habitPeriodIndex = 0]) : _habitPeriodIndex = habitPeriodIndex;

  late int _habitPeriodIndex;

  int get getHabitPeriodIndex => _habitPeriodIndex;

  set setHabitPeriodIndex(int habitPeriodIndex) {
    _habitPeriodIndex = habitPeriodIndex;
    notifyListeners();
  }
}
