import 'package:dongu_mobile/presentation/widgets/button/custom_button.dart';
import 'package:dongu_mobile/presentation/widgets/scaffold/custom_scaffold.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FoodWasteView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "",
      body: Container(
        padding: EdgeInsets.only(
          top: context.dynamicHeight(0.02),
          left: context.dynamicWidht(0.06),
          right: context.dynamicWidht(0.06),
        ),
        child: Column(
          children: [
            LocaleText(
              text: LocaleKeys.food_waste_title,
              style: AppTextStyles.headlineStyle,
              alignment: TextAlign.center,
            ),
            Spacer(flex: 1),
            LocaleText(
              text: LocaleKeys.food_waste_text1,
              style: AppTextStyles.bodyBoldTextStyle,
              alignment: TextAlign.center,
            ),
            Spacer(flex: 1),
            LocaleText(
              text: LocaleKeys.food_waste_text2,
              style: AppTextStyles.bodyBoldTextStyle,
              alignment: TextAlign.center,
            ),
            Spacer(flex: 1),
            LocaleText(
              text: LocaleKeys.food_waste_text3,
              style: AppTextStyles.bodyBoldTextStyle,
              alignment: TextAlign.center,
            ),
            Spacer(flex: 1),
            SvgPicture.asset(
              ImageConstant.FOOD_WASTE_SYMBOL,
              height: context.dynamicHeight(0.34),
            ),
            Spacer(flex: 1),
            CustomButton(
              width: context.dynamicWidht(0.86),
              title: LocaleKeys.food_waste_button,
              color: Colors.white,
              borderColor: AppColors.greenColor,
              textColor: AppColors.greenColor,
              onPressed: () {
                Navigator.pushNamed(context, RouteConstant.FOOD_WASTE_EXPANDED_VIEW);
              },
            ),
            Spacer(flex: 1),
            LocaleText(
              text: LocaleKeys.food_waste_skip,
              style: AppTextStyles.bodyTextStyle,
              alignment: TextAlign.center,
            ),
            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
