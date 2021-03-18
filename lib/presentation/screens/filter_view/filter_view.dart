import 'package:auto_size_text/auto_size_text.dart';
import 'package:dongu_mobile/presentation/screens/filter_view/components/custom_container.dart';
import 'package:dongu_mobile/presentation/widgets/button/custom_button.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dongu_mobile/utils/extensions/string_extension.dart';

import 'components/custom_checkbox.dart';
import 'components/custom_sliderbar_textfield.dart';

class FilterView extends StatelessWidget {
  const FilterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: AppBar(),
      body: Center(
        child: Expanded(
          child: ListView(
            children: [
              sortFilter(context),
              Divider(
                height: 1,
                color: Colors.transparent,
              ),
              packagePriceFilter(),
              Divider(
                height: 1,
                color: Colors.transparent,
              ),
              packageDeliveryFilter(context),
              Divider(
                height: 1,
                color: Colors.transparent,
              ),
              paymentMethodFilter(context),
              Divider(
                height: 1,
                color: Colors.transparent,
              ),
              chooseCategoryFilter(context),
              SizedBox(height: context.dynamicHeight(0.4),),
              cleanAndSaveButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Row cleanAndSaveButtons(BuildContext context) {
    return Row(
              children: [
                Spacer(flex: 25),
                CustomButton(
                  width: context.dynamicWidht(0.4),
                  color: AppColors.appBarColor,
                  borderColor: AppColors.greenColor,
                  title:  LocaleKeys.filters_button_item1.locale,
                  textColor: AppColors.greenColor,
                  onPressed: (){},
                ),
                Spacer(flex: 10),
                CustomButton(
                  width: context.dynamicWidht(0.4),
                  color: AppColors.greenColor,
                  borderColor: AppColors.greenColor,
                  title: LocaleKeys.filters_button_item2.locale,
                  textColor: AppColors.appBarColor,
                  onPressed: (){},
                ),
                Spacer(flex: 25),
              ],
            );
  }

  Container chooseCategoryFilter(BuildContext context) {
    return Container(
            decoration: BoxDecoration(color: Colors.white),
            child: ExpansionTile(
              title: AutoSizeText(
                LocaleKeys.filters_choose_category_title.locale,
                style: AppTextStyles.bodyTitleStyle,
              ),
              //trailing: SvgPicture.asset(ImageConstant.RIGHT_ICON),
              backgroundColor: Colors.white,
              children: [
                Container(
                  width: context.dynamicWidht(0.9),
                  height: context.dynamicHeight(0.4),
                  child: Expanded(
                    child: Column(
                      children: [
                        Spacer(flex: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomCheckbox(),
                            Spacer(flex: 2),
                            AutoSizeText(
                                LocaleKeys
                                    .filters_choose_category_item1.locale,
                                style: AppTextStyles.bodyTextStyle),
                            Spacer(flex: 35),
                          ],
                        ),
                        Spacer(flex: 35),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomCheckbox(),
                            Spacer(flex: 2),
                            AutoSizeText(
                                LocaleKeys
                                    .filters_choose_category_item2.locale,
                                style: AppTextStyles.bodyTextStyle),
                            Spacer(flex: 35),
                          ],
                        ),
                        Spacer(flex: 35),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomCheckbox(),
                            Spacer(flex: 2),
                            AutoSizeText(
                                LocaleKeys
                                    .filters_choose_category_item3.locale,
                                style: AppTextStyles.bodyTextStyle),
                            Spacer(flex: 35),
                          ],
                        ),
                        Spacer(flex: 35),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomCheckbox(),
                            Spacer(flex: 2),
                            AutoSizeText(
                                LocaleKeys
                                    .filters_choose_category_item4.locale,
                                style: AppTextStyles.bodyTextStyle),
                            Spacer(flex: 35),
                          ],
                        ),
                        Spacer(flex: 35),
                          Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomCheckbox(),
                            Spacer(flex: 2),
                            AutoSizeText(
                                LocaleKeys
                                    .filters_choose_category_item5.locale,
                                style: AppTextStyles.bodyTextStyle),
                            Spacer(flex: 35),
                          ],
                        ),
                        Spacer(flex: 35),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomCheckbox(),
                            Spacer(flex: 2),
                            AutoSizeText(
                                LocaleKeys
                                    .filters_choose_category_item6.locale,
                                style: AppTextStyles.bodyTextStyle),
                            Spacer(flex: 35),
                          ],
                        ),
                        Spacer(flex: 35),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomCheckbox(),
                            Spacer(flex: 2),
                            AutoSizeText(
                                LocaleKeys
                                    .filters_choose_category_item7.locale,
                                style: AppTextStyles.bodyTextStyle),
                            Spacer(flex: 35),
                          ],
                        ),
                        Spacer(flex: 35),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomCheckbox(),
                            Spacer(flex: 2),
                            AutoSizeText(
                                LocaleKeys
                                    .filters_choose_category_item8.locale,
                                style: AppTextStyles.bodyTextStyle),
                            Spacer(flex: 35),
                          ],
                        ),
                        Spacer(flex: 70),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
  }

  Container paymentMethodFilter(BuildContext context) {
    return Container(
            decoration: BoxDecoration(color: Colors.white),
            child: ExpansionTile(
              title: AutoSizeText(
                LocaleKeys.filters_payment_method_title.locale,
                style: AppTextStyles.bodyTitleStyle,
              ),
              //trailing: SvgPicture.asset(ImageConstant.RIGHT_ICON),
              backgroundColor: Colors.white,
              children: [
                 Container(
          width: context.dynamicWidht(0.9),
          height: context.dynamicHeight(0.15),
          child: Expanded(
            child: Column(
              children: [
                Spacer(flex: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomCheckbox(),
                    Spacer(flex: 2),
                    AutoSizeText(LocaleKeys.filters_payment_method_item1.locale,
                        style: AppTextStyles.bodyTextStyle
                            .copyWith(fontSize: 13)),
                    Spacer(flex: 35),
                  ],
                ),
                Spacer(flex: 35),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomCheckbox(),
                    Spacer(flex: 4),
                    AutoSizeText(LocaleKeys.filters_payment_method_item2.locale,
                        style: AppTextStyles.bodyTextStyle
                            .copyWith(fontSize: 13)),
                    Spacer(flex: 35),
                  ],
                ),


                Spacer(flex: 70),
              ],
            ),
          ),
        )
              ],
            ),
          );
  }

  Container packageDeliveryFilter(BuildContext context) {
    return Container(
            decoration: BoxDecoration(color: Colors.white),
            child: ExpansionTile(
              title: AutoSizeText(
                LocaleKeys.filters_package_delivery_title.locale,
                style: AppTextStyles.bodyTitleStyle,
              ),
              //trailing: SvgPicture.asset(ImageConstant.RIGHT_ICON),
              backgroundColor: Colors.white,
              children: [
                Container(
                  height: context.dynamicHeight(0.23),
                  child: Expanded(
                    child: Column(
                      children: [
                        Spacer(flex:2),
                        Row(
                          children: [
                            Spacer(flex: 4),
                            CustomCheckbox(),
                            Spacer(flex: 3),
                            CustomContainer(
                              child: Row(
                                children: [
                                  Spacer(flex: 5),
                                  SvgPicture.asset(ImageConstant.PACKAGE_ICON),
                                  Spacer(flex: 13),
                                  Center(
                                      child: AutoSizeText(
                                    LocaleKeys
                                        .filters_package_delivery_item1.locale,
                                    style: AppTextStyles.bodyTextStyle
                                        .copyWith(fontWeight: FontWeight.w600),
                                  )),
                                  Spacer(flex: 24),
                                ],
                              ),
                            ),
                            Spacer(flex: 5),
                          ],
                        ),

                        Spacer(flex: 2),
                        Row(
                          children: [
                            Spacer(flex: 4),
                            CustomCheckbox(),
                            Spacer(flex: 3),
                            CustomContainer(
                              child: Row(
                                children: [
                                  Spacer(flex: 5),
                                  SvgPicture.asset(
                                      ImageConstant.PACKAGE_DELIVERY_ICON,
                                     // cubit --> color:  Colors.red
                                      ),
                                  Spacer(flex: 13),
                                  Center(
                                      child: AutoSizeText(
                                    LocaleKeys
                                        .filters_package_delivery_item2.locale,
                                    style: AppTextStyles.bodyTextStyle
                                        .copyWith(fontWeight: FontWeight.w600),
                                  )),
                                  Spacer(flex: 24),
                                ],
                              ),
                            ),
                            Spacer(flex: 5),
                          ],
                        ),
                        Spacer(flex: 3),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
  }

  Container packagePriceFilter() {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: ExpansionTile(
        title: Text(
          LocaleKeys.filters_package_price_title.locale,
          style: AppTextStyles.bodyTitleStyle,
        ),
        //trailing: SvgPicture.asset(ImageConstant.RIGHT_ICON),
        backgroundColor: Colors.white,
        children: [
          CustomSliderBarAndTextField(),
        ],
      ),
    );
  }

  Container sortFilter(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: ExpansionTile(
        title: AutoSizeText(
          LocaleKeys.filters_sort_title.locale,
          style: AppTextStyles.bodyTitleStyle,
        ),
        //trailing: SvgPicture.asset(ImageConstant.RIGHT_ICON),
        backgroundColor: Colors.white,
        children: [
          Container(
            width: context.dynamicWidht(0.9),
            height: context.dynamicHeight(0.2),
            child: Expanded(
              child: Column(
                children: [
                  Spacer(flex: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomCheckbox(),
                      Spacer(flex: 2),
                      AutoSizeText(LocaleKeys.filters_sort_item1.locale,
                          style: AppTextStyles.bodyTextStyle
                              ),
                      Spacer(flex: 35),
                    ],
                  ),
                  Spacer(flex: 35),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomCheckbox(),
                      Spacer(flex: 2),
                      AutoSizeText(LocaleKeys.filters_sort_item2.locale,
                          style: AppTextStyles.bodyTextStyle
                             
                             ),
                      Spacer(flex: 35),
                    ],
                  ),
                  Spacer(flex: 35),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomCheckbox(),
                      Spacer(flex: 2),
                      AutoSizeText(LocaleKeys.filters_sort_item3.locale,
                          style: AppTextStyles.bodyTextStyle
                             
                              ),
                      Spacer(flex: 35),
                    ],
                  ),
                  Spacer(flex: 35),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomCheckbox(),
                      Spacer(flex: 2),
                      AutoSizeText(LocaleKeys.filters_sort_item4.locale,
                          style: AppTextStyles.bodyTextStyle
                             
                             ),
                      Spacer(flex: 35),
                    ],
                  ),
                  Spacer(flex: 70),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

