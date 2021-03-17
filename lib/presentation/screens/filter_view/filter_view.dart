import 'package:auto_size_text/auto_size_text.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dongu_mobile/utils/extensions/string_extension.dart';

import 'components/custom_checkbox.dart';

class FilterView extends StatelessWidget {
  const FilterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _value = false;
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            sortFilter(context),
            Divider(
            height: 1,
              color: Colors.transparent,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: ExpansionTile(
                title: Text(
                  "Paket Fiyatı",
                  style: AppTextStyles.bodyTitleStyle,
                ),
                trailing: SvgPicture.asset(ImageConstant.RIGHT_ICON),
                backgroundColor: Colors.white,
                children: [
                  
                ],
              ),
            ),
            Divider(
          height: 1,
             color: Colors.transparent,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: ExpansionTile(
                title: Text(
                  "Paket Teslimi",
                  style: AppTextStyles.bodyTitleStyle,
                ),
                trailing: SvgPicture.asset(ImageConstant.RIGHT_ICON),
                backgroundColor: Colors.white,
                children: [],
              ),
            ),
            Divider(
           height: 1,
              color: Colors.transparent,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: ExpansionTile(
                title: Text(
                  "Ödeme Şekli",
                  style: AppTextStyles.bodyTitleStyle,
                ),
                trailing: SvgPicture.asset(ImageConstant.RIGHT_ICON),
                backgroundColor: Colors.white,
                children: [],
              ),
            ),
            Divider(
              height: 1,
              color: Colors.transparent,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: ExpansionTile(
                title: Text(
                  "Kategori Seç",
                  style: AppTextStyles.bodyTitleStyle,
                ),
                trailing: SvgPicture.asset(ImageConstant.RIGHT_ICON),
                backgroundColor: Colors.white,
                children: [],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container sortFilter(BuildContext context) {
    return Container(
            decoration: BoxDecoration(color: Colors.white),
            child: ExpansionTile(
              title: AutoSizeText(
                "Sırala",
                style: AppTextStyles.bodyTitleStyle,
              ),
              trailing:  SvgPicture.asset(ImageConstant.RIGHT_ICON),
              backgroundColor: Colors.white,
              children: [
                Container(
                  width: context.dynamicWidht(0.9),
                  height: context.dynamicHeight(0.2),
                  child: Expanded(
                    child: Column(
                      children: [
                        Spacer(flex: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomCheckbox(),
                            Spacer(flex: 2),
                            AutoSizeText(LocaleKeys.filters_sort_item1.locale,
                                style: AppTextStyles.bodyTextStyle
                                    .copyWith(fontSize: 13)),
                            Spacer(flex: 35),
                          ],
                        ),
                        Spacer(flex: 35),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomCheckbox(),
                            Spacer(flex: 2),
                            AutoSizeText(LocaleKeys.filters_sort_item2.locale,
                                style: AppTextStyles.bodyTextStyle
                                    .copyWith(fontSize: 13)),
                            Spacer(flex: 35),
                          ],
                        ),
                        Spacer(flex: 35),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomCheckbox(),
                            Spacer(flex: 2),
                            AutoSizeText(LocaleKeys.filters_sort_item3.locale,
                                style: AppTextStyles.bodyTextStyle
                                    .copyWith(fontSize: 13)),
                            Spacer(flex: 35),
                          ],
                        ),
                        Spacer(flex: 35),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomCheckbox(),
                            Spacer(flex: 2),
                            AutoSizeText(LocaleKeys.filters_sort_item4.locale,
                                style: AppTextStyles.bodyTextStyle
                                    .copyWith(fontSize: 13)),
                            Spacer(flex: 35),
                          ],
                        ),
                        Spacer(flex: 70),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
