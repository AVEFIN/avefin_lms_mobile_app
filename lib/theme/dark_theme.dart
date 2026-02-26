import 'package:avefin_lms_mobile_app/theme/app_colors.dart';
import 'package:avefin_lms_mobile_app/theme/text_theme.dart';
import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.darkBackgroundPrimary,
  fontFamily: 'Satoshi',
  textTheme: darkText,

  colorScheme: const ColorScheme.dark(
    primary: AppColors.primaryBlue,
    secondary: Color.fromARGB(255, 158, 171, 224),
    surface: AppColors.darkSurface,
    background: AppColors.darkBackgroundPrimary,
  ),

  cardTheme: CardThemeData(
    color: AppColors.darkSurface,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),

  dividerColor: AppColors.darkBorderSubtle,
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.darkSurface,

    contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: AppColors.darkBorderSubtle, width: 1),
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
