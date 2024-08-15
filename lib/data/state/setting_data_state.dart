import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../core/strings/database_values.dart';
import '../../domain/usecases/setting_use_case.dart';
import '../repositories/setting_data_repository.dart';

class SettingDataState extends ChangeNotifier {
  final SettingUseCase _settingUseCase = SettingUseCase(SettingDataRepository());

  Future<void> loadSettings() async {
    _themeIndex = await _settingUseCase.getSettingIndex(columnName: DatabaseValues.dbAppThemeIndex);
    _alwaysOnDisplay = await _settingUseCase.getSettingIndex(columnName: DatabaseValues.dbAlwaysDisplayIndex) == 1;
    _updateWakelock();
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
