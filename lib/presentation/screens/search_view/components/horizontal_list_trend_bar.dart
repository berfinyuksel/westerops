import 'package:auto_size_text/auto_size_text.dart';
import 'package:dongu_mobile/data/services/locator.dart';
import 'package:dongu_mobile/logic/cubits/search_store_cubit/search_store_cubit.dart';
import 'package:dongu_mobile/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';

import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';

class CustomHorizontalListTrend extends StatefulWidget {
  CustomHorizontalListTrend({Key? key}) : super(key: key);

  @override
  State<CustomHorizontalListTrend> createState() => _CustomHorizontalListTrendState();
}

class _CustomHorizontalListTrendState extends State<CustomHorizontalListTrend> {
  List<String> popularSearchesList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sl<SearchStoreCubit>().getPopulerSearchesList();
    popularSearchesList = sl<SearchStoreCubit>().popularSearchesList;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: popularSearchesList.length,
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
            sl<SearchStoreCubit>().getSearches(popularSearchesList[index].locale);
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
                child: AutoSizeText(popularSearchesList[index],
                    style: AppTextStyles.bodyTextStyle, textAlign: TextAlign.center)),
          ),
        ),
        SizedBox(
          width: context.dynamicWidht(0.028),
        ),
      ],
    );
  }
}
