import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class SettingsState extends ChangeNotifier {

  int _themeIndex = 2;

  int get getThemeIndex => _themeIndex;

  set setThemeIndex(int themeIndex) {
    _themeIndex = themeIndex;
    notifyListeners();
  }

  ThemeMode get getThemeMode {
    late ThemeMode themeMode;
    switch (_themeIndex) {
      case 0:
        themeMode = ThemeMode.light;
        break;
      case 1:
        themeMode = ThemeMode.dark;
        break;
      case 2:
        themeMode = ThemeMode.system;
        break;
    }
    return themeMode;
  }

  bool _alwaysOnDisplay = true;

  bool get getAlwaysOnDisplay => _alwaysOnDisplay;

  set setAlwaysOnDisplay(bool alwaysOnDisplay) {
    _alwaysOnDisplay = alwaysOnDisplay;
    alwaysOnDisplay ? WakelockPlus.enable() : WakelockPlus.disable();
    notifyListeners();
  }
}