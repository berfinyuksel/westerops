import 'package:dongu_mobile/presentation/widgets/scaffold/custom_scaffold.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/constants/image_constant.dart';
import '../../../utils/constants/route_constant.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/text/locale_text.dart';

class SwipeView extends StatefulWidget {
  @override
  _SwipeViewState createState() => _SwipeViewState();
}

class _SwipeViewState extends State<SwipeView> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Stack(
        children: [
          Container(
            color: AppColors.scaffoldBackgroundColor,
            child: SvgPicture.asset(ImageConstant.ORDER_RECEIVING_BACKGROUND,fit: BoxFit.cover,),
            width: double.infinity,
          ),
          Center(
            child: Column(
              children: [
                Spacer(
                  flex: 7,
                ),
                Text(
                  "Siparişinizi Teslim Alın",
                  style: AppTextStyles.appBarTitleStyle.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.orangeColor),
                ),
                Spacer(
                  flex: 4,
                ),
                Text(
                  "Sipariş Numarası:",
                  style: AppTextStyles.myInformationBodyTextStyle.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "86123345",
                  style: AppTextStyles.headlineStyle,
                ),
                Spacer(
                  flex: 6,
                ),
                infoCard(context),
                Spacer(
                  flex: 30,
                ),
                Dismissible(
                      key: UniqueKey(),
                  direction: DismissDirection.startToEnd,
                  child: Container(
                    //curve: Curve,
                    height: context.dynamicHeight(0.12),
                    width: context.dynamicWidht(0.87),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: AppColors.greenColor,
                      border: Border.all(
                        width: 2.0,
                        color: AppColors.greenColor,
                      ),
                    ),
                    child: TextButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Siparişi tamamlamak için kaydırın",
                                style: AppTextStyles.bodyTitleStyle
                                    .copyWith(color: AppColors.appBarColor)),
                            SizedBox(
                              width: context.dynamicWidht(0.02),
                            ),
                            SvgPicture.asset(
                              ImageConstant.RIGHT_ICON,
                              height: 24,
                              color: AppColors.appBarColor,
                            ),
                            SvgPicture.asset(
                              ImageConstant.RIGHT_ICON,
                              height: 24,
                              color: AppColors.appBarColor,
                            ),
                            // Icon(Icons.keyboard_arrow_right),
                            // Icon(Icons.keyboard_arrow_right),
                          ],
                        )),
                  ),
                ),
                Spacer(
                  flex: 4,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container infoCard(BuildContext context) {
    return Container(
      height: context.dynamicHeight(0.16),
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(
            left: context.dynamicWidht(0.07), top: context.dynamicWidht(0.04)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Anadolu Lezzetleri",
              style: AppTextStyles.myInformationBodyTextStyle
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            Spacer(
              flex: 7,
            ),
            Text("Pastırmalı Kuru Fasulye, 1 porsiyon Kornişon Turşu",
                style: AppTextStyles.subTitleStyle),
            Spacer(
              flex: 40,
            ),
            Padding(
              padding: EdgeInsets.only(right: context.dynamicWidht(0.065)),
              child: Divider(
                height: context.dynamicHeight(0.001),
                thickness: 1,
              ),
            ),
            Spacer(
              flex: 20,
            ),
            Padding(
              padding: EdgeInsets.only(right: context.dynamicWidht(0.065)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Toplam Tutar:",
                    style: AppTextStyles.myInformationBodyTextStyle
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: context.dynamicWidht(0.16),
                    height: context.dynamicHeight(0.04),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: AppColors.scaffoldBackgroundColor,
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: context.dynamicWidht(0.01)),
                      child: Text(
                        '35,25 TL',
                        style: AppTextStyles.bodyBoldTextStyle.copyWith(
                          color: AppColors.greenColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(
              flex: 25,
            ),
          ],
        ),
      ),
    );
  }
}
