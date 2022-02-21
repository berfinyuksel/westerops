import 'package:dongu_mobile/logic/cubits/filters_cubit/favorites_filter_cubit.dart';
import 'package:dongu_mobile/logic/cubits/filters_cubit/filters_manager_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/shared/shared_prefs.dart';
import '../../../../logic/cubits/filters_cubit/filters_cubit.dart';
import '../../../../utils/locale_keys.g.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/text/locale_text.dart';
import 'custom_checkbox.dart';
import 'custom_expansion_tile.dart';

class SortFilterList extends StatefulWidget {
  const SortFilterList({Key? key}) : super(key: key);

  @override
  _SortFilterListState createState() => _SortFilterListState();
}

class _SortFilterListState extends State<SortFilterList> {
  // List<bool> checkList = [false,false,false];
  bool isShowFavorite = false;

  @override
  Widget build(BuildContext context) {
    //Favorites are tied to the right place. Others depend on the category.
    return Builder(builder: (context) {
      final FiltersState state = context.watch<FiltersCubit>().state;

      return CustomExpansionTile(
          expansionTileBody: Padding(
            padding: EdgeInsets.only(left: 30.w),
            child: Column(
              children: [
                SizedBox(height: 3.h),
                buildRowCheckboxAndText(
                    context, LocaleKeys.filters_sort_item1, "7", () {
                  setState(() {
                    state.checkList![0] = !state.checkList![0];
                  });
                }),
                SizedBox(height: 15.h),
                buildRowCheckboxAndText(
                    context, LocaleKeys.filters_sort_item2, "6", () {

                  setState(() {
                  context.read<FilterFavorites>().filterFavorites(isShowFavorite);

                    isShowFavorite = !isShowFavorite;
                    print(
                        "FILTER FAVORITES STATE: ${context.read<FilterFavorites>().state}");
                    state.checkList![1] = !state.checkList![1];
                  });
                }),
                SizedBox(height: 15.h),
                buildRowCheckboxAndText(
                    context, LocaleKeys.filters_sort_item3, "2", () {
                  setState(() {
                    state.checkList![2] = !state.checkList![2];
                  });
                }),
                SizedBox(height: 15.h),
                buildRowCheckboxAndText(
                    context, LocaleKeys.filters_sort_item4, "4", () {
                  setState(() {
                    state.checkList![3] = !state.checkList![3];
                  });
                }),
                SizedBox(height: 30.h),
              ],
            ),
          ),
          expansionTileTitle: LocaleKeys.filters_sort_title);
    });
  }

  Row buildRowCheckboxAndText(BuildContext context, String text,
      String checkValue, VoidCallback onPressed) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildCheckBox(context, checkValue),
        Spacer(flex: 2),
        GestureDetector(
            onTap: onPressed,
            child: LocaleText(text: text, style: AppTextStyles.bodyTextStyle)),
        Spacer(flex: 35),
      ],
    );
  }

  Row buildFilterFavoritesCheckboxAndText(BuildContext context, String text,
      String checkValue, VoidCallback onPressed) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildFilterFavoritesCheckbox(context, checkValue),
        Spacer(flex: 2),
        GestureDetector(
            onTap: onPressed,
            child: LocaleText(text: text, style: AppTextStyles.bodyTextStyle)),
        Spacer(flex: 35),
      ],
    );
  }

  Builder buildCheckBox(BuildContext context, String checkValue) {
    return Builder(builder: (context) {
      final FiltersState state = context.watch<FiltersCubit>().state;

      return CustomCheckbox(
        onTap: () {
          setState(() {
            context.read<FiltersManagerCubit>().getPackageCategory(checkValue);
            if (checkValue == "7") {
              state.checkList![0] = !state.checkList![0];
              SharedPrefs.setSortByDistance(state.checkList![0]);
            } else if (checkValue == "6") {
              state.checkList![1] = !state.checkList![1];
              SharedPrefs.setMyFavorites(checkValue);

              // if (state.checkList![1] = true) {
              // context.watch<FavoriteCubit>().getFavorite();
              // }
            } else if (checkValue == "2") {
              state.checkList![2] = !state.checkList![2];
              SharedPrefs.setUserRating(checkValue);
            } else {
              state.checkList![3] = !state.checkList![3];
              SharedPrefs.setNewUser(checkValue);
            }
          });
        },
        checkboxColor: checkValue == "7"
            ? state.checkList![0]
                ? AppColors.greenColor
                : Colors.white
            : checkValue == "6"
                ? state.checkList![1]
                    ? AppColors.greenColor
                    : Colors.white
                : checkValue == "2"
                    ? state.checkList![2]
                        ? AppColors.greenColor
                        : Colors.white
                    : state.checkList![3]
                        ? AppColors.greenColor
                        : Colors.white,
      );
    });
  }

  CustomCheckbox buildFilterFavoritesCheckbox(
      BuildContext context, String checkValue) {
        final FiltersState state = context.watch<FiltersCubit>().state;
    return CustomCheckbox(
      onTap: () {
        // final FiltersState state = context.watch<FiltersCubit>().state;
        setState(() {
          // context.read<FiltersManagerCubit>().getPackageCategory(checkValue);
          context.read<FilterFavorites>().filterFavorites(isShowFavorite);
          if (checkValue == "6") {
            isShowFavorite = !isShowFavorite;
state.checkList![1] = !state.checkList![1];
            SharedPrefs.setMyFavorites(checkValue);

            // if (state.checkList![1] = true) {
            // context.watch<FavoriteCubit>().getFavorite();
            // }
          }
        });
      },
      checkboxColor: checkValue == "6"
          ? state.checkList![1] &&  isShowFavorite 
              ? AppColors.greenColor
              : Colors.white
          : Colors.white,
          
    );
  }
}


/**
 * Builder(builder: (context) {
      final FiltersState state = context.watch<FiltersCubit>().state;
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Check(),
          Spacer(flex: 2),
          LocaleText(text: text, style: AppTextStyles.bodyTextStyle),
          Spacer(flex: 35),
        ],
      );
    });
 */