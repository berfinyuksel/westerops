import 'package:dongu_mobile/data/model/category_name.dart';
import 'package:dongu_mobile/presentation/screens/categories_view/screen_arguments_categories/screen_arguments_categories.dart';
import 'package:dongu_mobile/presentation/screens/home_page_view/components/category_item.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:googleapis/books/v1.dart';

import '../../../../utils/constants/image_constant.dart';
import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/locale_keys.g.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/scaffold/custom_scaffold.dart';
import '../../../widgets/text/locale_text.dart';

class FoodCategories extends StatefulWidget {
  final List<Result>? categories;
  FoodCategories({Key? key, required this.categories}) : super(key: key);

  @override
  _FoodCategoriesState createState() => _FoodCategoriesState();
}

class _FoodCategoriesState extends State<FoodCategories> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Gıda Kategorileri",
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: context.dynamicWidht(0.04),
                left: context.dynamicWidht(0.07),
                right: context.dynamicWidht(0.07)),
            child: widget.categories!.isNotEmpty
                ? GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: context.dynamicWidht(0.07) /
                          context.dynamicHeight(0.05),
                      crossAxisSpacing: context.dynamicWidht(0.046),
                      mainAxisSpacing: context.dynamicHeight(0.02),
                    ),
                    itemCount: widget.categories!.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            RouteConstant.CATEGORIES_VIEW,
                            arguments: ScreenArgumentsCategories(
                                categories: widget.categories![index]),
                          );
                        },
                        child: CategoryItem(
                          imagePath: widget.categories![index].photo,
                          categoryName: widget.categories![index].name,
                          color: buildColorOfCategoryItem(
                              widget.categories![index].color),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        SvgPicture.asset(ImageConstant.SURPRISE_PACK_ALERT),
                        SizedBox(
                          height: 20,
                        ),
                        LocaleText(
                          alignment: TextAlign.center,
                          text:
                              "Üzgünüz.\nBu restoran için henüz bir kategori bulunmamaktadır.",
                          style: AppTextStyles.myInformationBodyTextStyle,
                        ),
                      ],
                    ),
                  ),
          ),
          SizedBox(
            height: context.dynamicHeight(0.049),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: context.dynamicWidht(0.070),
                  ),
                  LocaleText(
                    text: LocaleKeys.restaurant_food_categories_text1,
                    style: AppTextStyles.bodyTitleStyle,
                    alignment: TextAlign.start,
                    maxLines: 1,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: context.dynamicWidht(0.065)),
                child: Divider(
                  thickness: 5,
                  color: AppColors.borderAndDividerColor,
                ),
              )
            ],
          ),
          SizedBox(
            height: context.dynamicHeight(0.015),
          ),
          Container(
              width: context.dynamicWidht(1),
              height: context.dynamicHeight(0.065),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(
                    top: context.dynamicHeight(0.020),
                    left: context.dynamicWidht(0.065)),
                child: LocaleText(
                  text: LocaleKeys.restaurant_food_categories_text3,
                  style: AppTextStyles.bodyTextStyle,
                ),
              )),
          SizedBox(
            height: context.dynamicHeight(0.04),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    right: context.dynamicWidht(0.65),
                    left: context.dynamicWidht(0.075)),
                child: LocaleText(
                  text: LocaleKeys.restaurant_food_categories_text2,
                  style: AppTextStyles.bodyTitleStyle,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: context.dynamicWidht(0.065)),
                child: Divider(
                  thickness: 5,
                  color: AppColors.borderAndDividerColor,
                ),
              )
            ],
          ),
          SizedBox(
            height: context.dynamicHeight(0.015),
          ),
          Container(
              width: context.dynamicWidht(1),
              height: context.dynamicHeight(0.11),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(
                    top: context.dynamicHeight(0.020),
                    left: context.dynamicWidht(0.065)),
                child: LocaleText(
                  text: LocaleKeys.restaurant_food_categories_text4,
                  style: AppTextStyles.bodyTextStyle,
                  maxLines: 3,
                ),
              )),
        ],
      ),
    );
  }

  buildColorOfCategoryItem(String? color) {
    List<String> colorValueList = color!.split('#').toList();
    List colorValueTotalList = [];
    colorValueTotalList.add('0xFF');
    colorValueTotalList.add(colorValueList[1]);
    String colorValueFormatted = colorValueTotalList.join('');
    int colorValueFormattedInt = int.tryParse(colorValueFormatted)!;
    return colorValueFormattedInt;
  }
}
/* 

Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        SvgPicture.asset(ImageConstant.FOOD_ICON),
                        SizedBox(
                          height: context.dynamicHeight(0.01),
                        ),
                        LocaleText(
                          text: LocaleKeys.search_kind3,
                          style: AppTextStyles.subTitleStyle,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        SvgPicture.asset(ImageConstant.DRINK_ICON),
                        SizedBox(
                          height: context.dynamicHeight(0.01),
                        ),
                        LocaleText(
                          text: LocaleKeys.search_kind8,
                          style: AppTextStyles.subTitleStyle,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        SvgPicture.asset(ImageConstant.VEGAN_ICON),
                        SizedBox(
                          height: context.dynamicHeight(0.01),
                        ),
                        LocaleText(
                          text: LocaleKeys.search_kind6,
                          style: AppTextStyles.subTitleStyle,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        SvgPicture.asset(ImageConstant.HAMBURGER_ICON),
                        SizedBox(
                          height: context.dynamicHeight(0.01),
                        ),
                        LocaleText(
                          text: LocaleKeys.search_kind1,
                          style: AppTextStyles.subTitleStyle,
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: context.dynamicWidht(0.04),
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        SvgPicture.asset(ImageConstant.CHICKEN_ICON),
                        SizedBox(
                          height: context.dynamicHeight(0.01),
                        ),
                        LocaleText(
                          text: LocaleKeys.search_kind5,
                          style: AppTextStyles.subTitleStyle,
                        )
                      ],
                    ),
                    SizedBox(
                      width: context.dynamicWidht(0.04),
                    ),
                    Column(
                      children: [
                        SvgPicture.asset(ImageConstant.DESSERT_ICON),
                        SizedBox(
                          height: context.dynamicHeight(0.01),
                        ),
                        LocaleText(
                          text: LocaleKeys.search_kind9,
                          style: AppTextStyles.subTitleStyle,
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),

             */