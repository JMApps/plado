

class HabitModel {
  final int habitId;
  final String habitTitle;
  final String habitDescription;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final String habitPeriod;
  final List<bool> completedDays;

  HabitModel({
    required this.habitId,
    required this.habitTitle,
    required this.habitDescription,
    required this.startDateTime,
    required this.endDateTime,
    required this.habitPeriod,
    required this.completedDays,
  });

  factory HabitModel.fromMap(Map<String, dynamic> map) {
    return HabitModel(
      habitId: map['habit_id'] as int,
      habitTitle: map['habit_title'] as String,
      habitDescription: map['habit_description'] as String,
      startDateTime: DateTime.parse(map['start_date_time'] as String),
      endDateTime: DateTime.parse(map['end_date_time'] as String),
      habitPeriod: map['habit_period'] as String,
      completedDays: (map['complete_days'] as List<dynamic>).map((e) => e as bool).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'habit_id': habitId,
      'habit_title': habitTitle,
      'habit_description': habitDescription,
      'start_date_time': startDateTime.toIso8601String(),
      'end_date_time': endDateTime.toIso8601String(),
      'habit_period': habitPeriod,
      'complete_days': completedDays,
    };
  }
}
