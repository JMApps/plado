import 'package:flutter/material.dart';
import 'package:plado/core/enums/habit_period.dart';

import '../../presentation/pages/about_us_page.dart';
import '../../presentation/pages/graphics_page.dart';
import '../../presentation/habit/pages/habits_page.dart';
import '../../presentation/pages/settings_page.dart';
import '../../presentation/task/pages/tasks_page.dart';
import '../enums/task_period.dart';
import '../enums/task_priority.dart';
import '../enums/task_status.dart';

class AppStyles {
  static const padding = EdgeInsets.all(16);
  static const paddingMini = EdgeInsets.all(8);
  static const paddingMicro = EdgeInsets.all(4);

  static const paddingHorizontal = EdgeInsets.symmetric(horizontal: 16);
  static const paddingHorizontalMini = EdgeInsets.symmetric(horizontal: 8);

  static const paddingVertical = EdgeInsets.symmetric(horizontal: 16);
  static const paddingVerticalMini = EdgeInsets.symmetric(horizontal: 8);

  static const paddingVerHorMini = EdgeInsets.symmetric(vertical: 16, horizontal: 8);
  static const paddingHorVerMini = EdgeInsets.symmetric(horizontal: 16, vertical: 8);

  static const paddingTop = EdgeInsets.only(top: 16);
  static const paddingTopMini = EdgeInsets.only(top: 8);

  static const paddingRight = EdgeInsets.only(right: 16);
  static const paddingRightMini = EdgeInsets.only(right: 8);

  static const paddingBottom = EdgeInsets.only(bottom: 16);
  static const paddingBottomMini = EdgeInsets.only(bottom: 8);

  static const paddingLeft = EdgeInsets.only(left: 16);
  static const paddingLeftMini = EdgeInsets.only(left: 8);

  static const paddingWithoutTop = EdgeInsets.only(left: 16, right: 16, bottom: 16);
  static const paddingWithoutTopMini = EdgeInsets.only(left: 8, right: 8, bottom: 8);

  static const paddingWithoutBottom = EdgeInsets.only(left: 16, right: 16, top: 16);
  static const paddingWithoutBottomMini = EdgeInsets.only(left: 8, right: 8, top: 8);

  static const border = BorderRadius.all(Radius.circular(16));
  static const borderMini = BorderRadius.all(Radius.circular(8));

  static const shape = RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16)));
  static const shapeMini = RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8)));

  static const mainPages = <Widget>[
    TasksPage(),
    HabitsPage(),
    GraphicsPage(),
    SettingsPage(),
    AboutUsPage(),
  ];

  static const taskModeList = <TaskPeriod>[
    TaskPeriod.day,
    TaskPeriod.week,
    TaskPeriod.month,
    TaskPeriod.season,
    TaskPeriod.year,
  ];

  static const taskHabitColors = <Color>[
    Colors.orange,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.red,
    Colors.amber,
    Colors.blueGrey,
    Colors.pinkAccent,
    Colors.teal,
    Colors.yellow,
  ];

  static const priorityColors = <Color>[
    Colors.transparent,
    Colors.orange,
    Colors.red,
  ];

  static const taskPeriodList = <TaskPeriod> [
    TaskPeriod.day,
    TaskPeriod.week,
    TaskPeriod.month,
    TaskPeriod.season,
    TaskPeriod.year,
  ];

  static const taskPriorityList = <TaskPriority> [
    TaskPriority.low,
    TaskPriority.medium,
    TaskPriority.high,
  ];

  static const taskStatusList = <TaskStatus> [
    TaskStatus.inProgress,
    TaskStatus.complete,
    TaskStatus.canceled,
  ];

  static const habitPeriodList = <HabitPeriod> [
    HabitPeriod.days21,
    HabitPeriod.days40,
    HabitPeriod.days66,
    HabitPeriod.days90,
  ];

  static const habitPeriodDayList = <int> [
    21,
    40,
    66,
    90,
  ];
}
