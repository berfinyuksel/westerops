import 'package:dongu_mobile/data/model/category_name.dart';
import 'package:dongu_mobile/logic/cubits/category_name_cubit/category_name_cubit.dart';
import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';
import 'package:dongu_mobile/presentation/widgets/circular_progress_indicator/custom_circular_progress_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              color: Color.fromRGBO(255, 255, 255, 1),
              height: 330.h,
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  Builder(builder: (context) {
                    final stateOfCategories =
                        context.watch<CategoryNameCubit>().state;
                    if (stateOfCategories is CategoryNameInital) {
                      return Container(color: Colors.white);
                    } else if (stateOfCategories is CategoryNameLoading) {
                      return Container(
                          color: Colors.white,
                          child:
                              Center(child: CustomCircularProgressIndicator()));
                    } else if (stateOfCategories is CategoryNameCompleted) {
                      List<Result> categoryInfo = [];
                      for (int i = 0;
                          i < stateOfCategories.response!.length;
                          i++) {
                        categoryInfo.add(stateOfCategories.response![i]);
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
                  Spacer(),
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
            SizedBox(width: 10.h),
            GestureDetector(
                onTap: onTap,
                child:
                    LocaleText(text: text, style: AppTextStyles.bodyTextStyle)),
            Spacer(flex: 35),
          ],
        ),
        SizedBox(height: 15.h),
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
              if (checkValue == "22") {
                state.checkList![8] = !state.checkList![8];
              } else if (checkValue == "22") {
                state.checkList![9] = !state.checkList![9];
              } else if (checkValue == "24") {
                state.checkList![10] = !state.checkList![10];
              } else if (checkValue == "25") {
                state.checkList![11] = !state.checkList![11];
              } else if (checkValue == "14") {
                state.checkList![12] = !state.checkList![12];
              } else if (checkValue == "26") {
                state.checkList![13] = !state.checkList![13];
              } else if (checkValue == "27") {
                state.checkList![14] = !state.checkList![14];
              } else if (checkValue == "28") {
                state.checkList![15] = !state.checkList![15];
              }else if (checkValue == "23") {
             state.checkList![16] = !state.checkList![16];
              }  else {
              
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
          checkboxColor: checkValue == "22"
              ? state.checkList![8]
                  ? AppColors.greenColor
                  : Colors.white
              : checkValue == "22"
                  ? state.checkList![9]
                      ? AppColors.greenColor
                      : Colors.white
                  : checkValue == "24"
                      ? state.checkList![10]
                          ? AppColors.greenColor
                          : Colors.white
                      : checkValue == "25"
                          ? state.checkList![11]
                              ? AppColors.greenColor
                              : Colors.white
                          : checkValue == "14"
                              ? state.checkList![12]
                                  ? AppColors.greenColor
                                  : Colors.white
                              : checkValue == "26"
                                  ? state.checkList![13]
                                      ? AppColors.greenColor
                                      : Colors.white
                                  : checkValue == "27"
                                      ? state.checkList![14]
                                          ? AppColors.greenColor
                                          : Colors.white
                                      : checkValue == "28"
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
