import 'package:dongu_mobile/data/model/category_name.dart';
import 'package:dongu_mobile/logic/cubits/category_name_cubit/category_name_cubit.dart';
import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';
import 'package:dongu_mobile/presentation/widgets/circular_progress_indicator/custom_circular_progress_indicator.dart';

import '../../../../logic/cubits/filters_cubit/filters_manager_cubit.dart';
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
  void initState() {
    context.read<CategoryNameCubit>().getCategories();
    super.initState();
  }

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
                  Builder(builder: (context) {
                    final stateOfCategories =
                        context.watch<CategoryNameCubit>().state;
                    if (stateOfCategories is GenericInitial) {
                      return Container(color: Colors.white);
                    } else if (stateOfCategories is GenericLoading) {
                      return Container(color: Colors.white,child: Center(child: CustomCircularProgressIndicator()));
                    } else if (stateOfCategories is GenericCompleted) {
                      List<Result> categoryInfo = [];
                      for (int i = 0;
                          i < stateOfCategories.response.length;
                          i++) {
                        categoryInfo.add(stateOfCategories.response[i]);
                      }
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: categoryInfo.length,
                          itemBuilder: (BuildContext context, index) {
                            return buildRowCheckboxAndText(
                                context,
                                categoryInfo[index].name!,
                                categoryInfo[index].id.toString(), () {
                              setState(() {
                                state.checkList![index] =
                                    !state.checkList![index];
                              });
                            });
                          });
                    } else {
                      final error = stateOfCategories as GenericError;
                      return Center(
                          child: Text("${error.message}\n${error.statusCode}"));
                    }
                  }),
                  SizedBox(height: context.dynamicHeight(0.030)),
                ],
              ),
            ),
          ),
          expansionTileTitle: LocaleKeys.filters_choose_category_title);
    });
  }

  Column buildRowCheckboxAndText(BuildContext context, String text,
      String checkValue, VoidCallback onTap) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildCheckBox(context, checkValue),
            SizedBox(width: 10),
            GestureDetector(
                onTap: onTap,
                child:
                    LocaleText(text: text, style: AppTextStyles.bodyTextStyle)),
            Spacer(flex: 35),
          ],
        ),
        SizedBox(height: context.dynamicHeight(0.016)),
      ],
    );
  }

  Builder buildCheckBox(BuildContext context, String checkValue) {
    return Builder(builder: (context) {
      final FiltersState state = context.watch<FiltersCubit>().state;
      return CustomCheckbox(
          onTap: () {
            setState(() {
              context
                  .read<FiltersManagerCubit>()
                  .getPackageCategory(checkValue);

              if (checkValue == "7") {
                state.checkList![8] = !state.checkList![8];
              } else if (checkValue == "7") {
                state.checkList![9] = !state.checkList![9];
              } else if (checkValue == "6") {
                state.checkList![10] = !state.checkList![10];
              } else if (checkValue == "4") {
                state.checkList![11] = !state.checkList![11];
              } else if (checkValue == "2") {
                state.checkList![12] = !state.checkList![12];
              } else if (checkValue == "5") {
                state.checkList![13] = !state.checkList![13];
              } else if (checkValue == "7") {
                state.checkList![14] = !state.checkList![14];
              } else if (checkValue == "7") {
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
          checkboxColor: checkValue == "7"
              ? state.checkList![8]
                  ? AppColors.greenColor
                  : Colors.white
              : checkValue == "7"
                  ? state.checkList![9]
                      ? AppColors.greenColor
                      : Colors.white
                  : checkValue == "6"
                      ? state.checkList![10]
                          ? AppColors.greenColor
                          : Colors.white
                      : checkValue == "4"
                          ? state.checkList![11]
                              ? AppColors.greenColor
                              : Colors.white
                          : checkValue == "2"
                              ? state.checkList![12]
                                  ? AppColors.greenColor
                                  : Colors.white
                              : checkValue == "5"
                                  ? state.checkList![13]
                                      ? AppColors.greenColor
                                      : Colors.white
                                  : checkValue == "7"
                                      ? state.checkList![14]
                                          ? AppColors.greenColor
                                          : Colors.white
                                      : checkValue == "7"
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
