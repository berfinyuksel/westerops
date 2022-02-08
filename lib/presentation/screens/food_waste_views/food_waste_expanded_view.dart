import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/constants/image_constant.dart';
import '../../../utils/constants/route_constant.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/scaffold/custom_scaffold.dart';
import '../../widgets/text/locale_text.dart';

class FoodWasteExpandedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: LocaleKeys.food_waste_title,
      body: Container(
        padding: EdgeInsets.only(
          top: 26.h,
          left: 45.w,
          right: 45.w,
        ),
        child: ListView(
          children: [
            LocaleText(
              text: LocaleKeys.food_waste_expanded_headline1,
              style: AppTextStyles.headlineStyle,
              alignment: TextAlign.center,
              maxLines: 2,
            ),
            SizedBox(
              height: 23.h,
            ),
            LocaleText(
              text: LocaleKeys.food_waste_expanded_body1,
              style: AppTextStyles.bodyBoldTextStyle,
              alignment: TextAlign.center,
              maxLines: 2,
            ),
            SizedBox(
              height: 40.h,
            ),
            SvgPicture.asset(
              ImageConstant.FOOD_WASTE_EXPANDED_IMAGE_1,
              height: 85.81.h,
            ),
            SizedBox(
              height: 20.h,
            ),
            LocaleText(
              text: LocaleKeys.food_waste_expanded_body2,
              style: AppTextStyles.bodyBoldTextStyle,
              alignment: TextAlign.center,
            ),
            SizedBox(
              height: 40.h,
            ),
            SvgPicture.asset(
              ImageConstant.FOOD_WASTE_EXPANDED_IMAGE_2,
              height: 137.02.h,
            ),
            SizedBox(
              height: 20.h,
            ),
            LocaleText(
              text: LocaleKeys.food_waste_expanded_body3,
              style: AppTextStyles.bodyBoldTextStyle,
              alignment: TextAlign.center,
            ),
            SizedBox(
              height: 50.2.h,
            ),
            LocaleText(
              text: LocaleKeys.food_waste_expanded_headline2,
              style: AppTextStyles.headlineStyle,
              alignment: TextAlign.center,
              maxLines: 1,
            ),
            SizedBox(
              height: 20.h,
            ),
            SvgPicture.asset(
              ImageConstant.FOOD_WASTE_EXPANDED_IMAGE_3,
              height: 145.h,
            ),
            SizedBox(
              height: 10.h,
            ),
            LocaleText(
              text: LocaleKeys.food_waste_expanded_body4,
              style: AppTextStyles.bodyBoldTextStyle,
              alignment: TextAlign.center,
              maxLines: 2,
            ),
            SizedBox(
              height: 40.h,
            ),
            SvgPicture.asset(
              ImageConstant.FOOD_WASTE_EXPANDED_IMAGE_4,
              height: 145.h,
            ),
            SizedBox(
              height: 10.h,
            ),
            LocaleText(
              text: LocaleKeys.food_waste_expanded_body5,
              style: AppTextStyles.bodyBoldTextStyle,
              alignment: TextAlign.center,
              maxLines: 2,
            ),
            SizedBox(
              height: 40.h,
            ),
            SvgPicture.asset(
              ImageConstant.FOOD_WASTE_EXPANDED_IMAGE_5,
              height: 145.h,
            ),
            SizedBox(
              height: 10.h,
            ),
            LocaleText(
              text: LocaleKeys.food_waste_expanded_body6,
              style: AppTextStyles.bodyBoldTextStyle,
              alignment: TextAlign.center,
              maxLines: 2,
            ),
            SizedBox(
              height: 40.h,
            ),
            SvgPicture.asset(
              ImageConstant.FOOD_WASTE_EXPANDED_IMAGE_6,
              height: 145.h,
            ),
            SizedBox(
              height: 10.h,
            ),
            LocaleText(
              text: LocaleKeys.food_waste_expanded_body7,
              style: AppTextStyles.bodyBoldTextStyle,
              alignment: TextAlign.center,
              maxLines: 2,
            ),
            SizedBox(
              height: 50.h,
            ),
            LocaleText(
              text: LocaleKeys.food_waste_expanded_headline3,
              style: AppTextStyles.headlineStyle,
              alignment: TextAlign.center,
              maxLines: 1,
            ),
            SizedBox(
              height: 20.h,
            ),
            SvgPicture.asset(
              ImageConstant.FOOD_WASTE_EXPANDED_IMAGE_7,
              height: 160.81.h,
            ),
            SizedBox(
              height: 20.2.h,
            ),
            LocaleText(
              text: LocaleKeys.food_waste_expanded_body8,
              style: AppTextStyles.bodyBoldTextStyle,
              alignment: TextAlign.center,
            ),
            SizedBox(
              height: 40.h,
            ),
            CustomButton(
              width: 372.w,
              title: LocaleKeys.food_waste_expanded_button,
              color: AppColors.greenColor,
              borderColor: AppColors.greenColor,
              textColor: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, RouteConstant.CUSTOM_SCAFFOLD);
              },
            ),
            SizedBox(
              height: 30.h,
            ),
          ],
        ),
      ),
    );
  }
}
