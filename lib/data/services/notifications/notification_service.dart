import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static const String _logoName = 'ic_stat_notification';

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static const AndroidNotificationDetails _androidDailyNotificationDetails = AndroidNotificationDetails(
    'PlaDo notification channel ID',
    'Notifications',
    channelDescription: 'PlaDo notifications',
    icon: _logoName,
    importance: Importance.max,
    priority: Priority.max,
  );

  static const DarwinNotificationDetails _iOSDailyNotificationDetails = DarwinNotificationDetails();

  Future<void> setupNotification() async {
    if (Platform.isAndroid) {
      _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
    }

    const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings(_logoName);
    const DarwinInitializationSettings iOSInitializationSettings = DarwinInitializationSettings();

    const InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iOSInitializationSettings,
    );

    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
    tz.initializeTimeZones();
  }

  Future<void> scheduleTimeNotifications(DateTime date, String title, String body, int notificationId) async {
    var tzDateNotification = tz.TZDateTime.from(date, tz.local);
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      notificationId,
      title,
      body,
      tzDateNotification,
      const NotificationDetails(
        android: _androidDailyNotificationDetails,
        iOS: _iOSDailyNotificationDetails,
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> scheduleDailyNotifications(int daysCount, DateTime date, String title, String body, int notificationId) async {
    for(int i = 0; i < daysCount; i++) {
      final DateTime timeNotification = date.add(Duration(days: i));
      final int cycleNotificationId = notificationId + i;
      await scheduleDateTimeNotifications(timeNotification, title, body, cycleNotificationId);
    }
  }

  Future<void> scheduleDateTimeNotifications(DateTime date, String title, String body, int notificationId) async {
    var tzDateNotification = tz.TZDateTime.from(DateTime(date.year, date.month, date.day, date.hour, date.minute), tz.local);
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      notificationId,
      title,
      body,
      tzDateNotification,
      const NotificationDetails(
        android: _androidDailyNotificationDetails,
        iOS: _iOSDailyNotificationDetails,
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> cancelNotificationWithId(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelNotificationWithCount(int id, int daysCount) async {
    for(int i = 0; i < daysCount; i++) {
      await _flutterLocalNotificationsPlugin.cancel(id + i);
    }
  }

  Future<void> cancelAllNotification() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}
