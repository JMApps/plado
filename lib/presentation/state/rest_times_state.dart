import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../core/enums/season.dart';

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

  double calculateElapsedDayPercentage() {
    final startOfDay = DateTime(_currentDateTime.year, _currentDateTime.month, _currentDateTime.day);
    final elapsedTime = _currentDateTime.difference(startOfDay).inMinutes;
    final totalMinutesInDay = const Duration(hours: 24).inMinutes;
    final elapsedTimePercentage = (elapsedTime / totalMinutesInDay) * 100.0;
    return elapsedTimePercentage;
  }

  double calculateElapsedWeekPercentage() {
    final startOfWeek = DateTime(_currentDateTime.year, _currentDateTime.month, _currentDateTime.day - _currentDateTime.weekday + 1);
    final elapsedMinutes = _currentDateTime.difference(startOfWeek).inMinutes;
    final totalMinutesInWeek = const Duration(days: 7).inMinutes;
    final elapsedWeekPercentage = (elapsedMinutes / totalMinutesInWeek) * 100.0;
    return elapsedWeekPercentage;
  }

  double calculateElapsedMonthPercentage() {
    final startOfMonth = DateTime(_currentDateTime.year, _currentDateTime.month, 1, 0, 0, 0);
    final elapsedMinutes = _currentDateTime.difference(startOfMonth).inMinutes;
    final totalMinutesInMonth = Duration(days: daysInMonth(_currentDateTime.year, _currentDateTime.month)).inMinutes;
    final elapsedMonthPercentage = (elapsedMinutes / totalMinutesInMonth) * 100.0;
    return elapsedMonthPercentage;
  }

  double calculateElapsedYearPercentage() {
    final startOfYear = DateTime(_currentDateTime.year);
    final elapsedMinutes = _currentDateTime.difference(startOfYear).inMinutes;
    final totalMinutesInYear = isLeapYear(_currentDateTime.year) ? 366 * 24 * 60 : 365 * 24 * 60;
    final elapsedYearPercentage = (elapsedMinutes / totalMinutesInYear) * 100.0;
    return elapsedYearPercentage;
  }

  Season getCurrentSeason() {
    return _getCurrentSeason(_currentDateTime.month);
  }

  double calculateElapsedSeasonPercentage(Season currentSeason) {
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

    final startOfSeason = DateTime(_getCurrentSeason(_currentDateTime.month) == Season.winter ? _currentDateTime.year - 1 : _currentDateTime.year, startSeasonMonth, 1);
    final elapsedTime = _currentDateTime.difference(startOfSeason).inMinutes;
    final endOfSeason = DateTime(_currentDateTime.year, endSeasonMonth + 1);
    final totalSeasonTime = endOfSeason.difference(startOfSeason).inMinutes;

    final elapsedTimePercentage = (elapsedTime / totalSeasonTime) * 100.0;
    return elapsedTimePercentage;
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
}