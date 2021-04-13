import 'package:dongu_mobile/presentation/screens/filter_view/components/custom_expansion_tile.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';

import 'custom_checkbox.dart';

class SortFilterList extends StatefulWidget {
  const SortFilterList({Key? key}) : super(key: key);

  @override
  _SortFilterListState createState() => _SortFilterListState();
}

class _SortFilterListState extends State<SortFilterList> {
  @override
  Widget build(BuildContext context) {
    return CustomExpansionTile(
        expansionTileBody: Padding(
          padding: EdgeInsets.only(left: context.dynamicWidht(0.074)),
          child: Column(
            children: [
              SizedBox(height: context.dynamicHeight(0.01)),
              buildRowCheckboxAndText(context, LocaleKeys.filters_sort_item1),
              SizedBox(height: context.dynamicHeight(0.016)),
              buildRowCheckboxAndText(context, LocaleKeys.filters_sort_item2),
              SizedBox(height: context.dynamicHeight(0.016)),
              buildRowCheckboxAndText(context, LocaleKeys.filters_sort_item3),
              SizedBox(height: context.dynamicHeight(0.016)),
              buildRowCheckboxAndText(context, LocaleKeys.filters_sort_item4),
              SizedBox(height: context.dynamicHeight(0.030)),
            ],
          ),
        ),
        expansionTileTitle: LocaleKeys.filters_sort_title);
  }

  Row buildRowCheckboxAndText(BuildContext context, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Check(),
        Spacer(flex: 2),
        LocaleText(text: text, style: AppTextStyles.bodyTextStyle),
        Spacer(flex: 35),
      ],
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
      checkboxColor: value ? AppColors.greenColor : Colors.white,
    );
  }
}