import 'package:flutter/material.dart';

abstract class AppColors {
  static const primary = Color(0xFF5048E5);
  static const secondary = Color(0xFFFFFFFF);
  static const primaryText = Color(0xFF111827);
  static const secondaryText = Color(0xFF6B7280);
  static const borderColor = Color(0xFF9F9FA3);
  static const error = Color(0xFFE74C3C);
  static const warning = Color(0xFFA57500);
  static const success = Color(0xFF249689);
  static const moneyColor = Color(0xFF249658);
  static const grey1 = Color(0xFFF2F2F2);
  static const grey2 = Color.fromARGB(255, 197, 197, 197);
  static const grey3 = Color.fromARGB(255, 216, 216, 216);
  static const alternate = Color(0xFFF6F6F6);
  static const whiteTransparent = Color.fromARGB(10, 255, 255, 255); // Figma rgba(255, 255, 255, 0.3)
  static const blackTransparent = Color(0x4D000000);

  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: AppColors.secondary,
    secondary: AppColors.secondary,
    onSecondary: AppColors.secondary,
    surface: Colors.white,
    onSurface: AppColors.primary,
    error: AppColors.error,
    onError: AppColors.error,
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primary,
    onPrimary: AppColors.secondary,
    secondary: AppColors.secondary,
    onSecondary: AppColors.secondary,
    surface: Colors.black,
    onSurface: AppColors.primaryText,
    error: AppColors.error,
    onError: AppColors.error,
  );
}
