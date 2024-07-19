import 'package:flutter/material.dart';

import '../../core/enums/habit_period.dart';

class CreateHabitState extends ChangeNotifier {

  HabitPeriod _habitPeriod = HabitPeriod.days21;

  HabitPeriod get getHabitPeriod => _habitPeriod;

  set setHabitPeriod(HabitPeriod habitPeriod) {
    _habitPeriod = habitPeriod;
    notifyListeners();
  }

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
}