import '../repositories/setting_repository.dart';

class SettingUseCase {
  final SettingRepository _settingRepository;

  SettingUseCase(this._settingRepository);

  Future<int> saveSettingIndex({required String columnName, required int settingIndex}) async {
    return await _settingRepository.saveSettingIndex(columnName: columnName, settingIndex: settingIndex);
  }

  Future<int> getSettingIndex({required String columnName}) async {
    return await _settingRepository.getSettingIndex(columnName: columnName);
  }
}
