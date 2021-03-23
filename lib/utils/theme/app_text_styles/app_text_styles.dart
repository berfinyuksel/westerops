import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle headlineStyle = GoogleFonts.montserrat(
    decoration: TextDecoration.none,
    fontSize: 24.0,
    color: AppColors.orangeColor,
    fontWeight: FontWeight.w700,
    height: 1.33,
  );
  static TextStyle appBarTitleStyle = GoogleFonts.montserrat(
    decoration: TextDecoration.none,
    fontSize: 18.0,
    color: AppColors.textColor,
    fontWeight: FontWeight.w300,
  );
  static TextStyle subTitleStyle = GoogleFonts.montserrat(
    decoration: TextDecoration.none,
    fontSize: 11.0,
    color: AppColors.textColor,
    fontWeight: FontWeight.w300,
    height: 1.64,
  );
  static TextStyle bodyTitleStyle = GoogleFonts.montserrat(
    decoration: TextDecoration.none,
    fontSize: 16.0,
    color: AppColors.textColor,
    fontWeight: FontWeight.w600,
    height: 1.5,
  );

  static TextStyle bodyTextStyle = GoogleFonts.montserrat(
    decoration: TextDecoration.none,
    fontSize: 14.0,
    color: AppColors.textColor,
    fontWeight: FontWeight.w300,
    height: 1.71,
  );
  static TextStyle bodyBoldTextStyle = GoogleFonts.montserrat(
    decoration: TextDecoration.none,
    fontSize: 14.0,
    color: const Color(0xFF2E3142),
    fontWeight: FontWeight.w600,
    height: 1.71,
  );
  static TextStyle myInformationBodyTextStyle = GoogleFonts.montserrat(
    decoration: TextDecoration.none,
    fontSize: 14.0,
    color: const Color(0xFF2E3142),
    fontWeight: FontWeight.w500,
    height: 1.71,
  );
}
