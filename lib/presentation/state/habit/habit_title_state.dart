import 'package:flutter/material.dart';

class HabitTitleState extends ChangeNotifier {
  HabitTitleState([String habitTitle = '']) : _habitTitle = habitTitle;

  late String _habitTitle;

  String get getHabitTitle => _habitTitle;

  set setTaskTitle(String habitTitle) {
    _habitTitle = habitTitle;
    notifyListeners();
  }
}