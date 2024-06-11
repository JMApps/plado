import 'package:flutter/cupertino.dart';

import '../../domain/entities/habit_entity.dart';
import '../../domain/usecases/habit_use_case.dart';
import '../repositories/habit_data_repository.dart';

class HabitDataState extends ChangeNotifier {
  final HabitUseCase _habitUseCase = HabitUseCase(HabitDataRepository());

  Future<List<HabitEntity>> getAllHabits({required String orderBy}) async {
    return await _habitUseCase.getAllHabits(orderBy: orderBy);
  }

  Future<HabitEntity> getHabitById({required int habitId}) async {
    return await _habitUseCase.getHabitById(habitId: habitId);
  }

  Future<List<HabitEntity>> searchHabits({required String searchQuery}) async {
    return await _habitUseCase.getSearchHabits(searchQuery: searchQuery);
  }

  Future<int> createHabit({required Map<String, dynamic> habit}) async {
    final int createHabit = await _habitUseCase.createHabit(habit: habit);
    notifyListeners();
    return createHabit;
  }

  Future<int> updateHabit({required Map<String, dynamic> habit, required int habitId}) async {
    final int updateHabit = await _habitUseCase.updateHabit(habit: habit, habitId: habitId);
    notifyListeners();
    return updateHabit;
  }

  Future<int> deleteHabit({required int habitId}) async {
    final int deleteHabit = await _habitUseCase.deleteHabit(habitId: habitId);
    notifyListeners();
    return deleteHabit;
  }
}