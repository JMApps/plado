abstract class SettingRepository {
  Future<int> saveSettingIndex({required String columnName, required int settingIndex});

  Future<int> getSettingIndex({required String columnName});
}
