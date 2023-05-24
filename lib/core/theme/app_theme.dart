import 'package:flutter/material.dart';
import 'package:travel_trackr/core/theme/app_text_theme.dart';

import 'app_colors.dart';

abstract class AppTheme {
  static ThemeData get theme => ThemeData(
        scaffoldBackgroundColor: AppColors.backgroundColor,
        primaryColor: AppColors.primaryColor,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.primaryColor,
        ),
        appBarTheme: const AppBarTheme(color: AppColors.backgroundColor),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.textFieldColor,
          border: textFieldBorder,
          enabledBorder: textFieldBorder,
          disabledBorder: textFieldBorder,
          focusedBorder: textFieldBorder,
          errorBorder: textFieldErrorBorder,
          focusedErrorBorder: textFieldErrorBorder,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16.0, horizontal: 25.0),
        ),
        textTheme: const TextTheme(titleMedium: AppTextTheme.textFieldStyle),
        elevatedButtonTheme: elevatedButtonTheme,
      );

  static ThemeData get datePickerTheme => ThemeData(
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primaryColor,
          onPrimary: Colors.white,
          surface: AppColors.backgroundColor,
          onSurface: Colors.white,
        ),
      );

  static get textFieldBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide.none,
      );

  static get textFieldErrorBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: const BorderSide(
          width: 1,
          color: AppColors.errorBorderColor,
        ),
      );

  static final ElevatedButtonThemeData elevatedButtonTheme =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
    ),
  );
}
