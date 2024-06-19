import '../../core/strings/app_exception_messages.dart';
import '../entities/habit_entity.dart';
import '../repositories/habit_repository.dart';

class HabitUseCase {
  final HabitRepository _habitRepository;

  HabitUseCase(this._habitRepository);

  Future<List<HabitEntity>> getAllHabits({required String orderBy}) async {
    try {
      return await _habitRepository.getAllHabits(orderBy: orderBy);
    } catch (e) {
      throw Exception('${AppExceptionMessages.getAllHabitException} $e');
    }
  }

  Future<HabitEntity> getHabitById({required int habitId}) async {
    try {
      return await _habitRepository.getHabitById(habitId: habitId);
    } catch (e) {
      throw Exception('${AppExceptionMessages.getHabitByIdException} $e');
    }
  }

  Future<List<HabitEntity>> getSearchHabits({required String searchQuery}) async {
    try {
      return await _habitRepository.searchHabits(searchQuery: searchQuery);
    } catch (e) {
      throw Exception('${AppExceptionMessages.getSearchHabitException} $e');
    }
  }

  Future<int> createHabit({required Map<String, dynamic> habitMap}) async {
    try {
      return await _habitRepository.createHabit(habitMap: habitMap);
    } catch (e) {
      throw Exception('${AppExceptionMessages.createHabitException} $e');
    }
  }

  Future<int> updateHabit({required Map<String, dynamic> habitMap, required int habitId}) async {
    try {
      return await _habitRepository.updateHabit(habitMap: habitMap, habitId: habitId);
    } catch (e) {
      throw Exception('${AppExceptionMessages.updateHabitException} $e');
    }
  }

  Future<int> deleteHabit({required int habitId}) async {
    try {
      return await _habitRepository.deleteHabit(habitId: habitId);
    } catch (e) {
      throw Exception('${AppExceptionMessages.deleteHabitException} $e');
    }
  }
}
