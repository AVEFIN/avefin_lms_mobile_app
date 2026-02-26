import 'package:avefin_lms_mobile_app/theme/app_colors.dart';
import 'package:avefin_lms_mobile_app/theme/text_theme.dart';
import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.lightBackgroundPrimary,
  fontFamily: 'Satoshi',
  textTheme: lightText,

  colorScheme: const ColorScheme.light(
    primary: AppColors.primaryBlue,
    secondary: AppColors.primary,
    surface: AppColors.lightSurface,
    background: AppColors.lightBackgroundPrimary,
  ),

  cardTheme: CardThemeData(
    color: AppColors.lightSurface,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),

  dividerColor: AppColors.lightBorderSubtle,
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.lightSurface,

    contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: AppColors.lightBorderSubtle, width: 1),
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: AppColors.primaryBlue, width: 1.5),
    ),

    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: AppColors.error, width: 1),
    ),

    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: AppColors.error, width: 1.5),
    ),
    floatingLabelStyle: TextStyle(color: AppColors.primaryBlue),
  ),
);
