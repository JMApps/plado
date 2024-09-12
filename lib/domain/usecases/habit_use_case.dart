import 'package:flutter/material.dart';

import '../../core/strings/app_constraints.dart';
import '../../data/models/habit_model.dart';
import '../entities/habit_entity.dart';
import '../repositories/habit_repository.dart';

class HabitUseCase extends ChangeNotifier {
  final HabitRepository _habitRepository;

  HabitUseCase(this._habitRepository);

  Future<List<HabitEntity>> getAllHabits({required String orderBy}) async {
    try {
      return await _habitRepository.getAllHabits(orderBy: orderBy);
    } catch (e) {
      throw Exception('${AppConstraints.errorMessage} $e');
    }
  }

  Future<HabitEntity> getHabitById({required int habitId}) async {
    try {
      return await _habitRepository.getHabitById(habitId: habitId);
    } catch (e) {
      throw Exception('${AppConstraints.errorMessage} $e');
    }
  }

  Future<int> getAllHabitsNumber() async {
    try {
      return await _habitRepository.getAllHabitNumber();
    } catch (e) {
      throw Exception('${AppConstraints.errorMessage} $e');
    }
  }

  Future<List<bool>> completedDays({required int habitId}) async {
    try {
      return await _habitRepository.completedDays(habitId: habitId);
    } catch (e) {
      throw Exception('${AppConstraints.errorMessage} $e');
    }
  }

  Future<int> createHabit({required HabitModel habitModel}) async {
    try {
      final int createHabit = await _habitRepository.createHabit(habitModel: habitModel);
      notifyListeners();
      return createHabit;
    } catch (e) {
      throw Exception('${AppConstraints.errorMessage} $e');
    }
  }

  Future<int> updateHabit({required Map<String, dynamic> habitMap, required int habitId}) async {
    try {
      final int updateHabit =  await _habitRepository.updateHabit(habitMap: habitMap, habitId: habitId);
      notifyListeners();
      return updateHabit;
    } catch (e) {
      throw Exception('${AppConstraints.errorMessage} $e');
    }
  }

  Future<int> deleteHabit({required int habitId}) async {
    try {
      final int deleteHabit = await _habitRepository.deleteHabit(habitId: habitId);
      notifyListeners();
      return deleteHabit;
    } catch (e) {
      throw Exception('${AppConstraints.errorMessage} $e');
    }
  }
}
