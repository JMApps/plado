import '../../data/models/all_habit_count_model.dart';
import '../../data/models/habit_model.dart';
import '../entities/habit_entity.dart';

abstract class HabitRepository {
  Future<List<HabitEntity>> getAllHabits({required String orderBy});

  Future<HabitEntity> getHabitById({required int habitId});

  Future<AllHabitCountModel> getAllHabitsNumber();

  Future<List<bool>> completedDays({required int habitId});

  Future<int> createHabit({required HabitModel habitModel});

  Future<int> updateHabit({required Map<String, dynamic> habitMap, required int habitId});

  Future<int> deleteHabit({required int habitId});
}
