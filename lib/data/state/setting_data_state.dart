import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../core/strings/database_values.dart';
import '../../domain/usecases/setting_use_case.dart';
import '../repositories/setting_data_repository.dart';

class SettingDataState extends ChangeNotifier {
  final SettingUseCase _settingUseCase = SettingUseCase(SettingDataRepository());

  SettingDataState() {
    loadSettings();
  }

  Future<void> loadSettings() async {
    timeago.setLocaleMessages('ru', timeago.RuMessages());
    timeago.setLocaleMessages('en', timeago.EnMessages());
    timeago.setLocaleMessages('tr', timeago.TrMessages());

    _localeIndex = await _settingUseCase.getSettingIndex(columnName: DatabaseValues.dbLocaleIndex);
    _themeIndex = await _settingUseCase.getSettingIndex(columnName: DatabaseValues.dbAppThemeIndex);
    _alwaysOnDisplay = await _settingUseCase.getSettingIndex(columnName: DatabaseValues.dbAlwaysDisplayIndex) == 1;
    _colorThemeIndex = await _settingUseCase.getSettingIndex(columnName: DatabaseValues.dbColorThemeIndex);
    _updateWakelock();
  }

  late int _localeIndex;

  int get getLocaleIndex => _localeIndex;

  set setLocaleIndex(int localeIndex) {
    if (_localeIndex != localeIndex) {
      _localeIndex = localeIndex;
      _saveSettingIndex(DatabaseValues.dbLocaleIndex, _localeIndex);
      notifyListeners();
    }
  }

  late int _themeIndex;

  int get getThemeIndex => _themeIndex;

  set setThemeIndex(int index) {
    _themeIndex = index;
    _saveSettingIndex(DatabaseValues.dbAppThemeIndex, _themeIndex);
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
    _saveSettingIndex(DatabaseValues.dbAlwaysDisplayIndex, value ? 1 : 0);
    _updateWakelock();
    notifyListeners();
  }

  late int _colorThemeIndex;

  int get getColorThemeIndex => _colorThemeIndex;

  set setColorThemeIndex(int colorIndex) {
    _colorThemeIndex = colorIndex;
    _saveSettingIndex(DatabaseValues.dbColorThemeIndex, colorIndex);
    notifyListeners();
  }

  Future<void> _saveSettingIndex(String columnName, int settingIndex) async {
    await _settingUseCase.saveSettingIndex(columnName: columnName, settingIndex: settingIndex);
  }

  void _updateWakelock() {
    if (_alwaysOnDisplay) {
      WakelockPlus.enable();
    } else {
      WakelockPlus.disable();
    }
  }
}
