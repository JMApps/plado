import '../../core/enums/habit/habit_period.dart';

class HabitEntity {
  final int id;
  final String habitTitle;
  final String? habitDescription;
  final DateTime startTime;
  final DateTime endTime;
  final HabitPeriod habitPeriod;
  final List<bool> completedDays;

  HabitEntity({
    required this.id,
    required this.habitTitle,
    required this.habitDescription,
    required this.startTime,
    required this.endTime,
    required this.habitPeriod,
    required this.completedDays,
  });
}
