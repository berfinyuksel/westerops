import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../data/model/category_name.dart';
import '../../../../utils/constants/image_constant.dart';
import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/locale_keys.g.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/scaffold/custom_scaffold.dart';
import '../../../widgets/text/locale_text.dart';
import '../../home_page_view/components/category_item.dart';

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
      isNavBar: false,
      title: LocaleKeys.restaurant_detail_food_categories_title,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 20.h,
                left: 26.w,
                right: 26.w,
              ),
              child: widget.categories!.isNotEmpty
                  ? GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: context.dynamicWidht(0.07) /
                            context.dynamicHeight(0.065),
                        crossAxisSpacing: 20.w,
                        mainAxisSpacing: 30.h,
                      ),
                      itemCount: widget.categories!.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          // onTap: () {
                          //   Navigator.of(context).pushNamed(
                          //     RouteConstant.CATEGORIES_VIEW,
                          //     arguments: ScreenArgumentsCategories(
                          //         categories: widget.categories![index]),
                          //   );
                          // },
                          child: CategoryItem(
                            radius: 38,
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
                            height: 40.h,
                          ),
                          SvgPicture.asset(ImageConstant.SURPRISE_PACK_ALERT),
                          SizedBox(
                            height: 20.h,
                          ),
                          LocaleText(
                            alignment: TextAlign.center,
                            text: LocaleKeys
                                .restaurant_detail_food_categories_text,
                            style: AppTextStyles.myInformationBodyTextStyle,
                          ),
                        ],
                      ),
                    ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 26.w),
                  child: LocaleText(
                    text: LocaleKeys.restaurant_food_categories_text1,
                    style: AppTextStyles.bodyTitleStyle,
                    alignment: TextAlign.start,
                    maxLines: 1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 26.w),
                  child: Divider(
                    thickness: 5,
                    color: AppColors.borderAndDividerColor,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
                width: double.infinity,
                height: 60.h,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(top: 18.w, left: 26.w),
                  child: LocaleText(
                    text: LocaleKeys.restaurant_food_categories_text3,
                    style: AppTextStyles.bodyTextStyle,
                  ),
                )),
            SizedBox(
              height: 30.h,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 26.w, right: 300.w),
                  child: LocaleText(
                    text: LocaleKeys.restaurant_food_categories_text2,
                    style: AppTextStyles.bodyTitleStyle,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 26.w),
                  child: Divider(
                    thickness: 5,
                    color: AppColors.borderAndDividerColor,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
                width: double.infinity,
                height: 80.h,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(top: 20.h, left: 26.w, right: 26.w),
                  child: LocaleText(
                    text: LocaleKeys.restaurant_food_categories_text4,
                    style: AppTextStyles.bodyTextStyle,
                    maxLines: 3,
                  ),
                )),
          ],
        ),
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