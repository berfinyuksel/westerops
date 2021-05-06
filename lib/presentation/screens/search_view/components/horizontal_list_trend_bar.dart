import 'package:flutter/material.dart';

import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/locale_keys.g.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/text/locale_text.dart';

class CustomHorizontalListTrend extends StatelessWidget {
  const CustomHorizontalListTrend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        Container(
          alignment: Alignment.center,
          width: context.dynamicWidht(0.22),
          height: context.dynamicHeight(0.03),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: Colors.white,
            border: Border.all(
              width: 2.0,
              color: AppColors.borderAndDividerColor,
            ),
          ),
          child: SizedBox(
              width: context.dynamicWidht(0.19),
              height: context.dynamicHeight(0.05),
              child: LocaleText(
                text: LocaleKeys.search_kind1,
                alignment: TextAlign.center,
                style: AppTextStyles.bodyTextStyle,
              )),
        ),
        SizedBox(
          width: context.dynamicWidht(0.028),
        ),
        Container(
          alignment: Alignment.center,
          width: context.dynamicWidht(0.22),
          height: context.dynamicHeight(0.03),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: Colors.white,
            border: Border.all(
              width: 2.0,
              color: AppColors.borderAndDividerColor,
            ),
          ),
          child: SizedBox(
              width: context.dynamicWidht(0.19),
              height: context.dynamicHeight(0.05),
              child: LocaleText(
                  text: LocaleKeys.search_kind2,
                  style: AppTextStyles.bodyTextStyle,
                  alignment: TextAlign.center)),
        ),
        SizedBox(
          width: context.dynamicWidht(0.028),
        ),
        Container(
          alignment: Alignment.center,
          width: context.dynamicWidht(0.22),
          height: context.dynamicHeight(0.03),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: Colors.white,
            border: Border.all(
              width: 2.0,
              color: AppColors.borderAndDividerColor,
            ),
          ),
          child: SizedBox(
              width: context.dynamicWidht(0.19),
              height: context.dynamicHeight(0.05),
              child: LocaleText(
                  text: LocaleKeys.search_kind3,
                  style: AppTextStyles.bodyTextStyle,
                  alignment: TextAlign.center)),
        ),
        SizedBox(
          width: context.dynamicWidht(0.028),
        ),
        Container(
          alignment: Alignment.center,
          width: context.dynamicWidht(0.22),
          height: context.dynamicHeight(0.03),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: Colors.white,
            border: Border.all(
              width: 2.0,
              color: AppColors.borderAndDividerColor,
            ),
          ),
          child: SizedBox(
              width: context.dynamicWidht(0.19),
              height: context.dynamicHeight(0.05),
              child: LocaleText(
                  text: LocaleKeys.search_kind1,
                  style: AppTextStyles.bodyTextStyle,
                  alignment: TextAlign.center)),
        ),
        SizedBox(
          width: context.dynamicWidht(0.028),
        ),
        Container(
          alignment: Alignment.center,
          width: context.dynamicWidht(0.22),
          height: context.dynamicHeight(0.03),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: Colors.white,
            border: Border.all(
              width: 2.0,
              color: AppColors.borderAndDividerColor,
            ),
          ),
          child: SizedBox(
              width: context.dynamicWidht(0.19),
              height: context.dynamicHeight(0.05),
              child: LocaleText(
                  text: LocaleKeys.search_kind5,
                  style: AppTextStyles.bodyTextStyle,
                  alignment: TextAlign.center)),
        ),
      ],
    );
  }
}
