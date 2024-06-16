import 'package:flutter/material.dart';

class AppMaterialStyles {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: Colors.orange,
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
    )
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: Colors.orange,
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
    )
  );
}