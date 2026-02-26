import 'package:avefin_lms_mobile_app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextTheme {
  static const base = TextTheme(
    displayLarge: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
    displayMedium: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),

    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),

    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),

    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
  );
}

TextTheme lightText = AppTextTheme.base.apply(
  fontFamily: 'Satoshi',
  bodyColor: AppColors.primary,
  displayColor: AppColors.primary,
);

TextTheme darkText = AppTextTheme.base.apply(
  fontFamily: 'Satoshi',
  bodyColor: AppColors.darkTextPrimary,
  displayColor: AppColors.darkTextPrimary,
);
