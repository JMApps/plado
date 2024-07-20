import 'package:flutter/material.dart';

class HabitItemState extends ChangeNotifier {
  bool _dayIsTrue = false;

  bool get getDayIsTrue => _dayIsTrue;

  set setDayIsTrue(bool dayIsTrue) {
    _dayIsTrue = dayIsTrue;
    notifyListeners();
  }
}