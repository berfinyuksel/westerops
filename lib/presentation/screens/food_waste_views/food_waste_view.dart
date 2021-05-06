import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/constants/image_constant.dart';
import '../../../utils/constants/route_constant.dart';
import '../../../utils/extensions/context_extension.dart';
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
        actions: [
          Padding(
            padding: EdgeInsets.only(right: context.dynamicWidht(0.03)),
            child: IconButton(
              icon: SvgPicture.asset(ImageConstant.COMMONS_DRAWER_ICON),
              onPressed: () => scaffoldKey.currentState!.openEndDrawer(),
            ),
          ),
        ],
        leading: IconButton(
          icon: SvgPicture.asset(ImageConstant.BACK_ICON),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
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
