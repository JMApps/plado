import 'package:flutter/material.dart';

class TaskColorState extends ChangeNotifier {
  int _colorIndex = 0;

  int get getColorIndex => _colorIndex;

  set setColorIndex(int colorIndex) {
    _colorIndex = colorIndex;
    notifyListeners();
  }
}