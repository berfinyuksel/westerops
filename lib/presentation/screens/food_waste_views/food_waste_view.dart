import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/constants/image_constant.dart';
import '../../../utils/constants/route_constant.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/scaffold/components/custom_drawer.dart';
import '../../widgets/text/locale_text.dart';

class FoodWasteView extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      endDrawer: CustomDrawer(),
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(ImageConstant.BACK_ICON),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 150.w, right: 150.w, top: 20.h),
              child: LocaleText(
                text: LocaleKeys.food_waste_title,
                style: AppTextStyles.headlineStyle,
                alignment: TextAlign.center,
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.only(left: 28.w, right: 28.w),
              child: Container(
                height: 243.h,
                child: Column(
                  children: [
                    LocaleText(
                      text: LocaleKeys.food_waste_text1,
                      style: AppTextStyles.bodyBoldTextStyle,
                      alignment: TextAlign.center,
                    ),
                    Spacer(),
                    LocaleText(
                      text: LocaleKeys.food_waste_text2,
                      alignment: TextAlign.center,
                      style: AppTextStyles.bodyBoldTextStyle,
                    ),
                    Spacer(),
                    LocaleText(
                      text: LocaleKeys.food_waste_text3,
                      style: AppTextStyles.bodyBoldTextStyle,
                      alignment: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            SvgPicture.asset(
              ImageConstant.FOOD_WASTE_SYMBOL,
              height: 318.12.h,
            ),
            SizedBox(height: 35.9.h),
            CustomButton(
              width: 372.h,
              title: LocaleKeys.food_waste_button,
              color: Colors.white,
              borderColor: AppColors.greenColor,
              textColor: AppColors.greenColor,
              onPressed: () {
                Navigator.pushNamed(
                    context, RouteConstant.FOOD_WASTE_EXPANDED_VIEW);
              },
            ),
            SizedBox(height: 16.h),
            lateForNowButton(context),
            SizedBox(height: 60.h),
          ],
        ),
      ),
    );
  }

  GestureDetector lateForNowButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RouteConstant.CUSTOM_SCAFFOLD);
      },
      child: AutoSizeText(
        LocaleKeys.food_waste_skip.locale,
        style:
            AppTextStyles.bodyTextStyle.copyWith(fontWeight: FontWeight.w400),
      ),
    );
  }
}
