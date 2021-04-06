import 'package:dongu_mobile/presentation/screens/filter_view/components/custom_expansion_tile.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';

import 'custom_checkbox.dart';

bool allCheck = false;

class ChooseCategoryFilterList extends StatefulWidget {
  ChooseCategoryFilterList({Key? key}) : super(key: key);

  @override
  _ChooseCategoryFilterListState createState() =>
      _ChooseCategoryFilterListState();
}

class _ChooseCategoryFilterListState extends State<ChooseCategoryFilterList> {
  @override
  Widget build(BuildContext context) {
    return CustomExpansionTile(
        expansionTileBody: Padding(
          padding: EdgeInsets.only(left: context.dynamicWidht(0.074)),
          child: Column(
            children: [
              SizedBox(height: context.dynamicHeight(0.01)),
              buildRowCheckboxAndText(
                  context,
                  LocaleKeys.filters_choose_category_item9,
                  buildCheckAll(context)),
              SizedBox(height: context.dynamicHeight(0.016)),
              buildRowCheckboxAndText(
                context,
                LocaleKeys.filters_choose_category_item1,
                Check(),
              ),
              SizedBox(height: context.dynamicHeight(0.016)),
              buildRowCheckboxAndText(
                context,
                LocaleKeys.filters_choose_category_item2,
                Check(),
              ),
              SizedBox(height: context.dynamicHeight(0.016)),
              buildRowCheckboxAndText(
                context,
                LocaleKeys.filters_choose_category_item3,
                Check(),
              ),
              SizedBox(height: context.dynamicHeight(0.016)),
              buildRowCheckboxAndText(
                context,
                LocaleKeys.filters_choose_category_item4,
                Check(),
              ),
              SizedBox(height: context.dynamicHeight(0.016)),
              buildRowCheckboxAndText(
                context,
                LocaleKeys.filters_choose_category_item5,
                Check(),
              ),
              SizedBox(height: context.dynamicHeight(0.016)),
              buildRowCheckboxAndText(
                context,
                LocaleKeys.filters_choose_category_item6,
                Check(),
              ),
              SizedBox(height: context.dynamicHeight(0.016)),
              buildRowCheckboxAndText(
                context,
                LocaleKeys.filters_choose_category_item7,
                Check(),
              ),
              SizedBox(height: context.dynamicHeight(0.016)),
              buildRowCheckboxAndText(
                context,
                LocaleKeys.filters_choose_category_item8,
                Check(),
              ),
              SizedBox(height: context.dynamicHeight(0.030)),
            ],
          ),
        ),
        expansionTileTitle: LocaleKeys.filters_choose_category_title);
  }

  Row buildRowCheckboxAndText(
      BuildContext context, String text, Widget widget) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        widget,
        Spacer(flex: 2),
        LocaleText(text: text, style: AppTextStyles.bodyTextStyle),
        Spacer(flex: 35),
      ],
    );
  }

  CustomCheckbox buildCheckAll(BuildContext context) {
    return CustomCheckbox(
      onTap: () {
        setState(() {
          allCheck = !allCheck;
        });
      },
      checkboxColor: allCheck ? AppColors.greenColor : Colors.white,
    );
  }
}

class Check extends StatefulWidget {
  const Check({Key? key}) : super(key: key);

  @override
  _CheckState createState() => _CheckState();
}

class _CheckState extends State<Check> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return CustomCheckbox(
      onTap: () {
        setState(() {
          value = !value;
        });
      },
      checkboxColor: value || allCheck ? AppColors.greenColor : Colors.white,
    );
  }
}
