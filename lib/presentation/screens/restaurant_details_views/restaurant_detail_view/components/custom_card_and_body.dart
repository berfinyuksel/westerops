import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/logic/cubits/box_cubit/box_cubit.dart';
import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';
import 'package:dongu_mobile/logic/cubits/store_cubit/store_cubit.dart';
import 'package:dongu_mobile/utils/clippers/password_rules_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../register_view/components/clipped_password_rules.dart';
import '../../../../../data/model/box.dart';
import '../../../../../data/model/store.dart';
import '../../../../../logic/cubits/order_cubit/order_cubit.dart';
import '../../../../../logic/cubits/user_operations_cubit/user_operations_cubit.dart';
import '../../../../../utils/constants/image_constant.dart';
import '../../../../../utils/extensions/context_extension.dart';
import '../../../../../utils/extensions/string_extension.dart';
import '../../../../../utils/locale_keys.g.dart';
import '../../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../../widgets/button/custom_button.dart';
import '../../../../widgets/text/locale_text.dart';
import 'custom_circular_progress.dart';
import 'info_tooltip.dart';

class CustomCardAndBody extends StatefulWidget {
  final Store? restaurant;
  final Box? boxes;
  const CustomCardAndBody({Key? key, this.restaurant, this.boxes}) : super(key: key);

  @override
  _CustomCardAndBodyState createState() => _CustomCardAndBodyState();
}

class _CustomCardAndBodyState extends State<CustomCardAndBody>
    with SingleTickerProviderStateMixin {
  String startTime = '';
  String endTime = '';
  List<Box> definedBoxes = [];
  bool isFavourite = false;
  int favouriteId = 0;
  bool showInfo = false;

  TabController? _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    definedBoxes.clear();
    context.read<BoxCubit>().getBoxes(widget.restaurant!.id!);
  }

  @override
  Widget build(BuildContext context,) {
    return GestureDetector(
      onTap: () {
        setState(() {
          showInfo = false;
        });
      },
      child: Column(
        children: [customCard(context), buildBuilder()],
      ),
    );
  }

  Builder buildBuilder() {
    return Builder(builder: (context) {
      final GenericState state = context.watch<BoxCubit>().state;
      if (state is GenericInitial) {
        return Container();
      } else if (state is GenericLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (state is GenericCompleted) {
        print(state.response);
        print(state.response.length);
       // print(state.response[0].description);
        return Center(child: customBody(context, state));
      } else {
        final error = state as GenericError;
        return Center(child: Text("${error.message}\n${error.statusCode}"));
      }
    });
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

  Column customCardTabView(BuildContext context,) {
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
                Padding(
                  padding: EdgeInsets.only(top: context.dynamicHeight(0.009)),
                  child: restaurantStarIconRating(),
                ),
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

  Container customBody(BuildContext context, GenericCompleted state) {
    return Container(
      height: context.dynamicHeight(0.5),
      child: TabBarView(
          controller: _controller,
          children: [tabPackages(context, state), tabDetail(context)]),
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
            contentPadding:
                EdgeInsets.only(bottom: context.dynamicHeight(0.028)),
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
            contentPadding:
                EdgeInsets.only(bottom: context.dynamicHeight(0.028)),
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
          padding:
              EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.065)),
          child: ListTile(
            contentPadding:
                EdgeInsets.only(bottom: context.dynamicHeight(0.028)),
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
          padding:
              EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.065)),
          child: ListTile(
            contentPadding:
                EdgeInsets.only(bottom: context.dynamicHeight(0.028)),
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
          height: context.dynamicHeight(0.069),
          padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.06)),
          child: ListTile(
            contentPadding:
                EdgeInsets.only(bottom: context.dynamicHeight(0.028)),
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
          height: context.dynamicHeight(0.085),
          padding:
              EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.065)),
          child: ListTile(
            contentPadding:
                EdgeInsets.only(bottom: context.dynamicHeight(0.028)),
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

  Column tabPackages(BuildContext context, GenericCompleted state) {
    return Column(
      children: [
        SizedBox(
          height: context.dynamicHeight(0.02),
        ),
        Stack(
          children: [
            Column(
              children: [
                packageCourierAndFavoriteContainer(context),
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
                            text: LocaleKeys.restaurant_detail_sub_title1,
                            style: AppTextStyles.bodyTitleStyle,
                          ),
                          SizedBox(
                            width: context.dynamicWidht(0.01),
                          ),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  showInfo = !showInfo;
                                });
                              },
                              child: SvgPicture.asset(
                                  ImageConstant.RESTAURANT_INFO_ICON))
                          //ClippedPasswordRules(child: Text("data"))
                        ],
                      ),
                      Divider(
                        thickness: 5,
                        color: AppColors.borderAndDividerColor,
                      )
                    ],
                  ),
                ),
              ],
            ),
            //spacer 4
            Align(
              alignment: Alignment(-0.05, 0),
              child: Visibility(
                  visible: showInfo,
                  child: ClippedPasswordRules(child: Text("data"))),
            )
          ],
        ),
        ListView.builder(
          itemCount: state.response.length, //widget.restaurant!.boxes!.length,//state.response.lenght
          itemBuilder: (context, index) {
            return buildBox(context, index, state);
          },
          physics: NeverScrollableScrollPhysics(),
          //   primary: false,
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
            return buildDefinedBox(context, index, definedBoxes, state);
          },
          shrinkWrap: true,
        ),
      ],
    );
  }
//parametrs changes
  Container buildDefinedBox(
      BuildContext context, int index, List<Box> definedBoxes, GenericCompleted state) {
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
                  text: definedBoxes[index].name!.name,
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

  Container buildBox(BuildContext context, int index, GenericCompleted state) {
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
             // widget.restaurant!.boxes![index].name!.name!,
             "widget.boxes!.name.toString()",
              style: AppTextStyles.myInformationBodyTextStyle,
            ),
            LocaleText(
              text:
                  // "Sor! sale day id: ${widget.restaurant!.boxes![0].saleDay!}",
                  "Sor! sale day id: 123}"
            ),
            CustomButton(
              title: LocaleKeys.restaurant_detail_button_text,
              color: AppColors.greenColor,
              textColor: AppColors.appBarColor,
              width: context.dynamicWidht(0.28),
              borderColor: AppColors.greenColor,
              onPressed: () {
                print(state.response.length);
                context
                    .read<OrderCubit>()
                    .addToBasket(widget.restaurant!.boxes![index].id!);
              },
            )
          ],
        ));
  }

  TabBar tabBar(BuildContext context) {
    return TabBar(
        labelPadding:
            EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.1)),
        indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: 3, color: AppColors.orangeColor),
            insets: EdgeInsets.symmetric(
              horizontal: context.dynamicWidht(0.11),
            )), // top değeri değişecek
        indicatorPadding: EdgeInsets.only(bottom: context.dynamicHeight(0.01)),
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

  Container packageContainer(BuildContext context,) {
    return Container(
      alignment: Alignment(0.0, -0.11),
      width: context.dynamicWidht(0.19),
      height: context.dynamicHeight(0.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: AppColors.orangeColor,
      ),
      child: Text(
        "${widget.restaurant!.id} paket",
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
            style: AppTextStyles.bodyBoldTextStyle
                .copyWith(color: AppColors.yellowColor),
          ),
        ],
      ),
    );
  }

  Row restaurantStarIconRating() {
    return Row(
      //backend
      children: [
        Container(
          child: SvgPicture.asset(ImageConstant.RESTAURANT_STAR_ICON),
        ),
        SizedBox(width: context.dynamicWidht(0.02)),
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
            style: AppTextStyles.appBarTitleStyle
                .copyWith(fontWeight: FontWeight.w600),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        LocaleText(
            text: widget.restaurant!.address,
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
                  padding: EdgeInsets.all(context.dynamicHeight(0.004)),
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
                  if (isFavourite) {
                    context
                        .read<UserOperationsCubit>()
                        .deleteFromFavourites(favouriteId);
                  } else {
                    context
                        .read<UserOperationsCubit>()
                        .addToFavorite(widget.restaurant!.id!);
                  }
                  setState(() {
                    isFavourite = !isFavourite;
                  });
                },
                child: SvgPicture.asset(
                  ImageConstant.RESTAURANT_FAVORITE_ICON,
                  color: isFavourite
                      ? AppColors.orangeColor
                      : AppColors.unSelectedpackageDeliveryColor,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
