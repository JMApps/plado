class HabitModel {
  final int habitId;
  final String habitTitle;
  final String createDateTime;
  final String completeDateTime;
  final String startDateTime;
  final String endDateTime;
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
      habitId: map['habit_id'] as int,
      habitTitle: map['habit_title'] as String,
      createDateTime: map['create_date_time'] as String,
      completeDateTime: map['complete_date_time'] as String,
      startDateTime: map['start_date_time'] as String,
      endDateTime: map['end_date_time'] as String,
      habitPeriodIndex: map['habit_period_index'] as int,
      habitColorIndex: map['habit_color_index'] as int,
      completedDays: map['completed_days'] as String,
      notificationId: map['notification_id'] as int,
      notificationDate: map['notification_date'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'habit_id': habitId,
      'habit_title': habitTitle,
      'create_date_time': createDateTime,
      'complete_date_time': completeDateTime,
      'start_date_time': startDateTime,
      'end_date_time': endDateTime,
      'habit_period_index': habitPeriodIndex,
      'habit_color_index': habitColorIndex,
      'completed_days': completedDays,
      'notification_id': notificationId,
      'notification_date': notificationDate,
    };
  }
}
