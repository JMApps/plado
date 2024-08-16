import 'package:flutter/material.dart';

import '../strings/app_constraints.dart';
import '../styles/app_styles.dart';

class AppMaterialStyles {

  final int themeColorIndex;

  AppMaterialStyles({required this.themeColorIndex});

  ThemeData get lightTheme => ThemeData(
    fontFamily: AppConstraints.fontRaleway,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: AppStyles.taskHabitColors[themeColorIndex],
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: AppStyles.paddingHorizontal,
      alignLabelWithHint: true,
      floatingLabelAlignment: FloatingLabelAlignment.center,
      border: OutlineInputBorder(
        borderRadius: AppStyles.border,
        borderSide: BorderSide(
          width: 0.5,
        ),
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      showDragHandle: true,
      dragHandleSize: Size(48, 3),
    ),
  );

  ThemeData get darkTheme => ThemeData(
    fontFamily: AppConstraints.fontRaleway,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: AppStyles.taskHabitColors[themeColorIndex],
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: AppStyles.paddingHorizontal,
      alignLabelWithHint: true,
      floatingLabelAlignment: FloatingLabelAlignment.center,
      border: OutlineInputBorder(
        borderRadius: AppStyles.border,
        borderSide: BorderSide(
          width: 0.5,
        ),
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      showDragHandle: true,
      dragHandleSize: Size(48, 3),
    ),
  );
}