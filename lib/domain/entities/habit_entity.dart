import '../../data/models/habit_model.dart';

class HabitEntity {
  final int habitId;
  final String habitTitle;
  final String habitDescription;
  final String createDateTime;
  final String completeDateTime;
  final String startDateTime;
  final String endDateTime;
  final int habitPeriodIndex;
  final List<bool> completedDays;
  final int notificationId;
  final String notificationDate;

  HabitEntity({
    required this.habitId,
    required this.habitTitle,
    required this.habitDescription,
    required this.createDateTime,
    required this.completeDateTime,
    required this.startDateTime,
    required this.endDateTime,
    required this.habitPeriodIndex,
    required this.completedDays,
    required this.notificationId,
    required this.notificationDate,
  });

  factory HabitEntity.fromModel(HabitModel model) {
    return HabitEntity(
      habitId: model.habitId,
      habitTitle: model.habitTitle,
      habitDescription: model.habitDescription,
      createDateTime: model.createDateTime,
      completeDateTime: model.completeDateTime,
      startDateTime: model.startDateTime,
      endDateTime: model.endDateTime,
      habitPeriodIndex: model.habitPeriodIndex,
      completedDays: model.completedDays,
      notificationId: model.notificationId,
      notificationDate: model.notificationDate,
    );
  }
}
