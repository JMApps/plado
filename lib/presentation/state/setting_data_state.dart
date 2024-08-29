import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../core/strings/app_constraints.dart';

class SettingDataState extends ChangeNotifier {
  final Box _mainSettingsBox = Hive.box(AppConstraints.keyMainAppSettingsBox);

  SettingDataState() {
    timeago.setLocaleMessages('ru', timeago.RuMessages());
    timeago.setLocaleMessages('en', timeago.EnMessages());
    timeago.setLocaleMessages('tr', timeago.TrMessages());

    _localeIndex = _mainSettingsBox.get(AppConstraints.keyLocaleIndex, defaultValue: 0);
    _themeIndex = _mainSettingsBox.get(AppConstraints.keyThemeIndex, defaultValue: 2);
    _alwaysOnDisplay = _mainSettingsBox.get(AppConstraints.keyAlwaysOnDisplay, defaultValue: true);
    _colorThemeIndex = _mainSettingsBox.get(AppConstraints.keyColorThemeIndex, defaultValue: 0);
    _updateWakelock();
  }

  late int _localeIndex;

  int get getLocaleIndex => _localeIndex;

  set setLocaleIndex(int localeIndex) {
    if (_localeIndex != localeIndex) {
      _localeIndex = localeIndex;
      _saveSetting(AppConstraints.keyLocaleIndex, localeIndex);
      notifyListeners();
    }
  }

  late int _themeIndex;

  int get getThemeIndex => _themeIndex;

  set setThemeIndex(int themeIndex) {
    _themeIndex = themeIndex;
    _saveSetting(AppConstraints.keyThemeIndex, themeIndex);
    notifyListeners();
  }

  ThemeMode get getThemeMode {
    switch (_themeIndex) {
      case 0:
        return ThemeMode.light;
      case 1:
        return ThemeMode.dark;
      case 2:
        return ThemeMode.system;
      default:
        return ThemeMode.system;
    }
  }

  late bool _alwaysOnDisplay;

  bool get getAlwaysOnDisplay => _alwaysOnDisplay;

  set setAlwaysOnDisplay(bool value) {
    _alwaysOnDisplay = value;
    _saveSetting(AppConstraints.keyAlwaysOnDisplay, value);
    _updateWakelock();
    notifyListeners();
  }

  late int _colorThemeIndex;

  int get getColorThemeIndex => _colorThemeIndex;

  set setColorThemeIndex(int colorIndex) {
    _colorThemeIndex = colorIndex;
    _saveSetting(AppConstraints.keyColorThemeIndex, colorIndex);
    notifyListeners();
  }

  Future<void> _saveSetting(String key, dynamic value) async {
    await _mainSettingsBox.put(key, value);
  }

  void _updateWakelock() {
    if (_alwaysOnDisplay) {
      WakelockPlus.enable();
    } else {
      WakelockPlus.disable();
    }
  }
}
