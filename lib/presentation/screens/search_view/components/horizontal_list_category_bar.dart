import 'package:dongu_mobile/presentation/screens/home_page_view/components/category_item.dart';
import 'package:flutter/material.dart';
import '../../../../utils/constants/image_constant.dart';
import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/locale_keys.g.dart';

class CustomHorizontalListCategory extends StatelessWidget {
  const CustomHorizontalListCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20),
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
  }
}
