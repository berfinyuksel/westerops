import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';

class RestaurantDetailsTabBar extends StatelessWidget {
  final void Function(int)? onTap;
  final TabController controller;
  RestaurantDetailsTabBar({
    Key? key,
    this.onTap,
    required this.controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TabBar(
        onTap: onTap,
        labelPadding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.1)),
        indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: 3, color: AppColors.orangeColor),
            insets: EdgeInsets.symmetric(
              horizontal: context.dynamicWidht(0.11),
            )), // top değeri değişecek
        indicatorPadding: EdgeInsets.only(bottom: context.dynamicHeight(0.01)),
        labelColor: AppColors.orangeColor,
        labelStyle: AppTextStyles.bodyTitleStyle,
        unselectedLabelColor: AppColors.textColor,
        unselectedLabelStyle: GoogleFonts.montserrat(
          decoration: TextDecoration.none,
          fontSize: 18.0.sp,
          color: AppColors.textColor,
          fontWeight: FontWeight.w300,
          height: 2.5.h,
        ),
        indicatorColor: AppColors.orangeColor,
        controller: controller,
        isScrollable: true,
        tabs: [
          Tab(
            text: LocaleKeys.restaurant_detail_text1.locale,
          ),
          Tab(
            text: LocaleKeys.restaurant_detail_text2.locale,
          ),
        ]);
  }
}