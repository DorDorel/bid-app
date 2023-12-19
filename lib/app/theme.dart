import 'package:flutter/material.dart'
    show ThemeData, AppBarTheme, Colors, IconThemeData, ColorScheme;

final ThemeData appTheme = ThemeData(
  useMaterial3: false,
  appBarTheme: AppBarTheme(
    color: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    elevation: 0.0,
  ),
  primaryColor: Colors.black,
  scaffoldBackgroundColor: Colors.white,
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(
        secondary: Colors.black87,
      )
      .copyWith(
        background: Colors.grey[300],
      ),
);
