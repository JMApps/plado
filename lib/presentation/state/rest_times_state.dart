import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../core/enums/season.dart';
import '../../core/strings/app_constraints.dart';

class RestTimesState extends ChangeNotifier {
  DateTime _currentDateTime = DateTime.now();
  Timer? _timer;

  RestTimesState() {
    _startTimer();
  }

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

  Map<String, dynamic> calculateElapsedDayPercentage() {
    final startOfDay = DateTime(_currentDateTime.year, _currentDateTime.month, _currentDateTime.day);
    final endOfDay = startOfDay.add(const Duration(hours: 24));
    final remainingTime = endOfDay.difference(_currentDateTime);

    final elapsedTime = _currentDateTime.difference(startOfDay).inMinutes;
    final totalMinutesInDay = const Duration(hours: 24).inMinutes;

    final elapsedTimePercentage = (elapsedTime / totalMinutesInDay) * 100.0;

    return {
      AppConstraints.remainingTime: _formatRemainingTime(remainingTime),
      AppConstraints.elapsedPercentage: elapsedTimePercentage,
    };
  }

  Map<String, dynamic> calculateElapsedWeekPercentage() {
    final startOfWeek = DateTime(_currentDateTime.year, _currentDateTime.month, _currentDateTime.day - _currentDateTime.weekday + 1);
    final endOfWeek = startOfWeek.add(const Duration(days: 7));
    final remainingTime = endOfWeek.difference(_currentDateTime);


    final elapsedTime = _currentDateTime.difference(startOfWeek).inMinutes;
    final totalMinutesInMonth = const Duration(days: 7).inMinutes;

    final elapsedTimePercentage = (elapsedTime / totalMinutesInMonth) * 100.0;

    return {
      AppConstraints.remainingTime: _formatRemainingTime(remainingTime),
      AppConstraints.elapsedPercentage: elapsedTimePercentage,
    };
  }

  Map<String, dynamic> calculateElapsedMonthPercentage() {
    final startOfMonth = DateTime(_currentDateTime.year, _currentDateTime.month);
    final endOfMonth = startOfMonth.add(Duration(days: daysInMonth(_currentDateTime.year, _currentDateTime.month)));
    final remainingTime = endOfMonth.difference(_currentDateTime);


    final elapsedTime = _currentDateTime.difference(startOfMonth).inMinutes;
    final totalMinutesInMonth = Duration(days: daysInMonth(_currentDateTime.year, _currentDateTime.month)).inMinutes;

    final elapsedTimePercentage = (elapsedTime / totalMinutesInMonth) * 100.0;

    return {
      AppConstraints.remainingTime: _formatRemainingTime(remainingTime),
      AppConstraints.elapsedPercentage: elapsedTimePercentage,
    };
  }

  Map<String, dynamic> calculateElapsedYearPercentage() {
    final startOfYear = DateTime(_currentDateTime.year);
    final endOfYear = startOfYear.add(Duration(days: isLeapYear(_currentDateTime.year) ? 366 : 365));
    final remainingTime = endOfYear.difference(_currentDateTime);

    final elapsedTime = _currentDateTime.difference(startOfYear).inMinutes;
    final totalMinutesInYear = endOfYear.difference(startOfYear).inMinutes;

    final elapsedTimePercentage = (elapsedTime / totalMinutesInYear) * 100.0;

    return {
      AppConstraints.remainingTime: _formatRemainingTime(remainingTime),
      AppConstraints.elapsedPercentage: elapsedTimePercentage,
    };
  }

  Season getCurrentSeason() {
    return _getCurrentSeason(_currentDateTime.month);
  }

  Map<String, dynamic> calculateElapsedSeasonPercentage(Season currentSeason) {
    final int startSeasonMonth;
    final int endSeasonMonth;

    switch (currentSeason) {
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

    final startSeason = DateTime(_getCurrentSeason(_currentDateTime.month) == Season.winter ? _currentDateTime.year - 1 : _currentDateTime.year, startSeasonMonth, 1);
    final endSeason = DateTime(_getCurrentSeason(_currentDateTime.month) == Season.winter ? _currentDateTime.year - 1 : _currentDateTime.year, endSeasonMonth + 1, 1);
    final remainingTime = endSeason.difference(_currentDateTime);

    final elapsedTime = _currentDateTime.difference(startSeason).inMinutes;
    final totalMinutesInSeason = endSeason.difference(startSeason).inMinutes;

    final elapsedTimePercentage = (elapsedTime / totalMinutesInSeason) * 100.0;

    return {
      AppConstraints.remainingTime: _formatRemainingTime(remainingTime),
      AppConstraints.elapsedPercentage: elapsedTimePercentage,
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

  String _formatRemainingTime(Duration remainingTime) {
    int days = remainingTime.inDays;
    int hours = remainingTime.inHours % 24;
    int minutes = remainingTime.inMinutes % 60;

    List<String> parts = [];

    if (days > 0) parts.add('$days д');
    if (hours > 0) parts.add('$hours ч');
    if (minutes > 0) parts.add('$minutes мин');

    return parts.join(', ');
  }
}