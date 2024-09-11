import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/enums/category_period.dart';
import '../../core/enums/season.dart';
import '../../core/strings/app_constraints.dart';
import '../../core/styles/app_styles.dart';

class RestTimesState extends ChangeNotifier {
  DateTime _currentDateTime = DateTime.now();
  Timer? _timer;
  final Duration _minusMicro = const Duration(microseconds: -1);

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

  Map<String, dynamic> restCategoryTimes(int periodIndex) {
    final Map<String, dynamic> categoryPeriodData;

    switch (AppStyles.categoryPeriodList[periodIndex]) {
      case CategoryPeriod.day:
        categoryPeriodData = _calculateCategoryPeriodData(
            startPeriod: DateTime(_currentDateTime.year, _currentDateTime.month, _currentDateTime.day),
            duration: const Duration(hours: 24)
        );
        break;
      case CategoryPeriod.week:
        final startOfWeek = DateTime(_currentDateTime.year, _currentDateTime.month, _currentDateTime.day - _currentDateTime.weekday + 1);
        categoryPeriodData = _calculateCategoryPeriodData(
            startPeriod: startOfWeek,
            duration: const Duration(days: 7)
        );
        break;
      case CategoryPeriod.month:
        final startOfMonth = DateTime(_currentDateTime.year, _currentDateTime.month);
        categoryPeriodData = _calculateCategoryPeriodData(
            startPeriod: startOfMonth,
            duration: Duration(days: daysInMonth(_currentDateTime.year, _currentDateTime.month))
        );
        break;
      case CategoryPeriod.season:
        final seasonData = _getSeasonPeriodData(_currentDateTime);
        categoryPeriodData = _calculateCategoryPeriodData(
            startPeriod: seasonData[AppConstraints.startSeason],
            endPeriod: seasonData[AppConstraints.endSeason]
        );
        break;
      case CategoryPeriod.year:
        final startOfYear = DateTime(_currentDateTime.year);
        categoryPeriodData = _calculateCategoryPeriodData(
            startPeriod: startOfYear,
            duration: Duration(days: isLeapYear(_currentDateTime.year) ? 366 : 365)
        );
        break;
    }

    return categoryPeriodData;
  }

  Map<String, dynamic> restHabitTimes(int habitPeriodIndex) {
    final Map<String, dynamic> habitPeriodData;
    habitPeriodData = _calculateHabitPeriodData(startHabitPeriod: DateTime(_currentDateTime.year, _currentDateTime.month, _currentDateTime.day), duration: Duration(days: AppStyles.habitPeriodDayList[habitPeriodIndex]));
    return habitPeriodData;
  }

  Map<String, dynamic> _calculateCategoryPeriodData({
    required DateTime startPeriod,
    Duration? duration,
    DateTime? endPeriod,
  }) {
    final DateTime endDateTime = duration != null ? startPeriod.add(duration) : endPeriod!;
    final int totalMinutes = endDateTime.difference(startPeriod).inMinutes;
    final int remaininTimeInMinutes = _currentDateTime.difference(startPeriod).inMinutes;
    final Duration remainingTaskTime = endDateTime.difference(_currentDateTime);
    final double elapsedTaskPercentage = (remaininTimeInMinutes / totalMinutes) * 100.0;

    return {
      AppConstraints.startDateTime: startPeriod,
      AppConstraints.endDateTime: endDateTime.add(_minusMicro),
      AppConstraints.taskRemaininDateTime: remainingTaskTime,
      AppConstraints.taskElapsedPercentage: elapsedTaskPercentage,
    };
  }

  Map<String, dynamic> _calculateHabitPeriodData({
    required DateTime startHabitPeriod,
    Duration? duration,
    DateTime? endTaskPeriod,
  }) {
    final DateTime endDateTime = duration != null ? startHabitPeriod.add(duration) : endTaskPeriod!;

    return {
      AppConstraints.habitStartDateTime: startHabitPeriod,
      AppConstraints.habitEndDateTime: endDateTime.add(_minusMicro),
    };
  }

  Map<String, dynamic> restRemainingPercentage({required DateTime startDateTime, required DateTime endDateTime}) {
    final int totalMinutes = endDateTime.difference(startDateTime).inMinutes;

    final int remainingTimeInMinutes = endDateTime.difference(_currentDateTime).inMinutes;
    final int elapsedTimeInMinutes = _currentDateTime.difference(startDateTime).inMinutes;

    final double elapsedPercentage = (elapsedTimeInMinutes / totalMinutes) * 100.0;
    final double remainingPercentage = (remainingTimeInMinutes / totalMinutes) * 100.0;

    final int remainingDays = Duration(minutes: remainingTimeInMinutes).inDays;
    final int elapsedDays = _currentDateTime.difference(startDateTime).inDays;

    return {
      AppConstraints.restRemainingDays: remainingDays,
      AppConstraints.restElapsedDays: elapsedDays,
      AppConstraints.restElapsedPercentage: elapsedPercentage,
      AppConstraints.restRemainingPercentage: remainingPercentage,
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
      AppConstraints.startSeason: startSeason,
      AppConstraints.endSeason: endSeason,
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
