import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/cubits/filters_cubit/filters_cubit.dart';
import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/locale_keys.g.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/text/locale_text.dart';
import 'custom_checkbox.dart';
import 'custom_expansion_tile.dart';

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
    return Builder(builder: (context) {
      final FiltersState state = context.watch<FiltersCubit>().state;

      return CustomExpansionTile(
          expansionTileBody: Padding(
            padding: EdgeInsets.only(left: context.dynamicWidht(0.074)),
            child: Container(
              height: context.dynamicHeight(0.37),
              child: Column(
                children: [
                  SizedBox(height: context.dynamicHeight(0.01)),
                  buildRowCheckboxAndText(
                      context, LocaleKeys.filters_choose_category_item9, "All", (){
                        setState(() {
                            state.checkList![16] = !state.checkList![16];
                      state.checkList![10] = !state.checkList![10];
                      state.checkList![11] = !state.checkList![11];
                      state.checkList![12] = !state.checkList![12];
                      state.checkList![13] = !state.checkList![13];
                      state.checkList![14] = !state.checkList![14];
                      state.checkList![15] = !state.checkList![15];
                      state.checkList![9] = !state.checkList![9];
                      state.checkList![8] = !state.checkList![8];
                        });
                      }),
                  SizedBox(height: context.dynamicHeight(0.016)),
                  buildRowCheckboxAndText(
                    context,
                    LocaleKeys.filters_choose_category_item1,
                    "Main Course",(){
                      setState(() {
                state.checkList![8] = !state.checkList![8];
                        
                      });
                    },
                  ),
                  SizedBox(height: context.dynamicHeight(0.016)),
                  buildRowCheckboxAndText(
                    context,
                    LocaleKeys.filters_choose_category_item2,
                    "Drinks",(){
                      setState(() {
                state.checkList![9] = !state.checkList![9];
                        
                      });
                    }
                  ),
                  SizedBox(height: context.dynamicHeight(0.016)),
                  buildRowCheckboxAndText(
                    context,
                    LocaleKeys.filters_choose_category_item3,
                    "Vegan",(){
                      setState(() {
                state.checkList![10] = !state.checkList![10];
                        
                      });
                    }
                  ),
                  SizedBox(height: context.dynamicHeight(0.016)),
                  buildRowCheckboxAndText(
                    context,
                    LocaleKeys.filters_choose_category_item4,
                    "Hamburger",(){
                      setState(() {
                state.checkList![11] = !state.checkList![11];
                        
                      });
                    }
                  ),
                  SizedBox(height: context.dynamicHeight(0.016)),
                  buildRowCheckboxAndText(
                    context,
                    LocaleKeys.filters_choose_category_item5,
                    "Dessert",(){
                      setState(() {
                state.checkList![12] = !state.checkList![12];
                        
                      });
                    }
                  ),
                  SizedBox(height: context.dynamicHeight(0.016)),
                  buildRowCheckboxAndText(
                    context,
                    LocaleKeys.filters_choose_category_item6,
                    "Pizza",(){
                      setState(() {
                state.checkList![13] = !state.checkList![13];
                        
                      });
                    }
                  ),
                  SizedBox(height: context.dynamicHeight(0.016)),
                  buildRowCheckboxAndText(
                    context,
                    LocaleKeys.filters_choose_category_item7,
                    "Chicken",(){
                      setState(() {
                state.checkList![14] = !state.checkList![14];
                        
                      });
                    }
                  ),
                  SizedBox(height: context.dynamicHeight(0.016)),
                  buildRowCheckboxAndText(
                    context,
                    LocaleKeys.filters_choose_category_item8,
                    "Coffee",(){
                      setState(() {
                state.checkList![15] = !state.checkList![15];
                        
                      });
                    }
                  ),
                  //  SizedBox(height: context.dynamicHeight(0.030)),
                ],
              ),
            ),
          ),
          expansionTileTitle: LocaleKeys.filters_choose_category_title);
    });
  }

  Row buildRowCheckboxAndText(BuildContext context, String text,
      String checkValue, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildCheckBox(context, checkValue),
        Spacer(flex: 2),
        GestureDetector(
            onTap: onTap,
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
              if (checkValue == "Main Course") {
                state.checkList![8] = !state.checkList![8];
              } else if (checkValue == "Drinks") {
                state.checkList![9] = !state.checkList![9];
              } else if (checkValue == "Vegan") {
                state.checkList![10] = !state.checkList![10];
              } else if (checkValue == "Hamburger") {
                state.checkList![11] = !state.checkList![11];
              } else if (checkValue == "Dessert") {
                state.checkList![12] = !state.checkList![12];
              } else if (checkValue == "Pizza") {
                state.checkList![13] = !state.checkList![13];
              } else if (checkValue == "Chicken") {
                state.checkList![14] = !state.checkList![14];
              } else if (checkValue == "Coffee") {
                state.checkList![15] = !state.checkList![15];
              } else {
                state.checkList![16] = !state.checkList![16];
                state.checkList![10] = !state.checkList![10];
                state.checkList![11] = !state.checkList![11];
                state.checkList![12] = !state.checkList![12];
                state.checkList![13] = !state.checkList![13];
                state.checkList![14] = !state.checkList![14];
                state.checkList![15] = !state.checkList![15];
                state.checkList![9] = !state.checkList![9];
                state.checkList![8] = !state.checkList![8];
              }
            });
          },
          checkboxColor: checkValue == "Main Course"
              ? state.checkList![8]
                  ? AppColors.greenColor
                  : Colors.white
              : checkValue == "Drinks"
                  ? state.checkList![9]
                      ? AppColors.greenColor
                      : Colors.white
                  : checkValue == "Vegan"
                      ? state.checkList![10]
                          ? AppColors.greenColor
                          : Colors.white
                      : checkValue == "Hamburger"
                          ? state.checkList![11]
                              ? AppColors.greenColor
                              : Colors.white
                          : checkValue == "Dessert"
                              ? state.checkList![12]
                                  ? AppColors.greenColor
                                  : Colors.white
                              : checkValue == "Pizza"
                                  ? state.checkList![13]
                                      ? AppColors.greenColor
                                      : Colors.white
                                  : checkValue == "Chicken"
                                      ? state.checkList![14]
                                          ? AppColors.greenColor
                                          : Colors.white
                                      : checkValue == "Coffee"
                                          ? state.checkList![15]
                                              ? AppColors.greenColor
                                              : Colors.white
                                          : state.checkList![16]
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
