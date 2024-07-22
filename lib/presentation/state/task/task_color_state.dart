import 'package:flutter/material.dart';

class TaskColorState extends ChangeNotifier {
  TaskColorState([int colorIndex = 0]) : _colorIndex = colorIndex;

  late int _colorIndex;

  int get getColorIndex => _colorIndex;

  set setColorIndex(int colorIndex) {
    _colorIndex = colorIndex;
    notifyListeners();
  }
}
