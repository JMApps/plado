import '../../core/strings/database_values.dart';

class HabitModel {
  final int habitId;
  final String habitTitle;
  final DateTime createDateTime;
  final DateTime completeDateTime;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final int habitPeriodIndex;
  final int habitColorIndex;
  final String completedDays;
  final int notificationId;
  final String notificationDate;

  HabitModel({
    required this.habitId,
    required this.habitTitle,
    required this.createDateTime,
    required this.completeDateTime,
    required this.startDateTime,
    required this.endDateTime,
    required this.habitPeriodIndex,
    required this.habitColorIndex,
    required this.completedDays,
    required this.notificationId,
    required this.notificationDate,
  });

  factory HabitModel.fromMap(Map<String, dynamic> map) {
    return HabitModel(
      habitId: map[DatabaseValues.dbHabitId] as int,
      habitTitle: map[DatabaseValues.dbHabitTitle] as String,
      createDateTime: DateTime.parse(map[DatabaseValues.dbHabitCreateDateTime]),
      completeDateTime: DateTime.parse(map[DatabaseValues.dbHabitCompleteDateTime]),
      startDateTime: DateTime.parse(map[DatabaseValues.dbHabitStartDateTime]),
      endDateTime: DateTime.parse(map[DatabaseValues.dbHabitEndDateTime]),
      habitPeriodIndex: map[DatabaseValues.dbHabitPeriodIndex] as int,
      habitColorIndex: map[DatabaseValues.dbHabitColorIndex] as int,
      completedDays: map[DatabaseValues.dbHabitCompletedDays] as String,
      notificationId: map[DatabaseValues.dbHabitNotificationId] as int,
      notificationDate: map[DatabaseValues.dbHabitNotificationDate] as String,
    );
  }

  Map<String, dynamic> habitToMap() {
    return {
      DatabaseValues.dbHabitTitle: habitTitle,
      DatabaseValues.dbHabitCreateDateTime: createDateTime.toIso8601String(),
      DatabaseValues.dbHabitCompleteDateTime: completeDateTime.toIso8601String(),
      DatabaseValues.dbHabitStartDateTime: startDateTime.toIso8601String(),
      DatabaseValues.dbHabitEndDateTime: endDateTime.toIso8601String(),
      DatabaseValues.dbHabitPeriodIndex: habitPeriodIndex,
      DatabaseValues.dbHabitColorIndex: habitColorIndex,
      DatabaseValues.dbHabitCompletedDays: completedDays,
      DatabaseValues.dbHabitNotificationId: notificationId,
      DatabaseValues.dbHabitNotificationDate: notificationDate,
    };
  }
}
