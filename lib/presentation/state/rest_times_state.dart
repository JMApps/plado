import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../core/enums/season.dart';
import '../../core/enums/task_period.dart';
import '../../core/strings/app_constraints.dart';

class RestTimesState extends ChangeNotifier {
  DateTime _currentDateTime = DateTime.now();
  Timer? _timer;

  RestTimesState({required String day, required String hour, required String minute})  : _day = day, _hour = hour, _minute = minute {
    _startTimer();
  }

  late final String _day;

  late final String _hour;

  late final String _minute;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _currentDateTime = DateTime.now();
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Map<String, dynamic> getRestTimeIndicator(TaskPeriod taskPeriod) {
    final String remainingTime;
    final double elapsedPercentage;
    final DateTime endDateTime;
    switch (taskPeriod) {
      case TaskPeriod.day:
        final startOfDay = DateTime(_currentDateTime.year, _currentDateTime.month, _currentDateTime.day);
        final endOfDay = startOfDay.add(const Duration(hours: 24));
        remainingTime = _formatRemainingTime(remainingTime: endOfDay.difference(_currentDateTime));

        final elapsedTime = _currentDateTime.difference(startOfDay).inMinutes;
        final totalMinutesInDay = const Duration(hours: 24).inMinutes;

        elapsedPercentage = (elapsedTime / totalMinutesInDay) * 100.0;
        endDateTime = endOfDay.add(const Duration(days: -1));
        break;
      case TaskPeriod.week:
        final startOfWeek = DateTime(_currentDateTime.year, _currentDateTime.month, _currentDateTime.day - _currentDateTime.weekday + 1);
        final endOfWeek = startOfWeek.add(const Duration(days: 7));
        remainingTime = _formatRemainingTime(remainingTime: endOfWeek.difference(_currentDateTime));

        final elapsedTime = _currentDateTime.difference(startOfWeek).inMinutes;
        final totalMinutesInMonth = const Duration(days: 7).inMinutes;

        elapsedPercentage = (elapsedTime / totalMinutesInMonth) * 100.0;
        endDateTime = endOfWeek.add(const Duration(days: -1));
        break;
      case TaskPeriod.month:
        final startOfMonth = DateTime(_currentDateTime.year, _currentDateTime.month);
        final endOfMonth = startOfMonth.add(Duration(days: daysInMonth(_currentDateTime.year, _currentDateTime.month)));
        remainingTime = _formatRemainingTime(remainingTime: endOfMonth.difference(_currentDateTime));

        final elapsedTime = _currentDateTime.difference(startOfMonth).inMinutes;
        final totalMinutesInMonth = Duration(days: daysInMonth(_currentDateTime.year, _currentDateTime.month)).inMinutes;

        elapsedPercentage = (elapsedTime / totalMinutesInMonth) * 100.0;
        endDateTime = endOfMonth.add(const Duration(days: -1));
        break;
      case TaskPeriod.season:
        final int startSeasonMonth;
        final int endSeasonMonth;

        switch (_getCurrentSeason(_currentDateTime.month)) {
          case Season.spring:
            startSeasonMonth = 3;
            endSeasonMonth = 5;
            break;
          case Season.summer:
            startSeasonMonth = 6;
            endSeasonMonth = 8;
            break;
          case Season.fall:
            startSeasonMonth = 9;
            endSeasonMonth = 11;
            break;
          case Season.winter:
            startSeasonMonth = 12;
            endSeasonMonth = 2;
            break;
        }

        final startSeason = DateTime(getCurrentSeason() == Season.winter ? _currentDateTime.year - 1 : _currentDateTime.year, startSeasonMonth, 1);
        final endSeason = DateTime(getCurrentSeason() == Season.winter ? _currentDateTime.year - 1 : _currentDateTime.year, endSeasonMonth + 1, 1);
        remainingTime = _formatRemainingTime(remainingTime: endSeason.difference(_currentDateTime));

        final elapsedTime = _currentDateTime.difference(startSeason).inMinutes;
        final totalMinutesInSeason = endSeason.difference(startSeason).inMinutes;

        elapsedPercentage = (elapsedTime / totalMinutesInSeason) * 100.0;
        endDateTime = endSeason.add(const Duration(days: -1));
        break;
      case TaskPeriod.year:
        final startOfYear = DateTime(_currentDateTime.year);
        final endOfYear = startOfYear.add(Duration(days: isLeapYear(_currentDateTime.year) ? 366 : 365));
        remainingTime = _formatRemainingTime(remainingTime: endOfYear.difference(_currentDateTime));

        final elapsedTime = _currentDateTime.difference(startOfYear).inMinutes;
        final totalMinutesInYear = endOfYear.difference(startOfYear).inMinutes;

        elapsedPercentage = (elapsedTime / totalMinutesInYear) * 100.0;
        endDateTime = endOfYear.add(const Duration(days: -1));
        break;
    }
    return {
      AppConstraints.remainingTimeString: remainingTime,
      AppConstraints.elapsedPercentage: elapsedPercentage,
      AppConstraints.dateTimeInterval: endDateTime,
    };
  }

  int daysInMonth(int year, int month) {
    if (month == 2) {
      return isLeapYear(year) ? 29 : 28;
    } else if (month == 4 || month == 6 || month == 9 || month == 11) {
      return 30;
    } else {
      return 31;
    }
  }

  bool isLeapYear(int year) {
    if (year % 4 != 0) {
      return false;
    } else if (year % 100 != 0) {
      return true;
    } else if (year % 400 != 0) {
      return false;
    }
    return true;
  }

  Season getCurrentSeason() {
    return _getCurrentSeason(_currentDateTime.month);
  }

  Season _getCurrentSeason(int month) {
    late Season currentSeason;
    switch (month) {
      case 3:
      case 4:
      case 5:
        currentSeason = Season.spring;
        break;
      case 6:
      case 7:
      case 8:
        currentSeason = Season.summer;
        break;
      case 9:
      case 10:
      case 11:
        currentSeason = Season.fall;
        break;
      case 12:
      case 1:
      case 2:
        currentSeason = Season.winter;
        break;
    }
    return currentSeason;
  }

  String _formatRemainingTime({required Duration remainingTime}) {
    int days = remainingTime.inDays;
    int hours = remainingTime.inHours % 24;
    int minutes = remainingTime.inMinutes % 60;

    List<String> parts = [];

    if (days > 0) parts.add('$days $_day');
    if (hours > 0) parts.add('$hours $_hour');
    if (minutes > 0) parts.add('$minutes $_minute');

    return parts.join(' ');
  }
}
