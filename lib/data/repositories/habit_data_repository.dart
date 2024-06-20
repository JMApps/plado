import 'package:sqflite/sqflite.dart';

import '../../domain/entities/habit_entity.dart';
import '../../domain/repositories/habit_repository.dart';
import '../models/habit_model.dart';
import '../services/plado_database_service.dart';

class HabitDataRepository implements HabitRepository {
  final PladoDatabaseService _pladoDatabaseService = PladoDatabaseService();
  final String _tasksTableName = 'Table_of_habit';

  @override
  Future<List<HabitEntity>> getAllHabits({required String orderBy}) async {
    final Database database = await _pladoDatabaseService.db;
    final List<Map<String, Object?>> resources = await database.query(_tasksTableName, orderBy: orderBy);
    final List<HabitEntity> allHabits = resources.isNotEmpty ? resources.map((e) => HabitEntity.fromModel(HabitModel.fromMap(e))).toList() : [];
    return allHabits;
  }

  @override
  Future<HabitEntity> getHabitById({required int habitId}) async {
    final Database database = await _pladoDatabaseService.db;
    final List<Map<String, Object?>> resources = await database.query(_tasksTableName, where: 'habit_id = ?', whereArgs: [habitId]);
    final HabitEntity? habitById = resources.isNotEmpty ? HabitEntity.fromModel(HabitModel.fromMap(resources.first)) : null;
    return habitById!;
  }

  @override
  Future<int> createHabit({required Map<String, dynamic> habitMap}) async {
    final Database database = await _pladoDatabaseService.db;
    final int createHabit = await database.insert(_tasksTableName, habitMap, conflictAlgorithm: ConflictAlgorithm.ignore);
    return createHabit;
  }

  @override
  Future<int> updateHabit({required Map<String, dynamic> habitMap, required int habitId}) async {
    final Database database = await _pladoDatabaseService.db;
    final int updateHabit = await database.update(_tasksTableName, habitMap, where: 'habit_id = ?', whereArgs: [habitId], conflictAlgorithm: ConflictAlgorithm.ignore);
    return updateHabit;
  }

  @override
  Future<int> deleteHabit({required int habitId}) async {
    final Database database = await _pladoDatabaseService.db;
    final int deleteHabit = await database.delete(_tasksTableName, where: 'habit_id = ?', whereArgs: [habitId]);
    return deleteHabit;
  }
}