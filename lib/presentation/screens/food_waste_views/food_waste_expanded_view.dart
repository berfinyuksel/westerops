import 'package:dongu_mobile/presentation/widgets/button/custom_button.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FoodWasteExpandedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("This will be changed"),
      ),
      body: Container(
        padding: EdgeInsets.only(
          top: context.dynamicHeight(0.02),
          left: context.dynamicWidht(0.06),
          right: context.dynamicWidht(0.06),
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
              height: context.dynamicHeight(0.02),
            ),
            LocaleText(
              text: LocaleKeys.food_waste_expanded_body1,
              style: AppTextStyles.bodyBoldTextStyle,
              alignment: TextAlign.center,
              maxLines: 2,
            ),
            SizedBox(
              height: context.dynamicHeight(0.04),
            ),
            SvgPicture.asset(
              ImageConstant.FOOD_WASTE_EXPANDED_IMAGE_1,
              height: context.dynamicHeight(0.09),
            ),
            SizedBox(
              height: context.dynamicHeight(0.02),
            ),
            LocaleText(
              text: LocaleKeys.food_waste_expanded_body2,
              style: AppTextStyles.bodyBoldTextStyle,
              alignment: TextAlign.center,
            ),
            SizedBox(
              height: context.dynamicHeight(0.04),
            ),
            SvgPicture.asset(
              ImageConstant.FOOD_WASTE_EXPANDED_IMAGE_2,
              height: context.dynamicHeight(0.14),
            ),
            SizedBox(
              height: context.dynamicHeight(0.02),
            ),
            LocaleText(
              text: LocaleKeys.food_waste_expanded_body3,
              style: AppTextStyles.bodyBoldTextStyle,
              alignment: TextAlign.center,
            ),
            SizedBox(
              height: context.dynamicHeight(0.05),
            ),
            LocaleText(
              text: LocaleKeys.food_waste_expanded_headline2,
              style: AppTextStyles.headlineStyle,
              alignment: TextAlign.center,
              maxLines: 1,
            ),
            SizedBox(
              height: context.dynamicHeight(0.02),
            ),
            SvgPicture.asset(
              ImageConstant.FOOD_WASTE_EXPANDED_IMAGE_3,
              height: context.dynamicHeight(0.15),
            ),
            SizedBox(
              height: context.dynamicHeight(0.01),
            ),
            LocaleText(
              text: LocaleKeys.food_waste_expanded_body4,
              style: AppTextStyles.bodyBoldTextStyle,
              alignment: TextAlign.center,
              maxLines: 2,
            ),
            SizedBox(
              height: context.dynamicHeight(0.02),
            ),
            SvgPicture.asset(
              ImageConstant.FOOD_WASTE_EXPANDED_IMAGE_4,
              height: context.dynamicHeight(0.15),
            ),
            SizedBox(
              height: context.dynamicHeight(0.01),
            ),
            LocaleText(
              text: LocaleKeys.food_waste_expanded_body5,
              style: AppTextStyles.bodyBoldTextStyle,
              alignment: TextAlign.center,
              maxLines: 2,
            ),
            SizedBox(
              height: context.dynamicHeight(0.02),
            ),
            SvgPicture.asset(
              ImageConstant.FOOD_WASTE_EXPANDED_IMAGE_5,
              height: context.dynamicHeight(0.15),
            ),
            SizedBox(
              height: context.dynamicHeight(0.01),
            ),
            LocaleText(
              text: LocaleKeys.food_waste_expanded_body6,
              style: AppTextStyles.bodyBoldTextStyle,
              alignment: TextAlign.center,
              maxLines: 2,
            ),
            SizedBox(
              height: context.dynamicHeight(0.02),
            ),
            SvgPicture.asset(
              ImageConstant.FOOD_WASTE_EXPANDED_IMAGE_6,
              height: context.dynamicHeight(0.15),
            ),
            SizedBox(
              height: context.dynamicHeight(0.01),
            ),
            LocaleText(
              text: LocaleKeys.food_waste_expanded_body7,
              style: AppTextStyles.bodyBoldTextStyle,
              alignment: TextAlign.center,
              maxLines: 2,
            ),
            SizedBox(
              height: context.dynamicHeight(0.05),
            ),
            LocaleText(
              text: LocaleKeys.food_waste_expanded_headline3,
              style: AppTextStyles.headlineStyle,
              alignment: TextAlign.center,
              maxLines: 1,
            ),
            SizedBox(
              height: context.dynamicHeight(0.02),
            ),
            SvgPicture.asset(
              ImageConstant.FOOD_WASTE_EXPANDED_IMAGE_7,
              height: context.dynamicHeight(0.17),
            ),
            SizedBox(
              height: context.dynamicHeight(0.02),
            ),
            LocaleText(
              text: LocaleKeys.food_waste_expanded_body8,
              style: AppTextStyles.bodyBoldTextStyle,
              alignment: TextAlign.center,
            ),
            SizedBox(
              height: context.dynamicHeight(0.04),
            ),
            CustomButton(
              width: context.dynamicWidht(0.86),
              title: LocaleKeys.food_waste_expanded_button,
              color: AppColors.greenColor,
              borderColor: AppColors.greenColor,
              textColor: Colors.white,
            ),
            SizedBox(
              height: context.dynamicHeight(0.02),
            ),
          ],
        ),
      ),
    );
  }
}
