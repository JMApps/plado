import 'package:flutter/material.dart';

class HabitColorState extends ChangeNotifier {
  HabitColorState([int colorIndex = 0]) : _colorIndex = colorIndex;

  late int _colorIndex;

  int get getColorIndex => _colorIndex;

  set setColorIndex(int colorIndex) {
    _colorIndex = colorIndex;
    notifyListeners();
  }
}
