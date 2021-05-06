import 'package:dongu_mobile/data/model/box.dart';
import 'package:dongu_mobile/data/model/store.dart';
import 'package:dongu_mobile/logic/cubits/order_cubit/order_cubit.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'custom_circular_progress.dart';

class CustomCardAndBody extends StatefulWidget {
  final Store? restaurant;
  const CustomCardAndBody({Key? key, this.restaurant}) : super(key: key);

  @override
  _CustomCardAndBodyState createState() => _CustomCardAndBodyState();
}

class _CustomCardAndBodyState extends State<CustomCardAndBody> with SingleTickerProviderStateMixin {
  bool _isSelect = false;
  String startTime = '';
  String endTime = '';
  List<Box> definedBoxes = [];

  TabController? _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    startTime = widget.restaurant!.calendar![0].startDate!.split("T")[1];
    endTime = widget.restaurant!.calendar![0].endDate!.split("T")[1];
    startTime = "${startTime.split(":")[0]}:${startTime.split(":")[1]}";
    endTime = "${endTime.split(":")[0]}:${endTime.split(":")[1]}";
    definedBoxes.clear();
    for (int i = 0; i < widget.restaurant!.boxes!.length; i++) {
      if (widget.restaurant!.boxes![i].defined!) {
        definedBoxes.add(widget.restaurant!.boxes![i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [customCard(context), customBody(context)],
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
      child: TabBarView(controller: _controller, children: [tabPackages(context), tabDetail(context)]),
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
          padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.06)),
          child: ListTile(
            contentPadding: EdgeInsets.only(bottom: context.dynamicHeight(0.028)),
            title: LocaleText(
              text: LocaleKeys.restaurant_detail_detail_tab_title1,
              style: AppTextStyles.subTitleStyle,
            ),
            subtitle: LocaleText(
              text: "$startTime-$endTime",
              style: AppTextStyles.myInformationBodyTextStyle,
            ),
            //trailing: SvgPicture.asset(ImageConstant.COMMONS_FORWARD_ICON),
          ),
        ),
        Container(
          color: AppColors.appBarColor,
          width: context.dynamicWidht(1),
          height: context.dynamicHeight(0.065),
          padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.06)),
          child: ListTile(
            contentPadding: EdgeInsets.only(bottom: context.dynamicHeight(0.028)),
            title: LocaleText(
              text: LocaleKeys.restaurant_detail_detail_tab_title1,
              style: AppTextStyles.subTitleStyle,
            ),
            subtitle: LocaleText(
              text: LocaleKeys.restaurant_detail_detail_tab_sub_title1,
              style: AppTextStyles.myInformationBodyTextStyle,
            ),
            //trailing: SvgPicture.asset(ImageConstant.COMMONS_FORWARD_ICON),
          ),
        ),
        Container(
          color: AppColors.appBarColor,
          width: context.dynamicWidht(1),
          height: context.dynamicHeight(0.065),
          padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.065)),
          child: ListTile(
            contentPadding: EdgeInsets.only(bottom: context.dynamicHeight(0.028)),
            title: LocaleText(
              text: LocaleKeys.restaurant_detail_detail_tab_title3,
              style: AppTextStyles.subTitleStyle,
            ),
            subtitle: LocaleText(
              text: LocaleKeys.restaurant_detail_detail_tab_sub_title2,
              style: AppTextStyles.myInformationBodyTextStyle,
            ),
            trailing: SvgPicture.asset(ImageConstant.COMMONS_FORWARD_ICON),
          ),
        ),
        Container(
          color: AppColors.appBarColor,
          width: context.dynamicWidht(1),
          height: context.dynamicHeight(0.065),
          padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.065)),
          child: ListTile(
            contentPadding: EdgeInsets.only(bottom: context.dynamicHeight(0.028)),
            title: LocaleText(
              text: LocaleKeys.restaurant_detail_detail_tab_title4,
              style: AppTextStyles.subTitleStyle,
            ),
            subtitle: LocaleText(
              text: LocaleKeys.restaurant_detail_detail_tab_sub_title3,
              style: AppTextStyles.myInformationBodyTextStyle,
            ),
            //trailing: SvgPicture.asset(ImageConstant.COMMONS_FORWARD_ICON),
          ),
        ),
        Container(
          color: AppColors.appBarColor,
          width: context.dynamicWidht(1),
          height: context.dynamicHeight(0.065),
          padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.06)),
          child: ListTile(
            contentPadding: EdgeInsets.only(bottom: context.dynamicHeight(0.028)),
            title: LocaleText(
              text: LocaleKeys.restaurant_detail_detail_tab_title5,
              style: AppTextStyles.subTitleStyle,
            ),
            subtitle: LocaleText(
              text: LocaleKeys.restaurant_detail_detail_tab_sub_title4,
              style: AppTextStyles.myInformationBodyTextStyle,
            ),
            trailing: SvgPicture.asset(ImageConstant.COMMONS_FORWARD_ICON),
          ),
        ),
        Container(
          color: AppColors.appBarColor,
          width: context.dynamicWidht(1),
          height: context.dynamicHeight(0.065),
          padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.065)),
          child: ListTile(
            contentPadding: EdgeInsets.only(bottom: context.dynamicHeight(0.028)),
            title: LocaleText(
              text: LocaleKeys.restaurant_detail_detail_tab_title6,
              style: AppTextStyles.subTitleStyle,
            ),
            subtitle: LocaleText(
              text: LocaleKeys.restaurant_detail_detail_tab_sub_title5,
              style: AppTextStyles.myInformationBodyTextStyle,
            ),
            trailing: SvgPicture.asset(ImageConstant.COMMONS_FORWARD_ICON),
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
        ListView.builder(
          itemCount: widget.restaurant!.boxes!.length,
          itemBuilder: (context, index) {
            return buildBox(context, index);
          },
          shrinkWrap: true,
        ),

        SizedBox(
          height: context.dynamicHeight(0.04),
        ),
        Padding(
          padding: EdgeInsets.only(left: context.dynamicWidht(0.06)),
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
        ListView.builder(
          itemCount: definedBoxes.length,
          itemBuilder: (context, index) {
            return buildDefinedBox(context, index, definedBoxes);
          },
          shrinkWrap: true,
        ),

        SizedBox(
          height: context.dynamicHeight(0.04),
        ),
      ],
    );
  }

  Container buildDefinedBox(BuildContext context, int index, List<Box> definedBoxes) {
    return Container(
        //alignment: Alignment(-0.8, 0.0),
        padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.06)),
        width: context.dynamicWidht(1),
        height: context.dynamicHeight(0.080),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                LocaleText(
                  text: definedBoxes[index].name,
                  style: AppTextStyles.myInformationBodyTextStyle,
                ),
                LocaleText(
                  text: definedBoxes[index].description,
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
        ));
  }

  Container buildBox(BuildContext context, int index) {
    return Container(
        //alignment: Alignment(-0.8, 0.0),
        padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.06)),
        width: context.dynamicWidht(1),
        height: context.dynamicHeight(0.075),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.restaurant!.boxes![index].name!,
              style: AppTextStyles.myInformationBodyTextStyle,
            ),
            LocaleText(
              text: "Sor! sale day id: ${widget.restaurant!.boxes![0].saleDay!}",
            ),
            CustomButton(
              title: LocaleKeys.restaurant_detail_button_text,
              color: AppColors.greenColor,
              textColor: AppColors.appBarColor,
              width: context.dynamicWidht(0.28),
              borderColor: AppColors.greenColor,
              onPressed: () {
                print(widget.restaurant!.boxes![index].id!);
                context.read<OrderCubit>().addToBasket(widget.restaurant!.boxes![index].id!);
              },
            )
          ],
        ));
  }

  TabBar tabBar(BuildContext context) {
    return TabBar(
        labelPadding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.1)),
        indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: 3, color: AppColors.orangeColor), insets: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.11))),
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
        CustomCircularProgress(
          valueColor: AppColors.cursorColor,
          ratingText: "4.1",
          value: 1,
        )
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
        style: AppTextStyles.bodyBoldTextStyle.copyWith(fontWeight: FontWeight.w700, color: AppColors.greenColor),
      ),
    );
  }

  Text oldPriceText() {
    return Text(
      "75 TL",
      style: AppTextStyles.bodyBoldTextStyle.copyWith(decoration: TextDecoration.lineThrough, color: AppColors.unSelectedpackageDeliveryColor),
    );
  }

  Container packageContainer(BuildContext context) {
    return Container(
      alignment: Alignment(0.0, -0.11),
      width: context.dynamicWidht(0.19),
      height: context.dynamicHeight(0.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: AppColors.orangeColor,
      ),
      child: Text(
        "${widget.restaurant!.boxes!.length} paket",
        style: AppTextStyles.bodyBoldTextStyle.copyWith(color: Colors.white),
        textAlign: TextAlign.center,
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
            "$startTime-$endTime",
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyBoldTextStyle.copyWith(color: AppColors.yellowColor),
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
        Container(
          width: context.dynamicWidht(0.4),
          child: Text(
            widget.restaurant!.name!,
            style: AppTextStyles.appBarTitleStyle.copyWith(fontWeight: FontWeight.w600),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        LocaleText(text: widget.restaurant!.address, style: AppTextStyles.subTitleStyle),
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
          child: Image.network(widget.restaurant!.photo!),
        ));
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
              GestureDetector(
                  onTap: () {
                    setState(() {
                      _isSelect = !_isSelect;
                    });
                  },
                  child: SvgPicture.asset(
                    ImageConstant.RESTAURANT_FAVORITE_ICON,
                    color: _isSelect ? AppColors.orangeColor : AppColors.unSelectedpackageDeliveryColor,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
