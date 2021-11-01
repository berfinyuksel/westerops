import 'package:dongu_mobile/data/model/dummy_model.dart';
import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/logic/cubits/search_cubit/search_cubit.dart';
import 'package:dongu_mobile/presentation/widgets/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:dongu_mobile/data/dummy_search_data/dummy_search_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/extensions/context_extension.dart';
import '../../../utils/extensions/string_extension.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/text/locale_text.dart';
import 'components/horizontal_list_category_bar.dart';
import 'components/horizontal_list_trend_bar.dart';
import 'components/search_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchViewDemo extends StatefulWidget {
  const SearchViewDemo({
    Key? key,
  }) : super(key: key);

  @override
  _SearchViewDemoState createState() => _SearchViewDemoState();
}

class _SearchViewDemoState extends State<SearchViewDemo> {
  TextEditingController? controller = TextEditingController();
  //bool _valueSearch = false;
  final duplicateItems = [
    LocaleKeys.search_item1.locale,
    LocaleKeys.search_item2.locale,
    LocaleKeys.search_item3.locale
  ];
  var items = <String>[];

  late List<Search> searches;
  String query = '';
  bool scroolCategories = true;
  bool scroolTrend = true;
  bool visible = true;
  bool isClean = false;
  @override
  void initState() {
    items.addAll(duplicateItems);
    super.initState();
    searches = allSearches;
    context.read<SearchCubit>().getSearches(controller!.text);
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
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Column(
        children: [
          Spacer(flex: 3,),
          searchBar(context),
          // Spacer(
          //   flex: 3,
          // ),
          Visibility(
              visible: visible, child: searchHistoryAndCleanTexts(context)),
    
          Visibility(visible: visible, child: dividerOne(context)),
        //  Spacer(flex:2),
          Visibility(visible: visible, child: Spacer(flex: 2)),
          items.length == 0 ? emptySearchHistory() : searchListViewBuilder(),
         isClean ? Spacer(flex: 20) : Spacer(flex: 40,),
          Visibility(visible: visible, child: popularSearchText(context)),
          Visibility(visible: visible, child: dividerSecond(context)),
          //Spacer(flex: 2),
          Visibility(visible: visible, child: horizontalListTrend(context)),
          isClean
              ? Spacer(flex: 20)
              : Spacer(
                  flex: 40,
                ),
          Visibility(visible: visible, child: categoriesText(context)),
          Visibility(visible: visible, child: dividerThird(context)),
        //  Spacer(flex: 1),
          Visibility(visible: visible, child: horizontalListCategory(context)),
          Spacer(flex: 10),
        ],
      ),
    );
  }

  Padding horizontalListCategory(BuildContext context) {
    return Padding(
      padding: scroolCategories
          ? EdgeInsets.only(
              left: 26,
              right: 0,
            )
          : EdgeInsets.only(
              left: 0,
              right: 26,
            ),
      child: Container(
          height: context.dynamicHeight(0.19),
          child: NotificationListener<ScrollUpdateNotification>(
              onNotification: (ScrollUpdateNotification notification) {
                setState(() {
                  if (notification.metrics.pixels > 1) {
                    scroolCategories = false;
                  } else if (notification.metrics.pixels < 1) {
                    scroolCategories = true;
                  }
                });

                return true;
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
              left: 26,
              right: 0,
            )
          : EdgeInsets.only(
              left: 0,
              right: 26,
            ),
      child: Container(
          height: context.dynamicHeight(0.04),
          child: NotificationListener<ScrollUpdateNotification>(
              onNotification: (ScrollUpdateNotification notification) {
                setState(() {
                  if (notification.metrics.pixels > 1) {
                    scroolTrend = false;
                  } else if (notification.metrics.pixels < 1) {
                    scroolTrend = true;
                  }
                });

                return true;
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
        itemCount: searches.length,
        itemBuilder: (context, index) {
          final search = searches[index];
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.dynamicWidht(0.06),
             // vertical: context.dynamicHeight(0.00006)
            ),
            decoration: BoxDecoration(color: Colors.white),
            child: buildSearch(search),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LocaleText(
            text: SharedPrefs.getIsLogined
                ? LocaleKeys.search_text1
                : "Popüler Aramalar",
            style: AppTextStyles.bodyTitleStyle,
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              setState(() {
                items.clear();
                items.remove(searches.length);
                isClean = !isClean;
              });
            },
            child: LocaleText(
              text: LocaleKeys.search_text2,
              style: AppTextStyles.bodyTitleStyle
                  .copyWith(color: AppColors.orangeColor, fontSize: 12),
            ),
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
              visible ? context.dynamicWidht(0.88) : context.dynamicWidht(0.70),
          onTap: () {
            setState(() {
              visible = !visible;
            });
          },
          onChanged: (value) {
            filterSearchResults(value);
            searchSearch(query);
          },
          controller: controller,
          hintText: LocaleKeys.search_text5.locale,
          textButton: visible
              ? null
              : TextButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    setState(() {
                      FocusScope.of(context).unfocus();
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

  emptySearchHistory() {
    return Container(
      height: context.dynamicHeight(0.05),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 25),
        child: LocaleText(
            text: LocaleKeys.search_search_history_clean,
            style: AppTextStyles.bodyTextStyle
                .copyWith(color: AppColors.cursorColor)),
      ),
    );
  }

  void searchSearch(String query) {
    final search = allSearches.where((searches) {
      final mealLower = searches.meal.toLowerCase();
      final restaurantLower = searches.restaurant.toLowerCase();
      final searchLower = query.toLowerCase();

      return mealLower.contains(searchLower) ||
          restaurantLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.searches = search;
    });
  }

  Widget buildSearch(Search searches) => ListTile(
        // leading: Image.network(
        //   searches.urlImage,
        //   fit: BoxFit.cover,
        //   width: 50,
        //   height: 50,
        // ),
        title: Text(searches.meal),
        subtitle: Text(searches.restaurant),
      );
}
