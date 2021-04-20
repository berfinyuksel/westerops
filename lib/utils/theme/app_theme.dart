import 'app_colors/app_colors.dart';
import 'package:flutter/material.dart';

enum AppTheme {
  PrimaryTheme,
}

final appThemeData = {
  AppTheme.PrimaryTheme: ThemeData(
    primaryColor: AppColors.primaryColor,
    backgroundColor: Colors.white,
    appBarTheme: AppBarTheme(backgroundColor: AppColors.appBarColor),
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
  ),
};
