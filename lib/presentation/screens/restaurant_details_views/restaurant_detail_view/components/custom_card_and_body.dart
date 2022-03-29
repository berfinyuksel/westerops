import 'package:dongu_mobile/logic/cubits/cancel_order_cubit/cancel_order_cubit.dart';
import 'package:dongu_mobile/logic/cubits/favourite_cubit/favorite_state.dart';
import 'package:dongu_mobile/presentation/widgets/circular_progress_indicator/custom_circular_progress_indicator.dart';
import 'package:dongu_mobile/logic/cubits/sum_price_order_cubit/sum_old_price_order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../data/model/box.dart';
import '../../../../../data/model/category_name.dart';
import '../../../../../data/model/search_store.dart';
import '../../../../../data/repositories/basket_repository.dart';
import '../../../../../data/services/locator.dart';
import '../../../../../data/shared/shared_prefs.dart';
import '../../../../../logic/cubits/address_cubit/address_cubit.dart';
import '../../../../../logic/cubits/basket_counter_cubit/basket_counter_cubit.dart';
import '../../../../../logic/cubits/box_cubit/box_cubit.dart';
import '../../../../../logic/cubits/box_cubit/box_state.dart';
import '../../../../../logic/cubits/category_name_cubit/category_name_cubit.dart';
import '../../../../../logic/cubits/favourite_cubit/favourite_cubit.dart';
import '../../../../../logic/cubits/generic_state/generic_state.dart';
import '../../../../../logic/cubits/order_cubit/order_cubit.dart';
import '../../../../../logic/cubits/search_store_cubit/search_store_cubit.dart';
import '../../../../../logic/cubits/sum_price_order_cubit/sum_price_order_cubit.dart';
import '../../../../../logic/cubits/swipe_route_cubit.dart/swipe_route_cubit.dart';
import '../../../../../utils/constants/image_constant.dart';
import '../../../../../utils/constants/route_constant.dart';
import '../../../../../utils/extensions/context_extension.dart';
import '../../../../../utils/extensions/string_extension.dart';
import '../../../../../utils/locale_keys.g.dart';
import '../../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../../widgets/button/custom_button.dart';
import '../../../../widgets/text/locale_text.dart';
import '../../../categories_view/screen_arguments_categories/screen_arguments_categories.dart';
import '../../../register_view/components/clipped_password_rules.dart';
import '../../../surprise_pack_view/components/custom_alert_dialog.dart';
import '../../screen_arguments/screen_arguments.dart';
import 'custom_circular_progress.dart';

class CustomCardAndBody extends StatefulWidget {
  final SearchStore? restaurant;
  final Box? boxes;
  const CustomCardAndBody({Key? key, this.restaurant, this.boxes}) : super(key: key);

  @override
  _CustomCardAndBodyState createState() => _CustomCardAndBodyState();
}

class _CustomCardAndBodyState extends State<CustomCardAndBody> with SingleTickerProviderStateMixin {
  List<Box> definedBoxes = [];
  bool isFavorite = false;
  int favouriteId = 0;
  bool showInfo = false;
  List<String>? menuList = SharedPrefs.getMenuList;
  int? priceOfMenu = null ?? 0;
  int? oldPriceOfMenu = null ?? 0;

  List<String>? favouritedRestaurants = SharedPrefs.getFavorites;
  String mealNames = '';

  TabController? _controller;
  @override
  void initState() {
    super.initState();
    print('restoran id : ${widget.restaurant!.id}');
    _controller = TabController(length: 2, vsync: this);
    definedBoxes.clear();
    context.read<AddressCubit>().getActiveAddress();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<FavoriteCubit>()..init(widget.restaurant!.id!),
          ),
          BlocProvider(
            create: (context) => sl<BoxCubit>()..getBoxes(widget.restaurant!.id!),
          ),
        ],
        child: BlocBuilder<BoxCubit, BoxState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  showInfo = false;
                });
              },
              child: Stack(children: [
                Column(
                  children: [
                    customCard(context, state),
                    SizedBox(
                      height: 20,
                    ),
                    packageCourierAndFavoriteContainer(context, state),
                    buildBuilder(),
                  ],
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.39,
                  top: MediaQuery.of(context).size.height * 0.27,
                  child: Visibility(
                      visible: showInfo,
                      child: ClippedPasswordRules(
                          child: SingleChildScrollView(
                        child: Text(
                          "Sürpriz Paketler ile alakalı bilgilendirme buraya gelecek",
                          textAlign: TextAlign.justify,
                        ),
                      ))),
                ),
              ]),
            );
          },
        ));
  }

  BlocBuilder buildBuilder() {
    return BlocBuilder<BoxCubit, BoxState>(
      builder: (context, state) {
        if (state is GenericInitial) {
          return Container();
        } else if (state is BoxLoading) {
          return Center(child: CustomCircularProgressIndicator());
        } else if (state is BoxCompleted) {
          return Center(child: customBody(context, state));
        } else {
          return SizedBox();
        }
      },
    );
  }

  Container customCard(BuildContext context, BoxState state) {
    return Container(
      width: 372.w,
      height: 280.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(18.0),
          bottom: Radius.circular(8.0),
        ),
        color: Colors.white,
      ),
      child: customCardTabView(context, state),
    );
  }

  Column customCardTabView(BuildContext context, BoxState state) {
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
                  padding: EdgeInsets.only(top: 10.h),
                  child: restaurantStarIconRating(),
                ),
                //   Spacer(flex: 1),
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
                  packageContainer(context, state),
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

  Container customBody(BuildContext context, BoxCompleted state) {
    return Container(
      height:
          _controller!.index == 0 ? context.dynamicHeight(state.packages.length * .2 + .25) : context.dynamicHeight(.7),
      child: TabBarView(controller: _controller, children: [tabPackages(context, state), tabDetail(context)]),
    );
  }

  Column tabDetail(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20.h,
        ),
        Container(
          color: AppColors.appBarColor,
          width: double.infinity,
          height: 100.h,
          padding: EdgeInsets.symmetric(horizontal: 28.w),
          child: ListTile(
            contentPadding: EdgeInsets.only(bottom: 7.h),
            title: LocaleText(
              text: LocaleKeys.restaurant_detail_detail_tab_title1,
              style: AppTextStyles.subTitleStyle,
            ),
            subtitle: Text(
              "${widget.restaurant!.packageSettings!.deliveryTimeStart} - ${widget.restaurant!.packageSettings!.deliveryTimeEnd}",
              style: AppTextStyles.myInformationBodyTextStyle,
            ),
            //trailing: SvgPicture.asset(ImageConstant.COMMONS_FORWARD_ICON),
          ),
        ),
        Container(
          color: AppColors.appBarColor,
          width: double.infinity,
          height: 100.h,
          padding: EdgeInsets.symmetric(horizontal: 28.w),
          child: ListTile(
            isThreeLine: true,
            contentPadding: EdgeInsets.only(bottom: 7.h),
            title: LocaleText(
              text: LocaleKeys.restaurant_detail_detail_tab_title2,
              style: AppTextStyles.subTitleStyle,
            ),
            subtitle: LocaleText(
              text: widget.restaurant!.packageSettings!.deliveryType == "3"
                  ? LocaleKeys.restaurant_detail_sub_title1
                  : widget.restaurant!.packageSettings!.deliveryType == "1"
                      ? LocaleKeys.restaurant_detail_detail_tab_sub_title6
                      : LocaleKeys.restaurant_detail_detail_tab_sub_title7,
              style: AppTextStyles.myInformationBodyTextStyle,
            ),
            //trailing: SvgPicture.asset(ImageConstant.COMMONS_FORWARD_ICON),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(RouteConstant.ABOUT_WORKING_HOUR_VIEW,
                arguments: ScreenArgumentsRestaurantDetail(
                  restaurant: widget.restaurant!,
                ));
          },
          child: Container(
            color: AppColors.appBarColor,
            width: double.infinity,
            height: 100.h,
            padding: EdgeInsets.symmetric(horizontal: 28.w),
            child: ListTile(
              contentPadding: EdgeInsets.only(bottom: 7.h),
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
        ),
        Container(
          color: AppColors.appBarColor,
          width: double.infinity,
          height: 100.h,
          padding: EdgeInsets.symmetric(horizontal: 28.w),
          child: ListTile(
            // isThreeLine: true,
            contentPadding: EdgeInsets.only(bottom: 7.h),
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
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(RouteConstant.STORE_INFO_VIEW,
                arguments: ScreenArgumentsRestaurantDetail(
                  restaurant: widget.restaurant!,
                ));
          },
          child: Container(
            color: AppColors.appBarColor,
            width: double.infinity,
            height: 100.h,
            padding: EdgeInsets.symmetric(horizontal: 28.w),
            child: ListTile(
              contentPadding: EdgeInsets.only(bottom: 7.h),
              title: LocaleText(
                text: LocaleKeys.restaurant_detail_detail_tab_title5,
                style: AppTextStyles.subTitleStyle,
              ),
              subtitle: Text(
                "${LocaleKeys.swipe_restaurant_name.locale}: ${widget.restaurant!.name!}",
                style: AppTextStyles.myInformationBodyTextStyle,
              ),
              trailing: SvgPicture.asset(ImageConstant.COMMONS_FORWARD_ICON),
            ),
          ),
        ),
        //  buildCategoriesSection(context),
      ],
    );
  }

  Builder buildCategoriesSection(BuildContext context) {
    return Builder(builder: (context) {
      final stateOfCategories = context.watch<CategoryNameCubit>().state;

      if (stateOfCategories is CategoryNameInital) {
        return Container();
      } else if (stateOfCategories is CategoryNameLoading) {
        return Center(child: CustomCircularProgressIndicator());
      } else if (stateOfCategories is CategoryNameCompleted) {
        List<Result> categoryList = [];
        List<Result> relatedCategories = [];
        for (var i = 0; i < stateOfCategories.response!.length; i++) {
          categoryList.add(stateOfCategories.response![i]);
        }

        for (var i = 0; i < categoryList.length; i++) {
          for (var j = 0; j < widget.restaurant!.categories!.length; j++) {
            if (categoryList[i].id == widget.restaurant!.categories![j].id) {
              relatedCategories.add(categoryList[i]);
            }
          }
        }
        List<String> nameList = [];
        for (var i = 0; i < relatedCategories.length; i++) {
          nameList.add(relatedCategories[i].name!);
        }
        String categoryNames = nameList.join(', ');
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(RouteConstant.FOOD_CATEGORIES_VIEW,
                arguments: ScreenArgumentsCategories(categoriesList: relatedCategories));
          },
          child: Container(
            color: AppColors.appBarColor,
            width: double.infinity,
            height: 100.h,
            padding: EdgeInsets.symmetric(horizontal: 28.w),
            child: ListTile(
              contentPadding: EdgeInsets.only(bottom: 7.h),
              title: LocaleText(
                text: LocaleKeys.restaurant_detail_detail_tab_title6,
                style: AppTextStyles.subTitleStyle,
              ),
              subtitle: Text(
                categoryNames,
                style: AppTextStyles.myInformationBodyTextStyle,
              ),
              trailing: SvgPicture.asset(ImageConstant.COMMONS_FORWARD_ICON),
            ),
          ),
        );
      } else {
        final error = stateOfCategories as GenericError;
        return Center(child: Text("${error.message}\n${error.statusCode}"));
      }
    });
  }

  Widget tabPackages(BuildContext context, BoxCompleted state) {
    List<Box> boxLists = [];
    for (var i = 0; i < state.packages.length; i++) {
      boxLists.add(state.packages[i]);
    }
    List<Box> surpriseBoxes = [];
    List<Box> definedBoxess = [];
    for (var i = 0; i < boxLists.length; i++) {
      if (boxLists[i].defined == false) {
        surpriseBoxes.add(boxLists[i]);
      } else {
        definedBoxess.add(boxLists[i]);
      }
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Column(
            children: [
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.only(left: 28.w),
                child: Column(
                  children: [
                    restaurantInfoIconAndSubTitle(context),
                    Divider(
                      thickness: 5,
                      color: AppColors.borderAndDividerColor,
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Visibility(
              visible: surpriseBoxes.isEmpty,
              child: Center(
                child: LocaleText(
                  text: LocaleKeys.restaurant_detail_detail_tab_sub_title8,
                ),
              )),
          ListView.builder(
            itemCount: surpriseBoxes.length,
            itemBuilder: (context, index) {
              return buildBox(context, index, state, surpriseBoxes);
            },
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
          ),
          SizedBox(
            height: 40.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 28.w),
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
          SizedBox(height: 20.h),
          Visibility(
              visible: definedBoxess.isEmpty,
              child: Center(
                child: LocaleText(
                  text: LocaleKeys.restaurant_detail_detail_tab_sub_title9,
                ),
              )),
          ListView.builder(
            itemCount: definedBoxess.length,
            itemBuilder: (context, index) {
              return buildBox(context, index, state, definedBoxess);
            },
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
          ),
        ],
      ),
    );
  }

  Row restaurantInfoIconAndSubTitle(BuildContext context) {
    return Row(
      children: [
        LocaleText(
          text: LocaleKeys.restaurant_detail_sub_title1,
          style: AppTextStyles.bodyTitleStyle,
        ),
        SizedBox(
          width: 10.w,
        ),
        GestureDetector(
            onTap: () {
              setState(() {
                showInfo = !showInfo;
              });
            },
            child: SvgPicture.asset(ImageConstant.RESTAURANT_INFO_ICON)),

        //ClippedPasswordRules(child: Text("data"))
      ],
    );
  }

//parametrs changes
  Container buildDefinedBox(BuildContext context, int index, List<Box> definedBoxes, GenericCompleted state) {
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
                  text: "${definedBoxes[index].textName}",
                  style: AppTextStyles.myInformationBodyTextStyle,
                ),
                LocaleText(
                  text: definedBoxes[index].description ?? '',
                  style: AppTextStyles.subTitleStyle,
                  maxLines: 2,
                ),
              ],
            ),
            CustomButton(
              title: LocaleKeys.restaurant_detail_button_text,
              color: AppColors.greenColor,
              textColor: AppColors.appBarColor,
              width: 110.w,
              borderColor: AppColors.greenColor,
              onPressed: () {},
            )
          ],
        ));
  }

  Column buildBox(
    BuildContext context,
    int index,
    BoxCompleted state,
    List<Box> surpriseBoxes,
  ) {
    List<SearchStore> chosenRestaurat = [];
    for (var i = 0; i < sl<SearchStoreCubit>().searchStores.length; i++) {
      if (sl<SearchStoreCubit>().searchStores[i].id == state.packages[index].store) {
        chosenRestaurat.add(sl<SearchStoreCubit>().searchStores[i]);
        priceOfMenu = chosenRestaurat[0].packageSettings!.minDiscountedOrderPrice;
        oldPriceOfMenu = chosenRestaurat[0].packageSettings!.minOrderPrice;
      }
    }
    List<String> meals = [];
    if (surpriseBoxes[index].meals!.isNotEmpty) {
      for (var i = 0; i < surpriseBoxes[index].meals!.length; i++) {
        meals.add(surpriseBoxes[index].meals![i].name!);
      }
      mealNames = meals.join(', ');
    }
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 28.w),
          width: double.infinity,
          height: 145.h,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Text(
                "${surpriseBoxes[index].textName}",
                style: AppTextStyles.myInformationBodyTextStyle,
              ),
              SizedBox(
                height: 5.h,
              ),
              LocaleText(
                text: surpriseBoxes[index].defined == false ? "" : mealNames,
                style: AppTextStyles.subTitleStyle,
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 69.w,
                    height: 36.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 5.w),
                      child: Text(
                        chosenRestaurat[0].packageSettings!.minOrderPrice.toString() + " TL",
                        style: AppTextStyles.bodyBoldTextStyle.copyWith(
                            decoration: TextDecoration.lineThrough, color: AppColors.unSelectedpackageDeliveryColor),
                      ),
                    ),
                  ),
                  Spacer(flex: 1),
                  Container(
                    alignment: Alignment.center,
                    width: 69.w,
                    height: 36.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: AppColors.scaffoldBackgroundColor,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 5.w),
                      child: Text(
                        chosenRestaurat[0].packageSettings!.minDiscountedOrderPrice.toString() + " TL",
                        style: AppTextStyles.bodyBoldTextStyle.copyWith(
                          color: AppColors.greenColor,
                        ),
                      ),
                    ),
                  ),
                  Spacer(flex: 4),
                  Builder(
                    builder: (context) {
                      SharedPrefs.setSumPrice(context.watch<SumPriceOrderCubit>().state);
                      SharedPrefs.setOldSumPrice(context.watch<SumOldPriceOrderCubit>().state);
                      int? menuItem = state.packages[index].id;
                      final counterState = context.watch<BasketCounterCubit>().state;
                      return Builder(builder: (context) {
                        return CustomButton(
                          title: menuList!.contains(menuItem.toString())
                              ? LocaleKeys.restaurant_detail_button_text2
                              : LocaleKeys.restaurant_detail_button_text,
                          color: menuList!.contains(menuItem.toString()) ? Colors.transparent : AppColors.greenColor,
                          textColor: menuList!.contains(menuItem.toString()) ? AppColors.greenColor : Colors.white,
                          width: 110.w,
                          borderColor: AppColors.greenColor,
                          onPressed: () async {
                            context.read<SwipeRouteButton>().swipeRouteButton(true);
                            await pressedBuyButton(state, index, context, counterState, menuItem!);
                          },
                        );
                      });
                    },
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 5.h),
      ],
    );
  }

  Future<void> pressedBuyButton(
    BoxCompleted state,
    int index,
    BuildContext context,
    int counterState,
    int menuItem,
  ) async {
    context.read<CancelOrderCubit>().cancelOrder(true);
    StatusCode statusCode = await sl<BasketRepository>().addToBasket(
      "${state.packages[index].id}",
      SharedPrefs.getActiveAddressId,
      SharedPrefs.getActiveAddressId,
    );
    if (statusCode == StatusCode.unauthecticated) {
      showDialog(
        context: context,
        builder: (_) => CustomAlertDialog(
            textMessage: LocaleKeys.restaurant_detail_show_dialog_text,
            buttonOneTitle: LocaleKeys.restaurant_detail_show_dialog_button1,
            buttonTwoTittle: LocaleKeys.restaurant_detail_show_dialog_button2,
            imagePath: ImageConstant.SURPRISE_PACK,
            onPressedOne: () {
              Navigator.of(context).pushNamed(RouteConstant.LOGIN_VIEW);
            },
            onPressedTwo: () {
              Navigator.of(context).pushNamed(RouteConstant.REGISTER_VIEW);
            }),
      );
    } else if (statusCode == StatusCode.noAddress) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Container(
            padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.04)),
            width: context.dynamicWidht(0.87),
            height: context.dynamicHeight(0.29),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.0),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Spacer(flex: 8),
                SvgPicture.asset(
                  ImageConstant.SURPRISE_PACK,
                  height: context.dynamicHeight(0.134),
                ),
                SizedBox(height: 10.h),
                LocaleText(
                  text: LocaleKeys.restaurant_detail_alert_dialog_text_1,
                  style: AppTextStyles.bodyBoldTextStyle,
                  alignment: TextAlign.center,
                ),
                Spacer(flex: 35),
                CustomButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, RouteConstant.ADDRESS_VIEW);
                  },
                  width: context.dynamicWidht(0.35),
                  color: AppColors.greenColor,
                  textColor: Colors.white,
                  borderColor: AppColors.greenColor,
                  title: LocaleKeys.restaurant_detail_alert_dialog_text_2,
                ),
                Spacer(flex: 20),
              ],
            ),
          ),
        ),
      );
    } else {
      setState(() {});
      switch (statusCode) {
        case StatusCode.success:
          if (!menuList!.contains(menuItem.toString())) {
            context.read<SumPriceOrderCubit>().incrementPrice(priceOfMenu!);
            context.read<SumOldPriceOrderCubit>().incrementOldPrice(oldPriceOfMenu!);

            context.read<BasketCounterCubit>().increment();
            SharedPrefs.setCounter(counterState + 1);
            menuList!.add(menuItem.toString());
            SharedPrefs.setMenuList(menuList!);
          } else {
            context.read<SumPriceOrderCubit>().decrementPrice(priceOfMenu!);
            context.read<SumOldPriceOrderCubit>().decrementOldPrice(priceOfMenu!);

            context.read<OrderCubit>().deleteBasket("${state.packages[index].id}");
            context.read<BasketCounterCubit>().decrement();
            SharedPrefs.setCounter(counterState - 1);
            menuList!.remove(state.packages[index].id.toString());
            SharedPrefs.setMenuList(menuList!);
          }
          break;
        default:
          showDialog(
              context: context,
              builder: (_) => CustomAlertDialog(
                  onPressedOne: () {
                    Navigator.pop(context);
                  },
                  onPressedTwo: () {
                    context.read<OrderCubit>().clearBasket();

                    context.read<SumPriceOrderCubit>().clearPrice();
                    context.read<SumOldPriceOrderCubit>().clearOldPrice();
                    SharedPrefs.setSumPrice(0);
                    SharedPrefs.setOldSumPrice(0);
                    menuList!.clear();
                    SharedPrefs.setCounter(0);
                    SharedPrefs.setMenuList([]);
                    context.read<BasketCounterCubit>().setCounter(0);

                    Navigator.pop(context);
                  },
                  imagePath: ImageConstant.SURPRISE_PACK_ALERT,
                  textMessage: LocaleKeys.restaurant_detail_diffrent_restaurant_show_dialog_text_1,
                  buttonOneTitle: LocaleKeys.restaurant_detail_diffrent_restaurant_show_dialog_button1,
                  buttonTwoTittle: LocaleKeys.restaurant_detail_diffrent_restaurant_show_dialog_button2));
      }
    }
  }

  TabBar tabBar(BuildContext context) {
    return TabBar(
        onTap: (context) {
          setState(() {
            showInfo = false;
          });
        },
        labelPadding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.1)),
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
          fontSize: 18.0.sp,
          color: AppColors.textColor,
          fontWeight: FontWeight.w300,
          height: 2.5.h,
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
    List<int> mealPoints = [];
    for (var i = 0; i < widget.restaurant!.review!.length; i++) {
      int mealPoint = widget.restaurant!.review![i].qualityPoint!;
      mealPoints.add(mealPoint);
    }
    int totalMealPoints = mealPoints.fold(0, (previousValue, element) => previousValue + element);

    String? avgMealPoint = (totalMealPoints / widget.restaurant!.review!.length).toStringAsFixed(1);
    return Row(
      children: [
        LocaleText(
          text: LocaleKeys.restaurant_detail_item3,
          style: AppTextStyles.subTitleStyle,
        ),
        SizedBox(
          width: 10.w,
        ),
        CustomCircularProgress(
          valueColor: AppColors.cursorColor,
          ratingText: mealPoints.isNotEmpty ? avgMealPoint : '0.0',
          value: mealPoints.isNotEmpty ? double.parse(avgMealPoint) / 5.0 : 0.0,
        )
        /*SvgPicture.asset(ImageConstant.RESTAURANT_FOOD_RATING_ICON),*/
      ],
    );
  }

  Row qualityRatingRow(BuildContext context) {
    List<int> qualityPoints = [];
    for (var i = 0; i < widget.restaurant!.review!.length; i++) {
      int qualityPoint = widget.restaurant!.review![i].qualityPoint!;
      qualityPoints.add(qualityPoint);
    }
    int totalQualityPoints = qualityPoints.fold(0, (previousValue, element) => previousValue + element);

    String avgQualityPoint = (totalQualityPoints / widget.restaurant!.review!.length).toStringAsFixed(1);
    return Row(
      children: [
        LocaleText(
          text: LocaleKeys.restaurant_detail_item2,
          style: AppTextStyles.subTitleStyle,
        ),
        SizedBox(
          width: 10.w,
        ),
        CustomCircularProgress(
          valueColor: AppColors.pinkColor,
          ratingText: qualityPoints.isNotEmpty ? avgQualityPoint : '0.0',
          value: qualityPoints.isNotEmpty ? double.parse(avgQualityPoint) / 5 : 0.0,
        ),
      ],
    );
  }

  Row serviceRatingRow(BuildContext context) {
    List<int> servicePoints = [];
    for (var i = 0; i < widget.restaurant!.review!.length; i++) {
      int servicePoint = widget.restaurant!.review![i].servicePoint!;
      servicePoints.add(servicePoint);
    }
    int totalServicePoints = servicePoints.fold(0, (previousValue, element) => previousValue + element);

    String avgServicePoint = (totalServicePoints / widget.restaurant!.review!.length).toStringAsFixed(1);
    return Row(
      children: [
        LocaleText(
          text: LocaleKeys.restaurant_detail_item1,
          style: AppTextStyles.subTitleStyle,
        ),
        SizedBox(
          width: 10.w,
        ),
        CustomCircularProgress(
          value: servicePoints.isNotEmpty ? double.parse(avgServicePoint) / 5 : 0.0,
          valueColor: AppColors.greenColor,
          ratingText: servicePoints.isNotEmpty ? avgServicePoint : '0.0',
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
        widget.restaurant!.packageSettings!.minDiscountedOrderPrice.toString() + " TL",
        textAlign: TextAlign.center,
        style: AppTextStyles.bodyBoldTextStyle.copyWith(fontWeight: FontWeight.w700, color: AppColors.greenColor),
      ),
    );
  }

  Text oldPriceText() {
    return Text(
      widget.restaurant!.packageSettings!.minOrderPrice.toString() + " TL",
      style: AppTextStyles.bodyBoldTextStyle
          .copyWith(decoration: TextDecoration.lineThrough, color: AppColors.unSelectedpackageDeliveryColor),
    );
  }

  Container packageContainer(BuildContext context, BoxState state) {
    if (state is BoxCompleted) {
      return state.packages.length != 0
          ? Container(
              alignment: Alignment(0.0, -0.11),
              width: 85.w,
              height: 36.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: AppColors.orangeColor,
              ),
              child: Text(
                "${state.packages.length} ${LocaleKeys.restaurant_detail_packet_container_package.locale}",
                style: AppTextStyles.bodyBoldTextStyle.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            )
          : Container(
              alignment: Alignment(0.0, -0.11),
              width: 85.w,
              height: 36.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: AppColors.yellowColor,
              ),
              child: Text(
                LocaleKeys.restaurant_detail_packet_container_sold_out.locale,
                style: AppTextStyles.bodyBoldTextStyle.copyWith(color: Colors.white),
              ),
            );
    } else
      return Container(
        width: 0,
        height: 0,
      );
  }

  Container clockContainer(BuildContext context) {
    return Container(
      width: 125.w,
      height: 36.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: AppColors.scaffoldBackgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset(ImageConstant.COMMONS_TIME_ICON),
          Text(
            "${widget.restaurant!.packageSettings!.deliveryTimeStart!}-${widget.restaurant!.packageSettings!.deliveryTimeEnd}",
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyBoldTextStyle.copyWith(color: AppColors.yellowColor),
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
        SizedBox(width: 10.w),
        Text(
          widget.restaurant!.avgReview!.toStringAsFixed(1),
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
          width: 180.w,
          child: Text(
            widget.restaurant!.name!,
            style: AppTextStyles.appBarTitleStyle.copyWith(fontWeight: FontWeight.w600),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          widget.restaurant!.address!,
          style: AppTextStyles.subTitleStyle,
        ),
        // LocaleText(text: widget.restaurant!.address, style: AppTextStyles.subTitleStyle),
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
            width: 2.0.w,
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

  Container packageCourierAndFavoriteContainer(BuildContext context, BoxState state) {
    return Container(
      width: double.infinity,
      height: 65.h,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Container(
                width: 51.w,
                height: 36.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: widget.restaurant!.packageSettings!.deliveryType == "1" ||
                          widget.restaurant!.packageSettings!.deliveryType == "3"
                      ? AppColors.greenColor
                      : Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.all(context.dynamicHeight(0.004)),
                  child: SvgPicture.asset(
                    ImageConstant.RESTAURANT_PACKAGE_ICON,
                    color: widget.restaurant!.packageSettings!.deliveryType == "1" ||
                            widget.restaurant!.packageSettings!.deliveryType == "3"
                        ? Colors.white
                        : AppColors.unSelectedpackageDeliveryColor,
                  ),
                ),
              ),
              SizedBox(
                width: 7.w,
              ),
              Container(
                width: 51.w,
                height: 36.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: widget.restaurant!.packageSettings!.deliveryType == "2" ||
                          widget.restaurant!.packageSettings!.deliveryType == "3"
                      ? AppColors.greenColor
                      : Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.all(context.dynamicHeight(0.006)),
                  child: SvgPicture.asset(
                    ImageConstant.RESTAURANT_COURIER_ICON,
                    color: widget.restaurant!.packageSettings!.deliveryType == "2" ||
                            widget.restaurant!.packageSettings!.deliveryType == "3"
                        ? Colors.white
                        : AppColors.unSelectedpackageDeliveryColor,
                  ),
                ),
              ),
            ],
          ),
          BlocBuilder<FavoriteCubit, FavoriteState>(
            builder: (context, state) {
              if (state is FavoriteLoading) {
                return SizedBox();
              } else if (state is FavoriteError) {
                return Center(child: Text("${state.message}\n${state.statusCode}"));
              } else if (state is IsFavoriteChange) {
                print('ui icindeki state favorite: ' + state.isFavorite.toString());
                return Row(
                  children: [
                    LocaleText(
                      text: state.isFavorite ? LocaleKeys.restaurant_detail_text4 : LocaleKeys.restaurant_detail_text3,
                      style: AppTextStyles.bodyTextStyle,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (SharedPrefs.getIsLogined) {
                          context.read<FavoriteCubit>().toggleIsFavorite(context, widget.restaurant!);
                        } else {
                          Navigator.pushNamed(context, RouteConstant.LOGIN_VIEW);
                        }
                      },
                      child: SvgPicture.asset(
                        ImageConstant.RESTAURANT_FAVORITE_ICON,
                        color: state.isFavorite ? AppColors.orangeColor : AppColors.unSelectedpackageDeliveryColor,
                      ),
                    ),
                  ],
                );
              } else {
                print('state else icine dustu');
                return SizedBox();
              }
            },
          )
        ],
      ),
    );
  }
}
