import 'package:flutter/material.dart';

import '../../../utils/extensions/context_extension.dart';
import '../../../utils/extensions/string_extension.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/text/locale_text.dart';
import 'components/horizontal_list_category_bar.dart';
import 'components/horizontal_list_trend_bar.dart';
import 'components/search_bar.dart';

class SearchView extends StatefulWidget {
  const SearchView({
    Key? key,
  }) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController? controller = TextEditingController();
  //bool _valueSearch = false;
  final duplicateItems = [
    LocaleKeys.search_item1.locale,
    LocaleKeys.search_item2.locale,
    LocaleKeys.search_item3.locale
  ];
  var items = <String>[];

  bool scroolCategories = false;
  bool scroolTrend = false;
  bool visible = true;
  @override
  void initState() {
    items.addAll(duplicateItems);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = <String>[];
    dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      List<String> dummyListData = <String>[];
      dummyListData.forEach((item) {
        if (item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  GestureDetector buildBody(BuildContext context) {
    return GestureDetector(
      onTap: (){
          FocusScope.of(context).unfocus();
        
      },
      child: Column(
        children: [
          searchBar(context),
          Visibility(
              visible: visible, child: searchHistoryAndCleanTexts(context)),
          Visibility(visible: visible, child: dividerOne(context)),
          Visibility(visible: visible, child: Spacer(flex: 2)),
          searchListViewBuilder(),
          Spacer(flex: 4),
          Visibility(visible: visible, child: popularSearchText(context)),
          Visibility(visible: visible, child: dividerSecond(context)),
          Spacer(flex: 4),
          Visibility(visible: visible, child: horizontalListTrend(context)),
          Spacer(flex: 4),
          Visibility(visible: visible, child: categoriesText(context)),
          Visibility(visible: visible, child: dividerThird(context)),
          Spacer(flex: 1),
          Visibility(visible: visible, child: horizontalListCategory(context)),
          Spacer(flex: 14),
        ],
      ),
    );
  }

  Padding horizontalListCategory(BuildContext context) {
    return Padding(
      padding: scroolCategories
          ? EdgeInsets.only(
              left: context.dynamicWidht(0.00),
            )
          : EdgeInsets.only(
              left: context.dynamicWidht(0.06),
            ),
      child: Container(
          height: context.dynamicHeight(0.19),
          child: NotificationListener(
              onNotification: (t) {
                if (scroolCategories == false) {
                  setState(() {
                    scroolCategories = !scroolCategories;
                  });
                }
                return scroolCategories;
              },
              child: CustomHorizontalListCategory())),
    );
  }

  Padding dividerThird(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
      ),
      child: Divider(
        color: AppColors.borderAndDividerColor,
        thickness: 5,
      ),
    );
  }

  Padding categoriesText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: context.dynamicWidht(0.6),
      ),
      child: LocaleText(
        text: LocaleKeys.search_text4,
        style: AppTextStyles.bodyTitleStyle,
      ),
    );
  }

  Padding horizontalListTrend(BuildContext context) {
    return Padding(
      padding: scroolTrend
          ? EdgeInsets.only(
              left: context.dynamicWidht(0.00),
            )
          : EdgeInsets.only(
              left: context.dynamicWidht(0.06),
            ),
      child: Container(
          height: context.dynamicHeight(0.04),
          child: NotificationListener(
              onNotification: (t) {
                if (scroolTrend == false) {
                  setState(() {
                    scroolTrend = !scroolTrend;
                  });
                }
                return scroolTrend;
              },
              child: CustomHorizontalListTrend())),
    );
  }

  Padding dividerSecond(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
      ),
      child: Divider(
        color: AppColors.borderAndDividerColor,
        thickness: 5,
      ),
    );
  }

  Padding popularSearchText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: context.dynamicWidht(0.5),
      ),
      child: LocaleText(
        text: LocaleKeys.search_text3,
        style: AppTextStyles.bodyTitleStyle,
      ),
    );
  }

  ListView searchListViewBuilder() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.dynamicWidht(0.06),
            ),
            decoration: BoxDecoration(color: Colors.white),
            child: ListTile(
              leading: LocaleText(
                text: "${items[index]}",
                style: AppTextStyles.bodyTextStyle,
              ),
              trailing: visible ? null : Icon(Icons.chevron_right),
            ),
          );
        });
  }

  Padding dividerOne(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
      ),
      child: Divider(
        color: AppColors.borderAndDividerColor,
        thickness: 5,
      ),
    );
  }

  Padding searchHistoryAndCleanTexts(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.dynamicWidht(0.06),
      ),
      child: Row(
        children: [
          LocaleText(
            text: LocaleKeys.search_text1,
            style: AppTextStyles.bodyTitleStyle,
          ),
          Spacer(
            flex: 18,
          ),
          LocaleText(
            text: LocaleKeys.search_text2,
            style: AppTextStyles.bodyTitleStyle
                .copyWith(color: AppColors.orangeColor, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Padding searchBar(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.dynamicWidht(0.06),
          vertical: context.dynamicHeight(0.03),
        ),
        child: CustomSearchBar(
          containerPadding:
              visible ? context.dynamicWidht(0.85) : context.dynamicWidht(0.71),
          onTap: () {
            setState(() {
              visible = !visible;
            });
          },
          onChanged: (value) {
            filterSearchResults(value);
          },
          controller: controller,
          hintText: LocaleKeys.search_text5.locale,
          textButton: visible
              ? null
              : TextButton(
                  onPressed: () {
                    setState(() {
                      visible = !visible;
                    });
                  },
                  child: Text(
                    LocaleKeys.search_cancel_button.locale,
                    style: AppTextStyles.bodyTitleStyle
                        .copyWith(color: AppColors.orangeColor, fontSize: 12),
                  )),
        ));
  }
}
