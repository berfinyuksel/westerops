import 'package:dongu_mobile/logic/cubits/padding_values_cubit/category_padding_values_cubit.dart';
import 'package:dongu_mobile/presentation/widgets/circular_progress_indicator/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/category_name.dart';
import '../../../../logic/cubits/category_name_cubit/category_name_cubit.dart';
import '../../../../logic/cubits/generic_state/generic_state.dart';
import '../../../../utils/constants/route_constant.dart';
import '../../../../utils/extensions/context_extension.dart';
import '../../categories_view/screen_arguments_categories/screen_arguments_categories.dart';
import '../../home_page_view/components/category_item.dart';

class CustomHorizontalListCategory extends StatefulWidget {
  const CustomHorizontalListCategory({Key? key}) : super(key: key);

  @override
  State<CustomHorizontalListCategory> createState() =>
      _CustomHorizontalListCategoryState();
}

class _CustomHorizontalListCategoryState
    extends State<CustomHorizontalListCategory> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryNameCubit>().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final state = context.watch<CategoryNameCubit>().state;
      if (state is GenericInitial) {
        return Container();
      } else if (state is GenericLoading) {
        return Center(child: CustomCircularProgressIndicator());
      } else if (state is GenericCompleted) {
        List<Result> results = [];
        for (int i = 0; i < state.response.length; i++) {
          results.add(state.response[i]);
        }
        int radius = 38;
        double sumOfRadius = 0;

        return ListView.separated(
          itemCount: results.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            sumOfRadius += (radius * 2) + context.dynamicWidht(0.04);
            /*   print(sumOfRadius -
                context.dynamicWidht(1) -
                context.dynamicWidht(0.04) +
                26); */
            if (index + 1 == results.length) {
              context.read<CategoryPaddingCubit>().setPadding(sumOfRadius -
                  context.dynamicWidht(1) -
                  context.dynamicWidht(0.04));
            }
            // print(context.dynamicWidht(0.04));
            print("CATEGORY PHOTO: ${results[index].photo}");
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  RouteConstant.CATEGORIES_VIEW,
                  arguments:
                      ScreenArgumentsCategories(categories: results[index]),
                );
              },
              child: CategoryItem(
                  radius: radius,
                  color: buildColorOfCategoryItem(results[index].color!),
                  imagePath: results[index].photo,
                  categoryName: results[index].name),
            );
          },
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            width: context.dynamicWidht(0.04),
          ),
        );
      } else {
        final error = state as GenericError;
        return Center(child: Text("${error.message}\n${error.statusCode}"));
      }
    });
  }

  buildColorOfCategoryItem(String colorValue) {
    List<String> colorValueList = colorValue.split('#').toList();
    List colorValueTotalList = [];
    colorValueTotalList.add('0xFF');
    colorValueTotalList.add(colorValueList[1]);
    String colorValueFormatted = colorValueTotalList.join('');
    int colorValueFormattedInt = int.tryParse(colorValueFormatted)!;
    return colorValueFormattedInt;
  }
}

/* 
ListView(
      scrollDirection: Axis.horizontal,
      children: [
        CategoryItem(
            imagePath: ImageConstant.FOOD_ICON,
            categoryName: LocaleKeys.search_kind3),
        SizedBox(width: context.dynamicWidht(0.04)),
        CategoryItem(
            imagePath: ImageConstant.DRINK_ICON,
            categoryName: LocaleKeys.search_kind8),
        SizedBox(width: context.dynamicWidht(0.04)),
        CategoryItem(
            imagePath: ImageConstant.VEGAN_ICON,
            categoryName: LocaleKeys.search_kind6),
        SizedBox(width: context.dynamicWidht(0.04)),
        CategoryItem(
            imagePath: ImageConstant.HAMBURGER_ICON,
            categoryName: LocaleKeys.search_kind1),
        SizedBox(width: context.dynamicWidht(0.04)),
        CategoryItem(
            imagePath: ImageConstant.DESSERT_ICON,
            categoryName: LocaleKeys.search_kind9),
        SizedBox(width: context.dynamicWidht(0.04)),
        CategoryItem(
            imagePath: ImageConstant.PIZZA_ICON,
            categoryName: LocaleKeys.search_kind7),
        SizedBox(width: context.dynamicWidht(0.04)),
        CategoryItem(
            imagePath: ImageConstant.CHICKEN_ICON,
            categoryName: LocaleKeys.search_kind5),
        SizedBox(width: context.dynamicWidht(0.04)),
        CategoryItem(
            imagePath: ImageConstant.COFFEE_ICON,
            categoryName: LocaleKeys.search_kind10),
      ],
    );
  
 */

/* 
       List<String>? categoryNameList;
    String? categoryName;
    for (var i = 0; i < categoryNameList!.length; i++) {
      categoryName = categoryNameList[i];
      switch (categoryName) {
        case 'yemek':
          CategoryItem(
              imagePath: ImageConstant.FOOD_ICON,
              categoryName: LocaleKeys.search_kind3);
          SizedBox(width: context.dynamicWidht(0.04));

          break;
        case 'icecek':
          CategoryItem(
              imagePath: ImageConstant.DRINK_ICON,
              categoryName: LocaleKeys.search_kind8);
          SizedBox(width: context.dynamicWidht(0.04));

          break;
        case 'vegan':
          CategoryItem(
              imagePath: ImageConstant.VEGAN_ICON,
              categoryName: LocaleKeys.search_kind6);
          SizedBox(width: context.dynamicWidht(0.04));
          break;
        case 'hamburger':
          CategoryItem(
              imagePath: ImageConstant.VEGAN_ICON,
              categoryName: LocaleKeys.search_kind6);
          SizedBox(width: context.dynamicWidht(0.04));
          break;
        case 'tatli':
          CategoryItem(
              imagePath: ImageConstant.VEGAN_ICON,
              categoryName: LocaleKeys.search_kind6);
          SizedBox(width: context.dynamicWidht(0.04));
          break;
        case 'pizza':
          CategoryItem(
              imagePath: ImageConstant.VEGAN_ICON,
              categoryName: LocaleKeys.search_kind6);
          SizedBox(width: context.dynamicWidht(0.04));
          break;
        case 'tavuk':
          CategoryItem(
              imagePath: ImageConstant.VEGAN_ICON,
              categoryName: LocaleKeys.search_kind6);
          SizedBox(width: context.dynamicWidht(0.04));
          break;
        case 'kahve':
          CategoryItem(
              imagePath: ImageConstant.VEGAN_ICON,
              categoryName: LocaleKeys.search_kind6);
          SizedBox(width: context.dynamicWidht(0.04));
          break;
      }
    } */