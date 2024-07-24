import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/enums/habit_period.dart';
import '../../core/enums/season.dart';
import '../../core/enums/task_period.dart';
import '../../core/strings/app_constraints.dart';
import '../../core/styles/app_styles.dart';

class RestTimesState extends ChangeNotifier {
  DateTime _currentDateTime = DateTime.now();
  Timer? _timer;
  static const Duration minusMicro = Duration(microseconds: -1);

  RestTimesState() {
    _startTimer();
  }

  DateTime get getCurrentDateTime => _currentDateTime;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _currentDateTime = DateTime.now();
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Map<String, dynamic> restHabitDays(HabitPeriod habitPeriod) {
    final int days;
    switch (habitPeriod) {
      case HabitPeriod.days21:
        days = 21;
        break;
      case HabitPeriod.days40:
        days = 40;
        break;
      case HabitPeriod.days66:
        days = 66;
        break;
      case HabitPeriod.days90:
        days = 90;
        break;
    }

    return _calculateHabitPeriod(days);
  }

  Map<String, dynamic> _calculateHabitPeriod(int days) {
    final DateTime startDateTime = DateTime(_currentDateTime.year, _currentDateTime.month, _currentDateTime.day);
    final DateTime endDateTime = startDateTime.add(Duration(days: days));

    return {
      AppConstraints.startDateTime: startDateTime,
      AppConstraints.endDateTime: endDateTime.add(minusMicro),
    };
  }

  Map<String, dynamic> restTaskTimes(int taskPeriodIndex) {
    final Map<String, dynamic> periodData;

    switch (AppStyles.taskPeriodList[taskPeriodIndex]) {
      case TaskPeriod.day:
        periodData = _calculatePeriodData(
            startPeriod: DateTime(_currentDateTime.year, _currentDateTime.month, _currentDateTime.day),
            duration: const Duration(hours: 24)
        );
        break;
      case TaskPeriod.week:
        final startOfWeek = DateTime(_currentDateTime.year, _currentDateTime.month, _currentDateTime.day - _currentDateTime.weekday + 1);
        periodData = _calculatePeriodData(
            startPeriod: startOfWeek,
            duration: const Duration(days: 7)
        );
        break;
      case TaskPeriod.month:
        final startOfMonth = DateTime(_currentDateTime.year, _currentDateTime.month);
        periodData = _calculatePeriodData(
            startPeriod: startOfMonth,
            duration: Duration(days: daysInMonth(_currentDateTime.year, _currentDateTime.month))
        );
        break;
      case TaskPeriod.season:
        final seasonData = _getSeasonPeriodData(_currentDateTime);
        periodData = _calculatePeriodData(
            startPeriod: seasonData['startSeason'],
            endPeriod: seasonData['endSeason']
        );
        break;
      case TaskPeriod.year:
        final startOfYear = DateTime(_currentDateTime.year);
        periodData = _calculatePeriodData(
            startPeriod: startOfYear,
            duration: Duration(days: isLeapYear(_currentDateTime.year) ? 366 : 365)
        );
        break;
    }

    return periodData;
  }

  Map<String, dynamic> _calculatePeriodData({
    required DateTime startPeriod,
    Duration? duration,
    DateTime? endPeriod,
  }) {
    final DateTime endDateTime = duration != null ? startPeriod.add(duration) : endPeriod!;
    final int elapsedTimeInMinutes = _currentDateTime.difference(startPeriod).inMinutes;
    final int totalMinutes = endDateTime.difference(startPeriod).inMinutes;
    final Duration remainingTime = endDateTime.difference(_currentDateTime);
    final double elapsedPercentage = (elapsedTimeInMinutes / totalMinutes) * 100.0;

    return {
      AppConstraints.startDateTime: startPeriod,
      AppConstraints.remainingTimeString: remainingTime,
      AppConstraints.elapsedPercentage: elapsedPercentage,
      AppConstraints.endDateTime: endDateTime.add(minusMicro),
    };
  }

  Map<String, dynamic> _getSeasonPeriodData(DateTime currentDateTime) {
    final int startSeasonMonth;
    final int endSeasonMonth;
    final int currentYear = currentDateTime.year;
    final int previousYear = currentYear - 1;

    switch (_getCurrentSeason(currentDateTime.month)) {
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

    final startSeason = DateTime(_getCurrentSeason(currentDateTime.month) == Season.winter ? previousYear : currentYear, startSeasonMonth, 1);
    final endSeason = DateTime(_getCurrentSeason(currentDateTime.month) == Season.winter ? previousYear : currentYear, endSeasonMonth + 1, 1);

    return {
      'startSeason': startSeason,
      'endSeason': endSeason,
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
}
