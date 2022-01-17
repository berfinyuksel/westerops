import 'package:dongu_mobile/logic/cubits/filters_cubit/filters_manager_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/shared/shared_prefs.dart';
import '../../../../logic/cubits/filters_cubit/filters_cubit.dart';
import '../../../../utils/extensions/context_extension.dart';
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final FiltersState state = context.watch<FiltersCubit>().state;

      return CustomExpansionTile(
          expansionTileBody: Padding(
            padding: EdgeInsets.only(left: context.dynamicWidht(0.074)),
            child: Column(
              children: [
                SizedBox(height: context.dynamicHeight(0.01)),
                buildRowCheckboxAndText(
                    context, LocaleKeys.filters_sort_item1, "7",
                    () {
                  setState(() {
                    state.checkList![0] = !state.checkList![0];
                  });
                }),
                SizedBox(height: context.dynamicHeight(0.016)),
                buildRowCheckboxAndText(
                    context, LocaleKeys.filters_sort_item2, "6", () {
                  setState(() {
                    state.checkList![1] = !state.checkList![1];
                  });
                }),
                SizedBox(height: context.dynamicHeight(0.016)),
                buildRowCheckboxAndText(
                    context, LocaleKeys.filters_sort_item3, "2", () {
                  setState(() {
                    state.checkList![2] = !state.checkList![2];
                  });
                }),
                SizedBox(height: context.dynamicHeight(0.016)),
                buildRowCheckboxAndText(
                    context, LocaleKeys.filters_sort_item4, "4", () {
                  setState(() {
                    state.checkList![3] = !state.checkList![3];
                  });
                }),
                SizedBox(height: context.dynamicHeight(0.030)),
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