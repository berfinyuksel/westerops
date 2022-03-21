import 'package:dongu_mobile/data/services/locator.dart';
import 'package:dongu_mobile/logic/cubits/search_cubit/search_cubit.dart';
import 'package:dongu_mobile/logic/cubits/search_store_cubit/search_store_cubit.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:dongu_mobile/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';

import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/locale_keys.g.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/text/locale_text.dart';

class CustomHorizontalListTrend extends StatelessWidget {
  CustomHorizontalListTrend({Key? key}) : super(key: key);

  List<String> categoryLocaleKeys = [
    LocaleKeys.search_kind1,
    LocaleKeys.search_kind2,
    LocaleKeys.search_kind3,
    LocaleKeys.search_kind4,
    LocaleKeys.search_kind5,
    LocaleKeys.search_kind6,
    LocaleKeys.search_kind7,
    LocaleKeys.search_kind8,
    LocaleKeys.search_kind9,
    LocaleKeys.search_kind10,
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: categoryLocaleKeys.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) {
          return trendSearchContainer(context, index);
        }));
  }

  Column trendSearchContainer(BuildContext context, int index) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            sl<SearchStoreCubit>().getSearches(categoryLocaleKeys[index].locale);
            sl<SearchStoreCubit>().changeCategoryName(categoryLocaleKeys[index].locale);
          },
          child: Container(
            alignment: Alignment.center,
            width: context.dynamicWidht(0.25),
            height: context.dynamicHeight(0.04),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: Colors.white,
              border: Border.all(
                width: 2.0,
                color: AppColors.borderAndDividerColor,
              ),
            ),
            child: SizedBox(
                width: context.dynamicWidht(0.23),
                height: context.dynamicHeight(0.02),
                child: LocaleText(
                    text: categoryLocaleKeys[index],
                    style: AppTextStyles.bodyTextStyle,
                    alignment: TextAlign.center)),
          ),
        ),
        SizedBox(
          width: context.dynamicWidht(0.028),
        ),
      ],
    );
  }
}
