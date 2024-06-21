import 'dart:io';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNoticeService {

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static const AndroidNotificationDetails _androidDailyNotificationDetails =
  AndroidNotificationDetails(
    'Daily notification channel ID',
    'Notifications',
    channelDescription: 'Daily notifications',
    importance: Importance.max,
    priority: Priority.max,
  );

  static const DarwinNotificationDetails _iOSDailyNotificationDetails =
  DarwinNotificationDetails();

  Future<void> setupNotification() async {
    if (Platform.isAndroid) {
      _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
    }

    const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings('@drawable/ic_notification');

    const DarwinInitializationSettings iOSInitializationSettings = DarwinInitializationSettings();

    const InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iOSInitializationSettings,
    );

    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
    tz.initializeTimeZones();
  }

  Future<void> futureNotification(DateTime date, String title, String body, int notificationId) async {
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
      androidScheduleMode: AndroidScheduleMode.alarmClock,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelNotificationWithId(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }
}