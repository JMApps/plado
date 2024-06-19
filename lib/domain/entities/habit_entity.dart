import '../../data/models/habit_model.dart';

class HabitEntity {
  final int habitId;
  final String habitTitle;
  final String habitDescription;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final String habitPeriod;
  final List<bool> completedDays;

  HabitEntity({
    required this.habitId,
    required this.habitTitle,
    required this.habitDescription,
    required this.startDateTime,
    required this.endDateTime,
    required this.habitPeriod,
    required this.completedDays,
  });

  factory HabitEntity.fromModel(HabitModel model) {
    return HabitEntity(
      habitId: model.habitId,
      habitTitle: model.habitTitle,
      habitDescription: model.habitDescription,
      startDateTime: model.startDateTime,
      endDateTime: model.endDateTime,
      habitPeriod: model.habitPeriod,
      completedDays: model.completedDays,
    );
  }
}
