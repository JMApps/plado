import 'dart:convert';

import 'package:sqflite/sqflite.dart';

import '../../core/strings/database_values.dart';
import '../../domain/entities/habit_entity.dart';
import '../../domain/repositories/habit_repository.dart';
import '../models/habit_model.dart';
import '../services/plado_database_service.dart';

class HabitDataRepository implements HabitRepository {
  final PladoDatabaseService _pladoDatabaseService;

  HabitDataRepository(this._pladoDatabaseService);

  @override
  Future<List<HabitEntity>> getAllHabits({required String orderBy}) async {
    final Database database = await _pladoDatabaseService.db;
    final List<Map<String, Object?>> resources = await database.query(DatabaseValues.dbHabitTableName, orderBy: orderBy);
    final List<HabitEntity> allHabits = resources.isNotEmpty ? resources.map((e) => HabitEntity.fromModel(HabitModel.fromMap(e))).toList() : [];
    return allHabits;
  }

  @override
  Future<HabitEntity> getHabitById({required int habitId}) async {
    final Database database = await _pladoDatabaseService.db;
    final List<Map<String, Object?>> resources = await database.query(DatabaseValues.dbHabitTableName, where: '${DatabaseValues.dbHabitId} = ?', whereArgs: [habitId]);
    final HabitEntity? habitById = resources.isNotEmpty ? HabitEntity.fromModel(HabitModel.fromMap(resources.first)) : null;
    return habitById!;
  }

  @override
  Future<int> getAllHabitNumber() async {
    final Database database = await _pladoDatabaseService.db;
    final List<Map<String, Object?>> allHabits = await database.query(DatabaseValues.dbHabitTableName);
    return allHabits.length;
  }

  @override
  Future<List<bool>> completedDays({required int habitId}) async {
    final Database database = await _pladoDatabaseService.db;
    final List<Map<String, dynamic>> result = await database.query(DatabaseValues.dbHabitTableName, columns: [DatabaseValues.dbHabitCompletedDays], where: '${DatabaseValues.dbHabitId} = ?', whereArgs: [habitId]);

    final String completedDaysJson = result.first[DatabaseValues.dbHabitCompletedDays];
    final List<dynamic> jsonList = jsonDecode(completedDaysJson);
    final List<bool> completedDays = jsonList.map((e) => e == 1).toList();
    return completedDays;
  }

  @override
  Future<int> createHabit({required HabitModel habitModel}) async {
    final Database database = await _pladoDatabaseService.db;
    final int createHabit = await database.insert(DatabaseValues.dbHabitTableName, habitModel.habitToMap());
    return createHabit;
  }

  @override
  Future<int> updateHabit({required Map<String, dynamic> habitMap, required int habitId}) async {
    final Database database = await _pladoDatabaseService.db;
    final int updateHabit = await database.update(DatabaseValues.dbHabitTableName, habitMap, where: '${DatabaseValues.dbHabitId} = ?', whereArgs: [habitId], conflictAlgorithm: ConflictAlgorithm.replace);
    return updateHabit;
  }

  @override
  Future<int> deleteHabit({required int habitId}) async {
    final Database database = await _pladoDatabaseService.db;
    final int deleteHabit = await database.delete(DatabaseValues.dbHabitTableName, where: '${DatabaseValues.dbHabitId} = ?', whereArgs: [habitId]);
    return deleteHabit;
  }
}