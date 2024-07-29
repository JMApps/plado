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

  Future<int> createHabit({required Map<String, dynamic> habitMap}) async {
    final int createHabit = await _habitUseCase.createHabit(habitMap: habitMap);
    notifyListeners();
    return createHabit;
  }

  Future<int> updateHabit({required Map<String, dynamic> habitMap, required int habitId}) async {
    final int updateHabit = await _habitUseCase.updateHabit(habitMap: habitMap, habitId: habitId);
    notifyListeners();
    return updateHabit;
  }

  Future<int> deleteHabit({required int habitId}) async {
    final int deleteHabit = await _habitUseCase.deleteHabit(habitId: habitId);
    notifyListeners();
    return deleteHabit;
  }

  Future<List<bool>> completedDays({required int habitId}) async {
    return await _habitUseCase.completedDays(habitId: habitId);
  }
}