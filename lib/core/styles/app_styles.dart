import 'package:flutter/material.dart';

import '../../presentation/category/pages/categories_page.dart';
import '../../presentation/habit/pages/habits_page.dart';
import '../../presentation/pages/settings_page.dart';
import '../../presentation/pages/statistic_page.dart';
import '../enums/category_period.dart';
import '../enums/habit_period.dart';
import '../enums/task_priority.dart';
import '../enums/task_status.dart';
import '../strings/app_constraints.dart';
import '../strings/database_values.dart';

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
  static const paddingBottomMicro = EdgeInsets.only(bottom: 4);

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

  static const mainText = TextStyle(fontSize: 18, fontFamily: AppConstraints.fontRaleway);
  static const mainTextRoboto = TextStyle(fontSize: 18, fontFamily: AppConstraints.fontRobotoSlab);
  static const mainTextRoboto16 = TextStyle(fontSize: 16, fontFamily: AppConstraints.fontRobotoSlab);
  static const mainTextBold = TextStyle(fontSize: 18, fontFamily: AppConstraints.fontRaleway, fontWeight: FontWeight.bold);
  static const mainTextBold20 = TextStyle(fontSize: 20, fontFamily: AppConstraints.fontRaleway, fontWeight: FontWeight.bold);

  static const mainPages = <Widget>[
    CategoriesPage(),
    HabitsPage(),
    StatisticPage(),
    SettingsPage(),
  ];

  static const taskModeList = <CategoryPeriod>[
    CategoryPeriod.day,
    CategoryPeriod.week,
    CategoryPeriod.month,
    CategoryPeriod.season,
    CategoryPeriod.year,
  ];

  static const appColorList = <Color>[
    Colors.orange,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.red,
    Colors.amber,
    Colors.blueGrey,
    Colors.pinkAccent,
    Colors.teal,
    Colors.brown,
  ];

  static const priorityColors = <Color>[
    Colors.transparent,
    Colors.orange,
    Colors.red,
  ];

  static const categoryPeriodList = <CategoryPeriod> [
    CategoryPeriod.day,
    CategoryPeriod.week,
    CategoryPeriod.month,
    CategoryPeriod.season,
    CategoryPeriod.year,
  ];

  static const taskSortList = <String> [
    DatabaseValues.dbTaskId,
    DatabaseValues.dbTaskTitle,
    DatabaseValues.dbTaskPriorityIndex,
    DatabaseValues.dbTaskColorIndex,
  ];

  static const categorySortList = <String> [
    DatabaseValues.dbCategoryId,
    DatabaseValues.dbCategoryColorIndex,
  ];

  static const habitSortList = <String> [
    DatabaseValues.dbHabitId,
    DatabaseValues.dbHabitTitle,
    DatabaseValues.dbHabitColorIndex,
  ];

  static const orderList = <String> [
    AppConstraints.descSort,
    AppConstraints.ascSort,
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
