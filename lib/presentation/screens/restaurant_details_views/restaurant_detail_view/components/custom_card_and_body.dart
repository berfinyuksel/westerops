import 'package:dongu_mobile/data/model/category_name.dart';
import 'package:dongu_mobile/data/model/favourite.dart';
import 'package:dongu_mobile/data/model/search_store.dart';
import 'package:dongu_mobile/data/repositories/basket_repository.dart';

import 'package:dongu_mobile/data/repositories/order_repository.dart';
import 'package:dongu_mobile/data/services/locator.dart';
import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/logic/cubits/basket_counter_cubit/basket_counter_cubit.dart';
import 'package:dongu_mobile/logic/cubits/box_cubit/box_cubit.dart';
import 'package:dongu_mobile/logic/cubits/category_name_cubit/category_name_cubit.dart';
import 'package:dongu_mobile/logic/cubits/favourite_cubit/favourite_cubit.dart';

import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';
import 'package:dongu_mobile/logic/cubits/search_store_cubit/search_store_cubit.dart';
import 'package:dongu_mobile/logic/cubits/store_boxes_cubit/store_boxes_cubit.dart';
import 'package:dongu_mobile/logic/cubits/sum_price_order_cubit/sum_price_order_cubit.dart';
import 'package:dongu_mobile/presentation/screens/cart_view/cart_view.dart';
import 'package:dongu_mobile/presentation/screens/categories_view/screen_arguments_categories/screen_arguments_categories.dart';
import 'package:dongu_mobile/presentation/screens/login_view/login_view.dart';
import 'package:dongu_mobile/presentation/screens/payment_views/payment_payment_view/payment_payment_view.dart';
import 'package:dongu_mobile/presentation/screens/restaurant_details_views/screen_arguments/screen_arguments.dart';
import 'package:dongu_mobile/presentation/screens/surprise_pack_view/components/custom_alert_dialog.dart';
import 'package:dongu_mobile/utils/clippers/password_rules_clipper.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../register_view/components/clipped_password_rules.dart';
import '../../../../../data/model/box.dart';

import '../../../../../logic/cubits/order_cubit/order_cubit.dart';

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
  final SearchStore? restaurant;
  final Box? boxes;
  const CustomCardAndBody({Key? key, this.restaurant, this.boxes})
      : super(key: key);

  @override
  _CustomCardAndBodyState createState() => _CustomCardAndBodyState();
}

class _CustomCardAndBodyState extends State<CustomCardAndBody>
    with SingleTickerProviderStateMixin {
  List<Box> definedBoxes = [];
  bool isFavourite = false;
  int favouriteId = 0;
  bool showInfo = false;
  List<String>? menuList = SharedPrefs.getMenuList;
  List<String> sumOfPricesString = [];
  List<int> sumOfPricesInt = [];
  int? priceOfMenu = null ?? 0;
  List<String>? favouritedRestaurants = SharedPrefs.getFavorites;
  String mealNames = '';

  TabController? _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    definedBoxes.clear();
    context.read<BoxCubit>().getBoxes(widget.restaurant!.id!);
    context.read<SearchStoreCubit>().getSearchStore();
    context.read<FavoriteCubit>().getFavorite();
    // definedBoxes = context.read<BoxCubit>().getBoxes(widget.restaurant!.id!);
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final GenericState state = context.watch<BoxCubit>().state;

    return GestureDetector(
      onTap: () {
        setState(() {
          showInfo = false;
        });
      },
      child: Column(
        children: [
          customCard(context, state),
          SizedBox(
            height: 20,
          ),
          packageCourierAndFavoriteContainer(context, state),
          buildBuilder(),
        ],
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
        //print(state.response[0].description);
        return Center(child: customBody(context, state));
      } else {
        final error = state as GenericError;
        return Center(child: Text("${error.message}\n${error.statusCode}"));
      }
    });
  }

  Container customCard(BuildContext context, GenericState state) {
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
      child: customCardTabView(context, state),
    );
  }

  Column customCardTabView(BuildContext context, GenericState state) {
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
              text:
                  "${widget.restaurant!.packageSettings!.deliveryTimeStart} - ${widget.restaurant!.packageSettings!.deliveryTimeEnd}",
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
              text: LocaleKeys.restaurant_detail_detail_tab_title2,
              style: AppTextStyles.subTitleStyle,
            ),
            subtitle: LocaleText(
              text: widget.restaurant!.packageSettings!.deliveryType == "3"
                  ? "Gel Al Paket - Kapıda Paket"
                  : widget.restaurant!.packageSettings!.deliveryType == "1"
                      ? "Gel Al Paket"
                      : "Kapıda Paket",
              style: AppTextStyles.myInformationBodyTextStyle,
            ),
            //trailing: SvgPicture.asset(ImageConstant.COMMONS_FORWARD_ICON),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(RouteConstant.ABOUT_WORKING_HOUR_VIEW,
                    arguments: ScreenArgumentsRestaurantDetail(
                      restaurant: widget.restaurant!,
                    ));
          },
          child: Container(
            color: AppColors.appBarColor,
            width: context.dynamicWidht(1),
            height: context.dynamicHeight(0.07),
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
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(RouteConstant.STORE_INFO_VIEW,
                arguments: ScreenArgumentsRestaurantDetail(
                  restaurant: widget.restaurant!,
                ));
          },
          child: Container(
            color: AppColors.appBarColor,
            width: context.dynamicWidht(1),
            height: context.dynamicHeight(0.069),
            padding:
                EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.06)),
            child: ListTile(
              contentPadding:
                  EdgeInsets.only(bottom: context.dynamicHeight(0.028)),
              title: LocaleText(
                text: LocaleKeys.restaurant_detail_detail_tab_title5,
                style: AppTextStyles.subTitleStyle,
              ),
              subtitle: LocaleText(
                text: "İşletme Adı " + widget.restaurant!.name!,
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

  Builder buildCategoriesSection(BuildContext context) {
    return Builder(builder: (context) {
      final stateOfCategories = context.watch<CategoryNameCubit>().state;

      if (stateOfCategories is GenericInitial) {
        return Container();
      } else if (stateOfCategories is GenericLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (stateOfCategories is GenericCompleted) {
        List<Result> categoryList = [];
        List<Result> relatedCategories = [];
        for (var i = 0; i < stateOfCategories.response.length; i++) {
          categoryList.add(stateOfCategories.response[i]);
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
            Navigator.of(context).pushNamed(RouteConstant.FOOD_CATEGORIES_VIEW,
                arguments: ScreenArgumentsCategories(
                    categoriesList: relatedCategories));
          },
          child: Container(
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
                text: categoryNames,
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

  ListView tabPackages(BuildContext context, GenericCompleted state) {
    List<Box> boxLists = [];
    for (var i = 0; i < state.response.length; i++) {
      boxLists.add(state.response[i]);
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

    return ListView(
      children: [
        SizedBox(
          height: context.dynamicHeight(0.02),
        ),
        Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 20,
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
                  child: ClippedPasswordRules(
                      child: SingleChildScrollView(
                    child: Text(
                        "Sürpriz Paketler ile alakalı bilgilendirme buraya gelecek"),
                  ))),
            )
          ],
        ),
        SizedBox(height: context.dynamicHeight(0.02)),
        Visibility(
            visible: surpriseBoxes.isEmpty,
            child: Center(
              child: Text('Surpriz paket bulunmamaktadir'),
            )),
        ListView.builder(
          itemCount: surpriseBoxes
              .length, //widget.restaurant!.boxes!.length,//state.response.lenght
          itemBuilder: (context, index) {
            return buildBox(context, index, state, surpriseBoxes);
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
        SizedBox(height: context.dynamicHeight(0.02)),
        Visibility(
            visible: definedBoxess.isEmpty,
            child: Center(
              child: Text('Tanimli paket bulunmamaktadir'),
            )),
        ListView.builder(
          itemCount: definedBoxess.length,
          itemBuilder: (context, index) {
            return buildBox(context, index, state, definedBoxess);
          },
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
        ),
        SizedBox(
          height: 125,
        )
      ],
    );
  }

//parametrs changes
  Container buildDefinedBox(BuildContext context, int index,
      List<Box> definedBoxes, GenericCompleted state) {
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

  Container buildBox(
    BuildContext context,
    int index,
    GenericCompleted state,
    List<Box> surpriseBoxes,
  ) {
    List<String> meals = [];
    if (surpriseBoxes[index].meals!.isNotEmpty) {
      for (var i = 0; i < surpriseBoxes[index].meals!.length; i++) {
        meals.add(surpriseBoxes[index].meals![i].name!);
      }
      mealNames = meals.join(', ');
    }
    return Container(
      //alignment: Alignment(-0.8, 0.0),
      padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.06)),
      width: context.dynamicWidht(1),
      height: context.dynamicHeight(0.15),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: context.dynamicHeight(0.021),
              ),
              Text(
                "${surpriseBoxes[index].textName}",
                style: AppTextStyles.myInformationBodyTextStyle,
              ),
              LocaleText(
                text: surpriseBoxes[index].defined == false
                    ? 'Paketin Tanimlanmasina Kalan Sure : 0'
                    : mealNames,
                style: AppTextStyles.subTitleStyle,
              ),
              SizedBox(height: context.dynamicHeight(0.020)),
              Builder(builder: (context) {
                final GenericState stateOfSearchStore =
                    context.watch<SearchStoreCubit>().state;

                if (stateOfSearchStore is GenericInitial) {
                  return Container();
                } else if (stateOfSearchStore is GenericLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (stateOfSearchStore is GenericCompleted) {
                  List<SearchStore> chosenRestaurat = [];
                  for (var i = 0; i < stateOfSearchStore.response.length; i++) {
                    if (stateOfSearchStore.response[i].id ==
                        state.response[index].store) {
                      chosenRestaurat.add(stateOfSearchStore.response[i]);
                      priceOfMenu = chosenRestaurat[0]
                          .packageSettings!
                          .minDiscountedOrderPrice;
                    }
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: context.dynamicWidht(0.16),
                        height: context.dynamicHeight(0.04),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: context.dynamicWidht(0.01)),
                          child: Text(
                            chosenRestaurat[0]
                                    .packageSettings!
                                    .minOrderPrice
                                    .toString() +
                                " TL",
                            style: AppTextStyles.bodyBoldTextStyle.copyWith(
                                decoration: TextDecoration.lineThrough,
                                color:
                                    AppColors.unSelectedpackageDeliveryColor),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: context.dynamicWidht(0.04),
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
                            chosenRestaurat[0]
                                    .packageSettings!
                                    .minDiscountedOrderPrice
                                    .toString() +
                                " TL",
                            style: AppTextStyles.bodyBoldTextStyle.copyWith(
                              color: AppColors.greenColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                  ;
                } else {
                  final error = stateOfSearchStore as GenericError;
                  return Center(
                      child: Text("${error.message}\n${error.statusCode}"));
                }
              }),
            ],
          ),
          Padding(
            //buy box
            padding: EdgeInsets.only(top: context.dynamicHeight(0.042)),
            child: Builder(
              builder: (context) {
                int menuItem = state.response[index].id;

                final counterState = context.watch<BasketCounterCubit>().state;
                return CustomButton(
                  title: menuList!.contains(menuItem.toString())
                      ? "Sepetimde"
                      : LocaleKeys.restaurant_detail_button_text,
                  color: menuList!.contains(menuItem.toString())
                      ? Colors.transparent
                      : AppColors.greenColor,
                  textColor: menuList!.contains(menuItem.toString())
                      ? AppColors.greenColor
                      : Colors.white,
                  width: context.dynamicWidht(0.28),
                  borderColor: AppColors.greenColor,
                  onPressed: () async {
                    await pressedBuyButton(
                        state, index, context, counterState, menuItem);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> pressedBuyButton(GenericCompleted<dynamic> state, int index,
      BuildContext context, int counterState, int menuItem) async {
    StatusCode statusCode =
        await sl<BasketRepository>().addToBasket("${state.response[index].id}");
    print(statusCode);
    switch (statusCode) {
      case StatusCode.success:
        if (!menuList!.contains(menuItem.toString())) {
          sumOfPricesInt.add(priceOfMenu!);
          context.read<SumPriceOrderCubit>().sumprice(sumOfPricesInt);
          sumOfPricesString.add(sumOfPricesInt.last.toString());
          SharedPrefs.setSumPrice(sumOfPricesString);
          context.read<BasketCounterCubit>().increment();
          SharedPrefs.setCounter(counterState + 1);
          menuList!.add(menuItem.toString());
          SharedPrefs.setMenuList(menuList!);
          print("Successss");
        } else {
          sumOfPricesInt.remove(priceOfMenu!);
          sumOfPricesString.remove(priceOfMenu.toString());
          context.read<SumPriceOrderCubit>().sumprice(sumOfPricesInt);
          SharedPrefs.setSumPrice(sumOfPricesString);
          context
              .read<OrderCubit>()
              .deleteBasket("${state.response[index].id}");
          context.read<BasketCounterCubit>().decrement();
          SharedPrefs.setCounter(counterState - 1);
          menuList!.remove(state.response[index].id.toString());
          SharedPrefs.setMenuList(menuList!);
          print("real Successss");
          print(SharedPrefs.getMenuList);
        }
        break;
      case StatusCode.unauthecticated:
        showDialog(
          context: context,
          builder: (_) => CustomAlertDialog(
              textMessage: 'Giriş yapmalısınız',
              buttonOneTitle: 'Giriş yap',
              buttonTwoTittle: 'Kayıt ol',
              imagePath: ImageConstant.SURPRISE_PACK,
              onPressedOne: () {
                Navigator.of(context).pushNamed(RouteConstant.LOGIN_VIEW);
              },
              onPressedTwo: () {
                Navigator.of(context).pushNamed(RouteConstant.REGISTER_VIEW);
              }),
        );
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
                  sumOfPricesInt.clear();
                  sumOfPricesString.clear();
                  SharedPrefs.setSumPrice([]);
                  context.read<SumPriceOrderCubit>().sumprice([]);

                  menuList!.clear();
                  SharedPrefs.setCounter(0);
                  SharedPrefs.setMenuList([]);
                  context.read<BasketCounterCubit>().setCounter(0);

                  Navigator.pop(context);
                },
                imagePath: ImageConstant.SURPRISE_PACK_ALERT,
                textMessage: 'Farklı restoranın ürününü seçtiniz',
                buttonOneTitle: "Alışverişe devam et",
                buttonTwoTittle: "Sepeti boşalt"));
        print("Errorrr");
    }
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
    List<int> mealPoints = [];
    for (var i = 0; i < widget.restaurant!.review!.length; i++) {
      int mealPoint = widget.restaurant!.review![i].qualityPoint!;
      mealPoints.add(mealPoint);
    }
    int totalMealPoints =
        mealPoints.fold(0, (previousValue, element) => previousValue + element);

    String? avgMealPoint = (totalMealPoints / widget.restaurant!.review!.length)
        .toStringAsFixed(1);
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
    int totalQualityPoints = qualityPoints.fold(
        0, (previousValue, element) => previousValue + element);

    String avgQualityPoint =
        (totalQualityPoints / widget.restaurant!.review!.length)
            .toStringAsFixed(1);
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
          ratingText: qualityPoints.isNotEmpty ? avgQualityPoint : '0.0',
          value: qualityPoints.isNotEmpty
              ? double.parse(avgQualityPoint) / 5
              : 0.0,
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
    int totalServicePoints = servicePoints.fold(
        0, (previousValue, element) => previousValue + element);

    String avgServicePoint =
        (totalServicePoints / widget.restaurant!.review!.length)
            .toStringAsFixed(1);
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
          value: servicePoints.isNotEmpty
              ? double.parse(avgServicePoint) / 5
              : 0.0,
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
        widget.restaurant!.packageSettings!.minDiscountedOrderPrice.toString() +
            " TL",
        textAlign: TextAlign.center,
        style: AppTextStyles.bodyBoldTextStyle
            .copyWith(fontWeight: FontWeight.w700, color: AppColors.greenColor),
      ),
    );
  }

  Text oldPriceText() {
    return Text(
      widget.restaurant!.packageSettings!.minOrderPrice.toString() + " TL",
      style: AppTextStyles.bodyBoldTextStyle.copyWith(
          decoration: TextDecoration.lineThrough,
          color: AppColors.unSelectedpackageDeliveryColor),
    );
  }

  Container packageContainer(BuildContext context, GenericState state) {
    if (state is GenericCompleted) {
      return state.response.length != 0
          ? Container(
              alignment: Alignment(0.0, -0.11),
              width: context.dynamicWidht(0.19),
              height: context.dynamicHeight(0.04),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: AppColors.orangeColor,
              ),
              child: Text(
                "${state.response.length} paket",
                style: AppTextStyles.bodyBoldTextStyle
                    .copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            )
          : Container(
              alignment: Alignment(0.0, -0.11),
              width: context.dynamicWidht(0.19),
              height: context.dynamicHeight(0.04),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: AppColors.yellowColor,
              ),
              child: Text(
                "tükendi",
                style: AppTextStyles.bodyBoldTextStyle
                    .copyWith(color: Colors.white),
                textAlign: TextAlign.center,
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
            "${widget.restaurant!.packageSettings!.deliveryTimeStart!}-${widget.restaurant!.packageSettings!.deliveryTimeEnd}",
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

  Container packageCourierAndFavoriteContainer(
      BuildContext context, GenericState state) {
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
                  color: widget.restaurant!.packageSettings!.deliveryType ==
                              "1" ||
                          widget.restaurant!.packageSettings!.deliveryType ==
                              "3"
                      ? AppColors.greenColor
                      : Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.all(context.dynamicHeight(0.004)),
                  child: SvgPicture.asset(
                    ImageConstant.RESTAURANT_PACKAGE_ICON,
                    color: widget.restaurant!.packageSettings!.deliveryType ==
                                "1" ||
                            widget.restaurant!.packageSettings!.deliveryType ==
                                "3"
                        ? Colors.white
                        : AppColors.unSelectedpackageDeliveryColor,
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
                  color: widget.restaurant!.packageSettings!.deliveryType ==
                              "2" ||
                          widget.restaurant!.packageSettings!.deliveryType ==
                              "3"
                      ? AppColors.greenColor
                      : Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.all(context.dynamicHeight(0.006)),
                  child: SvgPicture.asset(
                    ImageConstant.RESTAURANT_COURIER_ICON,
                    color: widget.restaurant!.packageSettings!.deliveryType ==
                                "2" ||
                            widget.restaurant!.packageSettings!.deliveryType ==
                                "3"
                        ? Colors.white
                        : AppColors.unSelectedpackageDeliveryColor,
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
              Builder(builder: (context) {
                final GenericState stateOfFavorites =
                    context.watch<FavoriteCubit>().state;

                if (stateOfFavorites is GenericInitial) {
                  return Container();
                } else if (stateOfFavorites is GenericLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (stateOfFavorites is GenericCompleted) {
                  for (var i = 0; i < stateOfFavorites.response.length; i++) {
                    if (stateOfFavorites.response[i].id ==
                        widget.restaurant!.id) {
                      isFavourite = true;
                    } else if (stateOfFavorites.response[i].id == null) {
                      isFavourite = false;
                    } else {
                      isFavourite = false;
                    }
                  }
                  return GestureDetector(
                    onTap: () {
                      print('object');
                      print(widget.restaurant!.id);
                      if (isFavourite) {
                        context
                            .read<FavoriteCubit>()
                            .deleteFavorite(widget.restaurant!.id);
                        favouritedRestaurants!
                            .remove(widget.restaurant!.id.toString());
                        SharedPrefs.setFavoriteIdList(favouritedRestaurants!);
                        print(SharedPrefs.getFavorites);
                      } else {
                        context
                            .read<FavoriteCubit>()
                            .addFavorite(widget.restaurant!.id!);
                        favouritedRestaurants!
                            .add(widget.restaurant!.id.toString());
                        SharedPrefs.setFavoriteIdList(favouritedRestaurants!);

                        print(SharedPrefs.getFavorites);
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
                  );
                } else {
                  final error = stateOfFavorites as GenericError;
                  if (error.statusCode == "401") {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RouteConstant.LOGIN_VIEW);
                      },
                      child: SvgPicture.asset(
                        ImageConstant.RESTAURANT_FAVORITE_ICON,
                        color: isFavourite
                            ? AppColors.orangeColor
                            : AppColors.unSelectedpackageDeliveryColor,
                      ),
                    );
                  }
                  return Center(
                      child: Text("${error.message}\n${error.statusCode}"));
                }
              })
            ],
          )
        ],
      ),
    );
  }
}
