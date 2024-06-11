import '../entities/habit_entity.dart';

abstract class HabitRepository {
  Future<List<HabitEntity>> getAllHabits({required String orderBy});

  Future<HabitEntity> getHabitById({required int habitId});

  Future<int> createHabit({required Map<String, dynamic> habit});

  Future<int> updateHabit({required Map<String, dynamic> habit, required int habitId});

  Future<int> deleteHabit({required int habitId});
}