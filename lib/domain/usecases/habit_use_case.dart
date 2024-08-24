import '../../data/models/all_habit_count_model.dart';
import '../entities/habit_entity.dart';
import '../repositories/habit_repository.dart';

class HabitUseCase {
  final HabitRepository _habitRepository;

  HabitUseCase(this._habitRepository);

  Future<List<HabitEntity>> getAllHabits({required String orderBy}) async {
    return await _habitRepository.getAllHabits(orderBy: orderBy);
  }

  Future<HabitEntity> getHabitById({required int habitId}) async {
    return await _habitRepository.getHabitById(habitId: habitId);
  }

  Future<AllHabitCountModel> getAllHabitsNumber() async {
    return await _habitRepository.getAllHabitsNumber();
  }

  Future<int> createHabit({required Map<String, dynamic> habitMap}) async {
    return await _habitRepository.createHabit(habitMap: habitMap);
  }

  Future<int> updateHabit({required Map<String, dynamic> habitMap, required int habitId}) async {
    return await _habitRepository.updateHabit(habitMap: habitMap, habitId: habitId);
  }

  Future<int> deleteHabit({required int habitId}) async {
    return await _habitRepository.deleteHabit(habitId: habitId);
  }

  Future<List<bool>> completedDays({required int habitId}) async {
    return await _habitRepository.completedDays(habitId: habitId);
  }
}
