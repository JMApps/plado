import 'package:flutter/material.dart';

class HabitNotificationIdState extends ChangeNotifier {
  HabitNotificationIdState([int notificationId = 0]) : _notificationId = notificationId;

  late int _notificationId;

  int get getNotificationId => _notificationId;

  set setNotificationId(int notificationId) {
    _notificationId = notificationId;
    notifyListeners();
  }
}