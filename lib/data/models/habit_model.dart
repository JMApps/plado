class HabitModel {
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

  HabitModel({
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

  factory HabitModel.fromMap(Map<String, dynamic> map) {
    return HabitModel(
      habitId: map['habit_id'] as int,
      habitTitle: map['habit_title'] as String,
      habitDescription: map['habit_description'] as String,
      createDateTime: map['create_date_time'] as String,
      completeDateTime: map['complete_date_time'] as String,
      startDateTime: map['start_date_time'] as String,
      endDateTime: map['end_date_time'] as String,
      habitPeriodIndex: map['habit_period_index'] as int,
      completedDays: (map['complete_days'] as List<dynamic>).map((e) => e as bool).toList(),
      notificationId: map['notification_id'] as int,
      notificationDate: map['notification_date'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'habit_id': habitId,
      'habit_title': habitTitle,
      'habit_description': habitDescription,
      'create_date_time': createDateTime,
      'complete_date_time': completeDateTime,
      'start_date_time': startDateTime,
      'end_date_time': endDateTime,
      'habit_period_index': habitPeriodIndex,
      'complete_days': completedDays,
      'notification_id': notificationId,
      'notification_date': notificationDate,
    };
  }
}
