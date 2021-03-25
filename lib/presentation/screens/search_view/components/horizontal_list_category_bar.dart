import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomHorizontalListCategory extends StatelessWidget {
  const CustomHorizontalListCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        Column(
          children: [
            SvgPicture.asset(ImageConstant.FOOD_ICON),
            SizedBox(
              height: context.dynamicHeight(0.01),
            ),
            LocaleText(
              text: LocaleKeys.search_kind3,
              style: AppTextStyles.subTitleStyle,
            )
          ],
        ),
        SizedBox(
          width: context.dynamicWidht(0.04),
        ),
        Column(
          children: [
            SvgPicture.asset(ImageConstant.DRINK_ICON),
            SizedBox(
              height: context.dynamicHeight(0.01),
            ),
            LocaleText(
              text: LocaleKeys.search_kind8,
              style: AppTextStyles.subTitleStyle,
            )
          ],
        ),
        SizedBox(
          width: context.dynamicWidht(0.04),
        ),
        Column(
          children: [
            SvgPicture.asset(ImageConstant.VEGAN_ICON),
            SizedBox(
              height: context.dynamicHeight(0.01),
            ),
            LocaleText(
              text: LocaleKeys.search_kind6,
              style: AppTextStyles.subTitleStyle,
            )
          ],
        ),
        SizedBox(
          width: context.dynamicWidht(0.04),
        ),
        Column(
          children: [
            SvgPicture.asset(ImageConstant.HAMBURGER_ICON),
            SizedBox(
              height: context.dynamicHeight(0.01),
            ),
            LocaleText(
              text: LocaleKeys.search_kind1,
              style: AppTextStyles.subTitleStyle,
            )
          ],
        ),
        SizedBox(
          width: context.dynamicWidht(0.04),
        ),
        Column(
          children: [
            SvgPicture.asset(ImageConstant.DESSERT_ICON),
            SizedBox(
              height: context.dynamicHeight(0.01),
            ),
            LocaleText(
              text: LocaleKeys.search_kind9,
              style: AppTextStyles.subTitleStyle,
            )
          ],
        ),
        SizedBox(
          width: context.dynamicWidht(0.04),
        ),
        Column(
          children: [
            SvgPicture.asset(ImageConstant.PIZZA_ICON),
            SizedBox(
              height: context.dynamicHeight(0.01),
            ),
            LocaleText(
              text: LocaleKeys.search_kind7,
              style: AppTextStyles.subTitleStyle,
            )
          ],
        ),
        SizedBox(
          width: context.dynamicWidht(0.04),
        ),
        Column(
          children: [
            SvgPicture.asset(ImageConstant.CHICKEN_ICON),
            SizedBox(
              height: context.dynamicHeight(0.01),
            ),
            LocaleText(
              text: LocaleKeys.search_kind5,
              style: AppTextStyles.subTitleStyle,
            )
          ],
        ),
        SizedBox(
          width: context.dynamicWidht(0.04),
        ),
        Column(
          children: [
            SvgPicture.asset(ImageConstant.COFFEE_ICON),
            SizedBox(
              height: context.dynamicHeight(0.01),
            ),
            LocaleText(
              text: LocaleKeys.search_kind10,
              style: AppTextStyles.subTitleStyle,
            )
          ],
        ),
      ],
    );
  }
}
