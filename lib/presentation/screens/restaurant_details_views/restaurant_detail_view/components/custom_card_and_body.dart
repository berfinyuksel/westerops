import 'package:auto_size_text/auto_size_text.dart';
import 'package:dongu_mobile/presentation/screens/restaurant_details_views/restaurant_detail_view/components/restaurant_info_tab.dart';
import 'package:dongu_mobile/presentation/screens/restaurant_details_views/restaurant_detail_view/components/restaurant_info_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:dongu_mobile/logic/cubits/cancel_order_cubit/cancel_order_cubit.dart';
import 'package:dongu_mobile/logic/cubits/favourite_cubit/favorite_state.dart';
import 'package:dongu_mobile/logic/cubits/sum_price_order_cubit/sum_old_price_order_cubit.dart';
import 'package:dongu_mobile/presentation/widgets/circular_progress_indicator/custom_circular_progress_indicator.dart';

import '../../../../../data/model/box.dart';
import '../../../../../data/model/category_name.dart';
import '../../../../../data/model/search_store.dart';
import '../../../../../data/repositories/basket_repository.dart';
import '../../../../../data/services/locator.dart';
import '../../../../../data/shared/shared_prefs.dart';
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
import '../../../../widgets/tabBar/restaurant_details_tabbar.dart';
import '../../../../widgets/text/locale_text.dart';
import '../../../categories_view/screen_arguments_categories/screen_arguments_categories.dart';
import '../../../register_view/components/clipped_password_rules.dart';
import '../../../surprise_pack_view/components/custom_alert_dialog.dart';
import '../../screen_arguments/screen_arguments.dart';

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
    _controller = TabController(length: 2, vsync: this);
    definedBoxes.clear();
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
          BlocProvider(
            create: (context) => sl<CategoryNameCubit>()..init(),
          ),
        ],
        child: GestureDetector(
          onTap: () {
            setState(() {
              showInfo = false;
            });
          },
          child: Stack(children: [
            buildColumBodyView(context),
            buildSurpriseBoxInfo(context),
          ]),
        ));
  }

  Column buildColumBodyView(BuildContext context) {
    return Column(
      children: [customCard(context), SizedBox(height: 20), packageCourierAndFavoriteContainer(context), customBody(context)],
    );
  }

  Positioned buildSurpriseBoxInfo(BuildContext context) {
    return Positioned(
      left: MediaQuery.of(context).size.width * 0.39,
      top: MediaQuery.of(context).size.height * 0.27,
      child: Visibility(
          visible: showInfo,
          child: ClippedPasswordRules(
              child: SingleChildScrollView(
            //TODO: Bu text locale icerinse alinacaktir
            child: Text(
              "Sürpriz Paketler restoranın sana özel lezzetlerini yakalamanı sağlar.",
              textAlign: TextAlign.start,
              style: AppTextStyles.subTitleStyle,
            ),
          ))),
    );
  }

  Container customCard(BuildContext context) {
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
      child: customCardTabView(context),
    );
  }

  Column customCardTabView(BuildContext context) {
    return Column(
      children: [
        buildTabBar(),
        Divider(thickness: 2, color: AppColors.borderAndDividerColor),
        RestaurantInfoTile(restaurant: widget.restaurant),
        Divider(thickness: 2, color: AppColors.borderAndDividerColor),
        RestaurantInfoTab(controller: _controller!, restaurant: widget.restaurant!),
      ], //56
    );
  }

  Widget customBody(BuildContext context) {
    return BlocBuilder<BoxCubit, BoxState>(
      builder: (context, state) {
        if (state is GenericInitial) {
          return Container();
        } else if (state is BoxLoading) {
          return Center(child: CustomCircularProgressIndicator());
        } else if (state is BoxCompleted) {
          return Center(
            child: Container(
              height: _controller!.index == 0 ? context.dynamicHeight(state.packages.length * .2 + .25) : context.dynamicHeight(.7),
              child: TabBarView(controller: _controller, children: [tabPackages(context, state), tabDetail(context)]),
            ),
          );
        } else {
          return SizedBox();
        }
      },
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
                  ? LocaleKeys.restaurant_detail_detail_tab_sub_title1
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
                text: "${LocaleKeys.restaurant_detail_detail_tab_sub_title2.locale} ${widget.restaurant!.packageSettings!.deliveryTimeStart} - ${widget.restaurant!.packageSettings!.deliveryTimeEnd}",
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
                widget.restaurant!.name!,
                style: AppTextStyles.myInformationBodyTextStyle,
              ),
              trailing: SvgPicture.asset(ImageConstant.COMMONS_FORWARD_ICON),
            ),
          ),
        ),
        buildCategoriesSection(context),
      ],
    );
  }

  BlocBuilder buildCategoriesSection(BuildContext context) {
    return BlocBuilder<CategoryNameCubit, CategoryNameState>(builder: (context, state) {
      if (state is CategoryNameInital) {
        return Container();
      } else if (state is CategoryNameLoading) {
        return Center(child: CustomCircularProgressIndicator());
      } else if (state is CategoryNameCompleted) {
        List<Result> categoryList = [];
        List<Result> relatedCategories = [];
        for (var i = 0; i < state.response!.length; i++) {
          categoryList.add(state.response![i]);
        }

        for (var i = 0; i < categoryList.length; i++) {
          for (var j = 0; j < widget.restaurant!.categories!.length; j++) {
            if (categoryList[i].id == widget.restaurant!.categories![j].name) {
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
            Navigator.of(context)
                .pushNamed(RouteConstant.FOOD_CATEGORIES_VIEW, arguments: ScreenArgumentsCategories(categoriesList: relatedCategories));
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
        final error = state as GenericError;
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
                  style: AppTextStyles.bodyTextStyle,
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
                  style: AppTextStyles.bodyTextStyle,
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
              AutoSizeText(
                surpriseBoxes[index].defined == false ? "" : mealNames,
                style: AppTextStyles.subTitleStyle,
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    chosenRestaurat[0].packageSettings!.minOrderPrice.toString() + " TL",
                    style: AppTextStyles.bodyBoldTextStyle
                        .copyWith(decoration: TextDecoration.lineThrough, color: AppColors.unSelectedpackageDeliveryColor),
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
            imagePath: ImageConstant.DONGU_LOGO,
            showCloseButton: true,
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

  Widget buildTabBar() {
    return RestaurantDetailsTabBar(
      controller: _controller!,
      onTap: (value) {
        setState(() {
          showInfo = false;
        });
      },
    );
  }

  Container packageCourierAndFavoriteContainer(BuildContext context) {
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
                  color: widget.restaurant!.packageSettings!.deliveryType == "1" || widget.restaurant!.packageSettings!.deliveryType == "3"
                      ? AppColors.yellowColor
                      : Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.all(context.dynamicHeight(0.004)),
                  child: SvgPicture.asset(
                    ImageConstant.RESTAURANT_PACKAGE_ICON,
                    color: widget.restaurant!.packageSettings!.deliveryType == "1" || widget.restaurant!.packageSettings!.deliveryType == "3"
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
                  color: widget.restaurant!.packageSettings!.deliveryType == "2" || widget.restaurant!.packageSettings!.deliveryType == "3"
                      ? AppColors.yellowColor
                      : Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.all(context.dynamicHeight(0.006)),
                  child: SvgPicture.asset(
                    ImageConstant.RESTAURANT_COURIER_ICON,
                    color: widget.restaurant!.packageSettings!.deliveryType == "2" || widget.restaurant!.packageSettings!.deliveryType == "3"
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
