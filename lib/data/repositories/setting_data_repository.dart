
import 'package:sqflite/sqflite.dart';

import '../../core/strings/database_values.dart';
import '../../domain/repositories/setting_repository.dart';
import '../services/plado_database_service.dart';

class SettingDataRepository implements SettingRepository {
  final PladoDatabaseService _pladoDatabaseService = PladoDatabaseService();

  @override
  Future<int> saveSettingIndex({required String columnName, required int settingIndex}) async {
    final Database database = await _pladoDatabaseService.db;

    Map<String, dynamic> settingValue = {
      columnName: settingIndex,
    };

    final int settings = await database.update(DatabaseValues.dbSettingTableName, settingValue);
    return settings;
  }

  @override
  Future<int> getSettingIndex({required String columnName}) async {
    final Database database = await _pladoDatabaseService.db;

    final List<Map<String, dynamic>> result = await database.query(
      DatabaseValues.dbSettingTableName,
      columns: [columnName],
    );

    return result.first[columnName] as int;
  }
}