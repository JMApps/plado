import '../entities/habit_entity.dart';

abstract class HabitRepository {
  Future<List<HabitEntity>> getAllHabits({required String orderBy});

  Future<HabitEntity> getHabitById({required int habitId});

  Future<int> createHabit({required HabitEntity habitEntity});

  Future<int> updateHabit({required HabitEntity habitEntity, required int habitId});

  Future<int> deleteHabit({required int habitId});
}