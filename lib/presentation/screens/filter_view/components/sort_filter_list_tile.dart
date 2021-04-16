import 'package:dongu_mobile/logic/cubits/filters_cubit/filters_cubit.dart';
import 'package:dongu_mobile/presentation/screens/filter_view/components/custom_expansion_tile.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              buildRowCheckboxAndText(
                  context, LocaleKeys.filters_sort_item1, "Sort by Distance"),
              SizedBox(height: context.dynamicHeight(0.016)),
              buildRowCheckboxAndText(
                  context, LocaleKeys.filters_sort_item2, "Favorites"),
              SizedBox(height: context.dynamicHeight(0.016)),
              buildRowCheckboxAndText(
                  context, LocaleKeys.filters_sort_item3, "User Point"),
              SizedBox(height: context.dynamicHeight(0.016)),
              buildRowCheckboxAndText(
                  context, LocaleKeys.filters_sort_item4, "New Guest"),
              SizedBox(height: context.dynamicHeight(0.030)),
            ],
          ),
        ),
        expansionTileTitle: LocaleKeys.filters_sort_title);
  }

  Row buildRowCheckboxAndText(
      BuildContext context, String text, String checkValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildCheckBox(context, checkValue),
        Spacer(flex: 2),
        LocaleText(text: text, style: AppTextStyles.bodyTextStyle),
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
            if (checkValue == "Sort by Distance") {
              context.read<FiltersCubit>().setIsCheckboxSortByDistanceValue(
                  !state.checkboxSortByDistanceValue!);
            } else if (checkValue == "Favorites") {
              context
                  .read<FiltersCubit>()
                  .setIsCheckboxFavoritesValue(!state.checkboxFavoritesValue!);
            } else if (checkValue == "User Point") {
              context
                  .read<FiltersCubit>()
                  .setIsCheckboxUserPointValue(!state.checkboxUserPointValue!);
            } else {
              context
                  .read<FiltersCubit>()
                  .setIsCheckboxNewGuestValue(!state.checkboxNewGuestValue!);
            }
          });
        },
        checkboxColor: checkValue == "Sort by Distance"
            ? state.checkboxSortByDistanceValue!
                ? AppColors.greenColor
                : Colors.white
            : checkValue == "Favorites"
                ? state.checkboxFavoritesValue!
                    ? AppColors.greenColor
                    : Colors.white
                : checkValue == "User Point"
                    ? state.checkboxUserPointValue!
                        ? AppColors.greenColor
                        : Colors.white
                    : state.checkboxNewGuestValue!
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