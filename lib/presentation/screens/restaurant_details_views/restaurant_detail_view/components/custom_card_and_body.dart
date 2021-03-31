import 'package:dongu_mobile/presentation/widgets/button/custom_button.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dongu_mobile/utils/extensions/string_extension.dart';

import 'custom_circular_progress.dart';

class CustomCardAndBody extends StatefulWidget {
  final Image? restaurantLogo;
  const CustomCardAndBody({Key? key, this.restaurantLogo}) : super(key: key);

  @override
  _CustomCardAndBodyState createState() => _CustomCardAndBodyState();
}

class _CustomCardAndBodyState extends State<CustomCardAndBody>
    with SingleTickerProviderStateMixin {
  TabController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        customCard(context),
        customBody(context)
      ],
    );
  }

  Container customCard(BuildContext context) {
    return Container(
        //0.86 372.0 & 0.23 214
        width: context.dynamicWidht(0.86),
        height: context.dynamicHeight(0.23),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(18.0),
            bottom: Radius.circular(8.0),
          ),
          color: Colors.white,
        ),
        child: customCardTabView(context),
      );
  }

  Column customCardTabView(BuildContext context) {
    return Column(
          children: [
            tabBar(context),
            Divider(
              thickness: 2,
              color: AppColors.borderAndDividerColor,
            ),
            Container(
              child: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(flex: 1),
                    restaurantLogoContainer(context),
                    Spacer(flex: 1),
                    restaurantTitleAndAddressColumn(),
                    Spacer(flex: 2),
                    restaurantStarIconRating(),
                    Spacer(flex: 1),
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 2,
              color: AppColors.borderAndDividerColor,
            ),
            Container(
              child: Expanded(
                child: TabBarView(controller: _controller, children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      clockContainer(context),
                      packageContainer(context),
                      oldPriceText(),
                      newPriceText(context),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      serviceRatingRow(context),
                      qualityRatingRow(context),
                      foodRatingRow(context),
                    ],
                  ),
                ]),
              ),
            ),
          ], //56
        );
  }

  Container customBody(BuildContext context) {
    return Container(
        height: context.dynamicHeight(0.5),
        child: TabBarView(controller: _controller, children: [
          tabPackages(context),
          tabDetail(context)
        ]),
      );
  }

  Column tabDetail(BuildContext context) {
    return Column(
            children: [
              SizedBox(
                height: context.dynamicHeight(0.02),
              ),
              Container(
                color: AppColors.appBarColor,
                width: context.dynamicWidht(1),
                height: context.dynamicHeight(0.065),
                padding: EdgeInsets.symmetric(
                    horizontal: context.dynamicWidht(0.065)),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.only(bottom: context.dynamicHeight(0.028)),
                  title: LocaleText(
                    text: LocaleKeys.restaurant_detail_tab_title1,
                    style: AppTextStyles.subTitleStyle,
                  ),
                  subtitle: LocaleText(
                    text: "18:00-21:00",
                    style: AppTextStyles.myInformationBodyTextStyle,
                  ),
                  //trailing: SvgPicture.asset(ImageConstant.COMMONS_FORWARD_ICON),
                ),
              ),
              Container(
                color: AppColors.appBarColor,
                width: context.dynamicWidht(1),
                height: context.dynamicHeight(0.065),
                padding: EdgeInsets.symmetric(
                    horizontal: context.dynamicWidht(0.065)),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.only(bottom: context.dynamicHeight(0.028)),
                  title: LocaleText(
                    text: LocaleKeys.restaurant_detail_tab_title2,
                    style: AppTextStyles.subTitleStyle,
                  ),
                  subtitle: LocaleText(
                    text: LocaleKeys.restaurant_detail_tab_sub_title1,
                    style: AppTextStyles.myInformationBodyTextStyle,
                  ),
                  //trailing: SvgPicture.asset(ImageConstant.COMMONS_FORWARD_ICON),
                ),
              ),
              Container(
                color: AppColors.appBarColor,
                width: context.dynamicWidht(1),
                height: context.dynamicHeight(0.065),
                padding: EdgeInsets.symmetric(
                    horizontal: context.dynamicWidht(0.065)),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.only(bottom: context.dynamicHeight(0.028)),
                  title: LocaleText(
                    text: LocaleKeys.restaurant_detail_tab_title3,
                    style: AppTextStyles.subTitleStyle,
                  ),
                  subtitle: LocaleText(
                    text: LocaleKeys.restaurant_detail_tab_sub_title2,
                    style: AppTextStyles.myInformationBodyTextStyle,
                  ),
                  trailing:
                      SvgPicture.asset(ImageConstant.COMMONS_FORWARD_ICON),
                ),
              ),
              Container(
                color: AppColors.appBarColor,
                width: context.dynamicWidht(1),
                height: context.dynamicHeight(0.065),
                padding: EdgeInsets.symmetric(
                    horizontal: context.dynamicWidht(0.065)),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.only(bottom: context.dynamicHeight(0.028)),
                  title: LocaleText(
                    text: LocaleKeys.restaurant_detail_tab_title4,
                    style: AppTextStyles.subTitleStyle,
                  ),
                  subtitle: LocaleText(
                    text: LocaleKeys.restaurant_detail_tab_sub_title3,
                    style: AppTextStyles.myInformationBodyTextStyle,
                  ),
                  //trailing: SvgPicture.asset(ImageConstant.COMMONS_FORWARD_ICON),
                ),
              ),
              Container(
                color: AppColors.appBarColor,
                width: context.dynamicWidht(1),
                height: context.dynamicHeight(0.065),
                padding: EdgeInsets.symmetric(
                    horizontal: context.dynamicWidht(0.065)),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.only(bottom: context.dynamicHeight(0.028)),
                  title: LocaleText(
                    text: LocaleKeys.restaurant_detail_tab_title5,
                    style: AppTextStyles.subTitleStyle,
                  ),
                  subtitle: LocaleText(
                    text: LocaleKeys.restaurant_detail_tab_sub_title4,
                    style: AppTextStyles.myInformationBodyTextStyle,
                  ),
                  trailing:
                      SvgPicture.asset(ImageConstant.COMMONS_FORWARD_ICON),
                ),
              ),
              Container(
                color: AppColors.appBarColor,
                width: context.dynamicWidht(1),
                height: context.dynamicHeight(0.065),
                padding: EdgeInsets.symmetric(
                    horizontal: context.dynamicWidht(0.065)),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.only(bottom: context.dynamicHeight(0.028)),
                  title: LocaleText(
                    text: LocaleKeys.restaurant_detail_tab_title6,
                    style: AppTextStyles.subTitleStyle,
                  ),
                  subtitle: LocaleText(
                    text: LocaleKeys.restaurant_detail_tab_sub_title5,
                    style: AppTextStyles.myInformationBodyTextStyle,
                  ),
                  trailing:
                      SvgPicture.asset(ImageConstant.COMMONS_FORWARD_ICON),
                ),
              ),
            ],
          );
  }

  ListView tabPackages(BuildContext context) {
    return ListView(
            children: [
              SizedBox(
                height: context.dynamicHeight(0.021),
              ),
              packageCourierAndFavoriteContainer(context),
              SizedBox(
                height: context.dynamicHeight(0.04),
              ),
              //spacer 4
              Padding(
                padding: EdgeInsets.only(left: context.dynamicWidht(0.065)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        LocaleText(
                          text: LocaleKeys.restaurant_detail_sub_title1,
                          style: AppTextStyles.bodyTitleStyle,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        SvgPicture.asset(ImageConstant.RESTAURANT_INFO_ICON),
                      ],
                    ),
                    Divider(
                      thickness: 5,
                      color: AppColors.borderAndDividerColor,
                    )
                  ],
                ),
              ),
              // Group: Group 28572
              Container(
                  //alignment: Alignment(-0.8, 0.0),
                  width: context.dynamicWidht(1),
                  height: context.dynamicHeight(0.060),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      LocaleText(
                        text: LocaleKeys.restaurant_detail_sub_text1,
                        style: AppTextStyles.myInformationBodyTextStyle,
                      ),
                      LocaleText(
                        text: "09:00:20",
                      ),
                      CustomButton(
                        title: LocaleKeys.restaurant_detail_button_text,
                        color: AppColors.greenColor,
                        textColor: AppColors.appBarColor,
                        width: context.dynamicWidht(0.28),
                        borderColor: AppColors.greenColor,
                        onPressed: () {},
                      )
                    ],
                  )),
              Container(
                  //alignment: Alignment(-0.8, 0.0),
                  width: context.dynamicWidht(1),
                  height: context.dynamicHeight(0.060),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      LocaleText(
                        text: LocaleKeys.restaurant_detail_sub_text2,
                        style: AppTextStyles.myInformationBodyTextStyle,
                      ),
                      LocaleText(
                        text: "09:00:20",
                      ),
                      CustomButton(
                        title: LocaleKeys.restaurant_detail_button_text,
                        color: AppColors.greenColor,
                        textColor: AppColors.appBarColor,
                        width: context.dynamicWidht(0.28),
                        borderColor: AppColors.greenColor,
                        onPressed: () {},
                      )
                    ],
                  )),
              Container(
                  //alignment: Alignment(-0.8, 0.0),
                  width: context.dynamicWidht(1),
                  height: context.dynamicHeight(0.060),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      LocaleText(
                        text: LocaleKeys.restaurant_detail_sub_text3,
                        style: AppTextStyles.myInformationBodyTextStyle,
                      ),
                      LocaleText(
                        text: "09:00:20",
                      ),
                      CustomButton(
                        title: LocaleKeys.restaurant_detail_button_text,
                        color: AppColors.greenColor,
                        textColor: AppColors.appBarColor,
                        width: context.dynamicWidht(0.28),
                        borderColor: AppColors.greenColor,
                        onPressed: () {},
                      )
                    ],
                  )),
              SizedBox(
                height: context.dynamicHeight(0.04),
              ),
              Padding(
                padding: EdgeInsets.only(left: context.dynamicWidht(0.065)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        LocaleText(
                          text: LocaleKeys.restaurant_detail_sub_title2,
                          style: AppTextStyles.bodyTitleStyle,
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 5,
                      color: AppColors.borderAndDividerColor,
                    )
                  ],
                ),
              ),
              Container(
                  //alignment: Alignment(-0.8, 0.0),
                  width: context.dynamicWidht(1),
                  height: context.dynamicHeight(0.080),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          LocaleText(
                            text: LocaleKeys.restaurant_detail_sub_text4,
                            style: AppTextStyles.myInformationBodyTextStyle,
                          ),
                          LocaleText(
                            text: LocaleKeys.restaurant_detail_sub_text5,
                            style: AppTextStyles.subTitleStyle,
                            maxLines: 2,
                          ),
                        ],
                      ),
                      LocaleText(
                        text: "07:00:20",
                      ),
                      CustomButton(
                        title: LocaleKeys.restaurant_detail_button_text,
                        color: AppColors.greenColor,
                        textColor: AppColors.appBarColor,
                        width: context.dynamicWidht(0.28),
                        borderColor: AppColors.greenColor,
                        onPressed: () {},
                      )
                    ],
                  )),
              SizedBox(
                height: context.dynamicHeight(0.04),
              ),
            ],
          );
  }

  TabBar tabBar(BuildContext context) {
    return TabBar(
        labelPadding:
            EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.1)),
        indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: 3, color: AppColors.orangeColor),
            insets:
                EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.11))),
        labelColor: AppColors.orangeColor,
        labelStyle: AppTextStyles.bodyTitleStyle,
        unselectedLabelColor: AppColors.textColor,
        unselectedLabelStyle: GoogleFonts.montserrat(
          decoration: TextDecoration.none,
          fontSize: 16.0,
          color: AppColors.textColor,
          fontWeight: FontWeight.w300,
          height: 1.5,
        ),
        indicatorColor: AppColors.orangeColor,
        controller: _controller,
        isScrollable: true,
        tabs: [
          Tab(
            text: LocaleKeys.restaurant_detail_text1.locale,
          ),
          Tab(
            text: LocaleKeys.restaurant_detail_text2.locale,
          ),
        ]);
  }

  Row foodRatingRow(BuildContext context) {
    return Row(
      children: [
        LocaleText(
          text: LocaleKeys.restaurant_detail_item3,
          style: AppTextStyles.subTitleStyle,
        ),
        SizedBox(
          width: context.dynamicWidht(0.02),
        ),
        CustomCircularProgress(valueColor: AppColors.cursorColor, ratingText: "4.1",value: 1,)
        /*SvgPicture.asset(ImageConstant.RESTAURANT_FOOD_RATING_ICON),*/
      ],
    );
  }

  Row qualityRatingRow(BuildContext context) {
    return Row(
      children: [
        LocaleText(
          text: LocaleKeys.restaurant_detail_item2,
          style: AppTextStyles.subTitleStyle,
        ),
        SizedBox(
          width: context.dynamicWidht(0.02),
        ),
        CustomCircularProgress(
          valueColor: AppColors.pinkColor,
          ratingText: "4.1",
          value: 1,
        ),
      ],
    );
  }

  Row serviceRatingRow(BuildContext context) {
    return Row(
      children: [
        LocaleText(
          text: LocaleKeys.restaurant_detail_item1,
          style: AppTextStyles.subTitleStyle,
        ),
        SizedBox(
          width: context.dynamicWidht(0.02),
        ),
        CustomCircularProgress(
          value: 1,
          valueColor: AppColors.greenColor,
          ratingText: "4.1",
        ),
      ],
    );
  }

  Container newPriceText(BuildContext context) {
    return Container(
      alignment: Alignment(0.0, -0.11),
      width: context.dynamicWidht(0.16),
      height: context.dynamicHeight(0.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: AppColors.scaffoldBackgroundColor,
      ),
      child: Text(
        "35 TL",
        textAlign: TextAlign.center,
        style: AppTextStyles.bodyBoldTextStyle
            .copyWith(fontWeight: FontWeight.w700, color: AppColors.greenColor),
      ),
    );
  }

  Text oldPriceText() {
    return Text(
      "75 TL",
      style: AppTextStyles.bodyBoldTextStyle.copyWith(
          decoration: TextDecoration.lineThrough,
          color: AppColors.unSelectedpackageDeliveryColor),
    );
  }

  Container packageContainer(BuildContext context) {
    return Container(
      alignment: Alignment(0.0, -0.11),
      width: context.dynamicWidht(0.19),
      height: context.dynamicHeight(0.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: AppColors.pinkColor,
      ),
      child: LocaleText(
        text: LocaleKeys.restaurant_detail_item4,
        style: AppTextStyles.bodyBoldTextStyle.copyWith(color: Colors.white),
        alignment: TextAlign.center,
      ),
    );
  }

  Container clockContainer(BuildContext context) {
    return Container(
      width: context.dynamicWidht(0.29),
      height: context.dynamicHeight(0.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: AppColors.scaffoldBackgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset(ImageConstant.COMMONS_TIME_ICON),
          Text(
            "18:00-21:00",
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyBoldTextStyle
                .copyWith(color: AppColors.yellowColor),
          ),
        ],
      ),
    );
  }

  Row restaurantStarIconRating() {
    return Row(
      children: [
        Container(
          child: SvgPicture.asset(ImageConstant.RESTAURANT_STAR_ICON),
        ),
        Text(
          "4.7",
          style: AppTextStyles.bodyTextStyle,
        )
      ],
    );
  }

  Column restaurantTitleAndAddressColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LocaleText(
          text: LocaleKeys.restaurant_detail_title,
          style: AppTextStyles.appBarTitleStyle
              .copyWith(fontWeight: FontWeight.w600),
        ),
        LocaleText(
            text: LocaleKeys.restaurant_detail_address,
            style: AppTextStyles.subTitleStyle),
      ],
    );
  }

  Container restaurantLogoContainer(BuildContext context) {
    return Container(
      width: context.dynamicWidht(0.22),
      height: context.dynamicHeight(0.2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.white,
        border: Border.all(
          width: 2.0,
          color: AppColors.borderAndDividerColor,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: context.dynamicHeight(0.0053),
          horizontal: context.dynamicHeight(0.0056),
          ),
        child: Image.asset(ImageConstant.RESTAURANT_LOGO),
      )
    );
  }

  Container packageCourierAndFavoriteContainer(BuildContext context) {
    return Container(
      width: context.dynamicWidht(1),
      height: context.dynamicHeight(0.065),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Container(
                width: context.dynamicWidht(0.12),
                height: context.dynamicHeight(0.039),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: AppColors.greenColor,
                ),
                child: Padding(
                  padding: EdgeInsets.all(context.dynamicHeight(0.006)),
                  child: SvgPicture.asset(
                    ImageConstant.RESTAURANT_PACKAGE_ICON,
                  ),
                ),
              ),
              SizedBox(
                width: context.dynamicWidht(0.02),
              ),
              Container(
                width: context.dynamicWidht(0.12),
                height: context.dynamicHeight(0.039),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: AppColors.greenColor,
                ),
                child: Padding(
                  padding: EdgeInsets.all(context.dynamicHeight(0.006)),
                  child: SvgPicture.asset(
                    ImageConstant.RESTAURANT_COURIER_ICON,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              LocaleText(
                text: LocaleKeys.restaurant_detail_text3,
                style: AppTextStyles.bodyTextStyle,
              ),
              SizedBox(
                width: context.dynamicWidht(0.02),
              ),
              SvgPicture.asset(ImageConstant.RESTAURANT_FAVORITE_ICON)
            ],
          )
        ],
      ),
    );
  }
}
