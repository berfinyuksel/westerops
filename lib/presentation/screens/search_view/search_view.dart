import 'package:dongu_mobile/data/model/search_store.dart';
import 'package:dongu_mobile/logic/cubits/padding_values_cubit/category_padding_values_cubit.dart';
import 'package:dongu_mobile/logic/cubits/search_store_cubit/search_store_cubit.dart';
import 'package:dongu_mobile/presentation/screens/restaurant_details_views/screen_arguments/screen_arguments.dart';
import 'package:dongu_mobile/presentation/widgets/circular_progress_indicator/custom_circular_progress_indicator.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

//import '../../../data/model/search.dart';
import '../../../data/shared/shared_prefs.dart';
import '../../../logic/cubits/generic_state/generic_state.dart';

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

  List<SearchStore> names = [];
  List<SearchStore> filteredNames = []; // names filtered by search text

  String query = '';
  bool scroolCategoriesLeft = true;
  bool scroolCategoriesRight = false;
  String mealNames = "";
  bool scroolTrendLeft = true;
  bool scroolTrendRight = false;

  bool visible = true;
  bool isClean = false;
  @override
  void initState() {
    super.initState();
  }

  Builder buildBuilder() {
    return Builder(builder: (context) {
      final GenericState state = context.watch<SearchStoreCubit>().state;

      if (state is GenericInitial) {
        return Container();
      } else if (state is GenericLoading) {
        return Center(child: CustomCircularProgressIndicator());
      } else if (state is GenericCompleted) {
        List<SearchStore> searchList = [];

        List<SearchStore> restaurant = [];

        for (int i = 0; i < state.response.length; i++) {
          searchList.add(state.response[i]);
          if (state is GenericCompleted) {
            restaurant.add(state.response[i]);
          }
        }
        names = searchList;
        filteredNames = names;

        return Center(
          child: filteredNames.length == 0
              ? Visibility(
                  visible: !visible,
                  child: LocaleText(
                    text: LocaleKeys.search_search_bar_empty_result.locale,
                    style: AppTextStyles.bodyTextStyle,
                  ),
                )
              : searchListViewBuilder(state, searchList, restaurant),
        );
      } else {
        final error = state as GenericError;
        return Center(child: Text("${error.message}\n${error.statusCode}"));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  GestureDetector buildBody(
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Column(
        children: [
          Spacer(
            flex: 3,
          ),
          searchBar(context),
          // Spacer(
          //   flex: 3,
          // ),
          Visibility(
              visible: visible, child: searchHistoryAndCleanTexts(context)),
          Visibility(visible: visible, child: dividerOne(context)),
          Spacer(flex: 2),
          Container(child: emptySearchHistory()),
          // Visibility(
          //   visible: visible,
          //   child: LocaleText(
          //     text: LocaleKeys.search_search_history_clean,
          //     style: AppTextStyles.bodyTextStyle
          //         .copyWith(color: AppColors.cursorColor),
          //   ),
          // ),
          Visibility(visible: visible, child: Spacer(flex: 2)),
          SingleChildScrollView(child: buildBuilder()),
          isClean
              ? Spacer(flex: 20)
              : Spacer(
                  flex: 50,
                ),
          Visibility(visible: visible, child: popularSearchText(context)),
          Visibility(visible: visible, child: dividerSecond(context)),
          Spacer(flex: 2),
          Visibility(visible: visible, child: horizontalListTrend(context)),
          isClean
              ? Spacer(flex: 20)
              : Spacer(
                  flex: 10,
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
      padding: scroolCategoriesLeft == true
          ? EdgeInsets.only(
              left: 26,
              right: 0,
            )
          : scroolCategoriesRight == true
              ? EdgeInsets.only(
                  left: 0,
                  right: 26,
                )
              : EdgeInsets.only(),
      child: Container(
          height: context.dynamicHeight(0.19),
          child: Builder(builder: (context) {
            final categoryPadding = context.watch<CategoryPaddingCubit>().state;
            return NotificationListener<ScrollUpdateNotification>(
                onNotification: (ScrollUpdateNotification notification) {
                  setState(() {
                    if (notification.metrics.pixels <= 0) {
                      scroolCategoriesLeft = true;
                    } else {
                      scroolCategoriesLeft = false;
                    }
                    if (notification.metrics.pixels >= categoryPadding) {
                      scroolCategoriesRight = true;
                    } else {
                      scroolCategoriesRight = false;
                    }
                  });

                  return true;
                },
                child: CustomHorizontalListCategory());
          })),
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
        right: context.dynamicWidht(0.65),
      ),
      child: LocaleText(
        text: LocaleKeys.search_text4,
        style: AppTextStyles.bodyTitleStyle,
      ),
    );
  }

  Padding horizontalListTrend(BuildContext context) {
    return Padding(
      padding: scroolTrendLeft == true
          ? EdgeInsets.only(
              left: 26,
              right: 0,
            )
          : scroolTrendRight == true
              ? EdgeInsets.only(
                  left: 0,
                  right: 26,
                )
              : EdgeInsets.only(),
      child: Container(
          height: context.dynamicHeight(0.04),
          child: NotificationListener<ScrollUpdateNotification>(
              onNotification: (ScrollUpdateNotification notification) {
                setState(() {
                  if (notification.metrics.pixels <= 0) {
                    scroolTrendLeft = true;
                  } else {
                    scroolTrendLeft = false;
                  }
                  if (notification.metrics.pixels >= 79.5) {
                    scroolTrendRight = true;
                  } else {
                    scroolTrendRight = false;
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
        right: context.dynamicWidht(0.51),
      ),
      child: LocaleText(
        text: LocaleKeys.search_text3,
        style: AppTextStyles.bodyTitleStyle,
      ),
    );
  }

  ListView searchListViewBuilder(GenericState state,
      List<SearchStore> searchList, List<SearchStore> restaurant) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: searchList.isEmpty ||
                controller!.text.isEmpty ||
                filteredNames.isEmpty
            ? 0
            : searchList.length,
        itemBuilder: (context, index) {
          List<String> meals = [];

          if (filteredNames[index].storeMeals == null) {
            print("buradayımm");
            return Text("Aradığınız isimde bir yemek bulunmamaktadır.");
          } else if (filteredNames[index].storeMeals != null) {
            for (var i = 0; i < filteredNames[index].storeMeals!.length; i++) {
              meals.add(filteredNames[index].storeMeals![i].name!);
            }
            mealNames = meals.join(', ');
          }

          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.dynamicWidht(0.06),
              // vertical: context.dynamicHeight(0.00006)
            ),
            decoration: BoxDecoration(color: Colors.white),
            child: ListTile(
              trailing: SvgPicture.asset(ImageConstant.COMMONS_FORWARD_ICON),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RouteConstant.RESTAURANT_DETAIL,
                  arguments: ScreenArgumentsRestaurantDetail(
                    restaurant: restaurant[index],
                  ),
                );
              },
              title: Text(searchList.isEmpty ||
                      filteredNames.isEmpty ||
                      "${filteredNames[index].name}".isEmpty
                  ? ""
                  : "${filteredNames[index].name}"),
              subtitle: Text(searchList.isEmpty ||
                      filteredNames.isEmpty ||
                      mealNames.isEmpty
                  ? ""
                  : mealNames),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LocaleText(
            text: SharedPrefs.getIsLogined
                ? LocaleKeys.search_text1
                : LocaleKeys.search_text3,
            style: AppTextStyles.bodyTitleStyle,
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              setState(() {
                filteredNames.clear();
                filteredNames.remove(names.length);
                names.remove(filteredNames.length);
                names.clear();
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
              visible ? context.dynamicWidht(0.88) : context.dynamicWidht(0.68),
          onTap: () {
            setState(() {
              visible = !visible;
            });
          },
          onChanged: (value) {
            context.read<SearchStoreCubit>().getSearches(controller!.text);
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
    if (filteredNames.length == 0) {
      return Text(
        LocaleKeys.search_search_history_clean.locale,
        style: AppTextStyles.bodyTextStyle,
      );
    } else {
      return Container();
    }
  }
  // return Container(
  //   height: context.dynamicHeight(0.05),
  //   width: double.infinity,
  //   child: Padding(
  //     padding: const EdgeInsets.only(left: 25),
  //     child: LocaleText(
  //         text: LocaleKeys.search_search_history_clean,
  //         style: AppTextStyles.bodyTextStyle
  //             .copyWith(color: AppColors.cursorColor)),
  //   ),
  // );

  // Widget buildSearch(GenericState state, List<Search> searchList) => ListTile(
  //       // leading: Image.network(
  //       //   searches.urlImage,
  //       //   fit: BoxFit.cover,
  //       //   width: 50,
  //       //   height: 50,
  //       // ),
  //       title: Text("${filteredNames[index].name}"),
  //       subtitle: Text("${filteredNames[index].storeMeals![index].name}"),
  //     );
}
