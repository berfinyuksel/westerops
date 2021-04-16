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
                  context, LocaleKeys.filters_choose_category_item9, "All"),
              SizedBox(height: context.dynamicHeight(0.016)),
              buildRowCheckboxAndText(
                context,
                LocaleKeys.filters_choose_category_item1,
                "Main Course",
              ),
              SizedBox(height: context.dynamicHeight(0.016)),
              buildRowCheckboxAndText(
                context,
                LocaleKeys.filters_choose_category_item2,
                "Drinks",
              ),
              SizedBox(height: context.dynamicHeight(0.016)),
              buildRowCheckboxAndText(
                context,
                LocaleKeys.filters_choose_category_item3,
                "Vegan",
              ),
              SizedBox(height: context.dynamicHeight(0.016)),
              buildRowCheckboxAndText(
                context,
                LocaleKeys.filters_choose_category_item4,
                "Hamburger",
              ),
              SizedBox(height: context.dynamicHeight(0.016)),
              buildRowCheckboxAndText(
                context,
                LocaleKeys.filters_choose_category_item5,
                "Dessert",
              ),
              SizedBox(height: context.dynamicHeight(0.016)),
              buildRowCheckboxAndText(
                context,
                LocaleKeys.filters_choose_category_item6,
                "Pizza",
              ),
              SizedBox(height: context.dynamicHeight(0.016)),
              buildRowCheckboxAndText(
                context,
                LocaleKeys.filters_choose_category_item7,
                "Chicken",
              ),
              SizedBox(height: context.dynamicHeight(0.016)),
              buildRowCheckboxAndText(
                context,
                LocaleKeys.filters_choose_category_item8,
                "Coffee",
              ),
              SizedBox(height: context.dynamicHeight(0.030)),
            ],
          ),
        ),
        expansionTileTitle: LocaleKeys.filters_choose_category_title);
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
              if (checkValue == "Main Course") {
                context.read<FiltersCubit>().setIsCheckboxMainCourse(
                    !state.checkboxMainCourse!);
              } 
              else if (checkValue == "Drinks") {
                context
                    .read<FiltersCubit>()
                    .setIsCheckboxDrinks(!state.checkboxDrinks!);
              } 
              else if (checkValue == "Vegan") {
                context
                    .read<FiltersCubit>()
                    .setIsCheckboxVegan(!state.checkboxVegan!);
              } 
              else if (checkValue == "Hamburger") {
                context.read<FiltersCubit>().setIsCheckboxHamburger(
                    !state.checkboxHamburger!);
              } 
              else if (checkValue == "Dessert") {
                context
                    .read<FiltersCubit>()
                    .setIsCheckboxDessert(!state.checkboxDessert!);
              } 
              else if (checkValue == "Pizza") {
                context
                    .read<FiltersCubit>()
                    .setIsCheckboxPizza(!state.checkboxPizza!);
              }
               else if (checkValue == "Chicken") {
                context
                    .read<FiltersCubit>()
                    .setIsCheckboxChicken(!state.checkboxChicken!);
              } 
              else if (checkValue == "Coffee") {
                context
                    .read<FiltersCubit>()
                    .setIsCheckboxCoffe(!state.checkboxCoffe!);
              } else {
                context
                    .read<FiltersCubit>()
                    .setIsCheckboxSelectAll(!state.checkboxSelectAll!);
                      context
                    .read<FiltersCubit>()
                    .setIsCheckboxMainCourse(true);
                     context
                    .read<FiltersCubit>()
                    .setIsCheckboxDrinks(true);
                    context
                    .read<FiltersCubit>()
                    .setIsCheckboxVegan(true);
                     context
                    .read<FiltersCubit>()
                    .setIsCheckboxHamburger(true);
                     context
                    .read<FiltersCubit>()
                    .setIsCheckboxDessert(true);
                    context
                    .read<FiltersCubit>()
                    .setIsCheckboxPizza(true);
                     context
                    .read<FiltersCubit>()
                    .setIsCheckboxChicken(true);
                     context
                    .read<FiltersCubit>()
                    .setIsCheckboxCoffe(true);
              }
            });
          },
          checkboxColor: checkValue == "Main Course"
              ? state.checkboxMainCourse!
                  ? AppColors.greenColor
                  : Colors.white
              : checkValue == "Drinks"
                  ? state.checkboxDrinks!
                      ? AppColors.greenColor
                      : Colors.white
                  : checkValue == "Vegan"
                      ? state.checkboxVegan!
                          ? AppColors.greenColor
                          : Colors.white
                      : checkValue == "Hamburger"
                          ? state.checkboxHamburger!
                              ? AppColors.greenColor
                              : Colors.white
                          : checkValue == "Dessert"
                              ? state.checkboxDessert!
                                  ? AppColors.greenColor
                                  : Colors.white
                              : checkValue == "Pizza"
                                  ? state.checkboxPizza!
                                      ? AppColors.greenColor
                                      : Colors.white
                                  : checkValue == "Chicken"
                                      ? state.checkboxChicken!
                                          ? AppColors.greenColor
                                          : Colors.white
                                      : checkValue == "Coffee"
                                          ? state.checkboxCoffe!
                                              ? AppColors.greenColor
                                              : Colors.white
                                          : state.checkboxSelectAll!
                                              ? AppColors.greenColor
                                              : Colors.white);
    });
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
