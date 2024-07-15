import 'package:flutter/material.dart';

import '../strings/app_constraints.dart';
import '../styles/app_styles.dart';

class AppMaterialStyles {
  static ThemeData lightTheme = ThemeData(
    fontFamily: AppConstraints.fontRaleway,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: Colors.orange,
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

  static ThemeData darkTheme = ThemeData(
    fontFamily: AppConstraints.fontRaleway,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: Colors.orange,
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