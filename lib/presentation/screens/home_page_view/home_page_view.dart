import 'package:date_time_format/date_time_format.dart';
import 'package:dongu_mobile/data/model/category_name.dart';
import 'package:dongu_mobile/data/model/order_received.dart';
import 'package:dongu_mobile/data/model/search_store.dart';
import 'dart:io';
import 'package:device_info/device_info.dart';

import 'package:dongu_mobile/data/services/location_service.dart';
import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/logic/cubits/box_cubit/box_cubit.dart';
import 'package:dongu_mobile/logic/cubits/order_cubit/order_received_cubit.dart';
import 'package:dongu_mobile/logic/cubits/order_bar_cubit/order_bar_cubit.dart';
import 'package:dongu_mobile/logic/cubits/search_store_cubit/search_store_cubit.dart';
import 'package:dongu_mobile/logic/cubits/store_boxes_cubit/store_boxes_cubit.dart';
import 'package:dongu_mobile/presentation/widgets/restaurant_info_list_tile/first_column/packet_number.dart';

import 'package:dongu_mobile/utils/haversine.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../logic/cubits/generic_state/generic_state.dart';

import '../../../utils/constants/image_constant.dart';
import '../../../utils/constants/route_constant.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/restaurant_info_card/restaurant_info_card.dart';
import '../../widgets/text/locale_text.dart';
import '../my_favorites_view/components/address_text.dart';
import '../restaurant_details_views/screen_arguments/screen_arguments.dart';
import '../search_view/components/horizontal_list_category_bar.dart';
import '../../../utils/extensions/string_extension.dart';

class HomePageView extends StatefulWidget {
  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  bool scroolNearMeLeft = true;
  bool scroolNearMeRight = false;

  bool scroolCategoriesLeft = true;
  bool scroolCategoriesRight = false;

  bool scroolOpportunitiesLeft = true;
  bool scroolOpportunitiesRight = false;

  ScrollController? _controller;
  int? duration;

  @override
  void initState() {
    super.initState();
    context.read<SearchStoreCubit>().getSearchStore();
    LocationService.getCurrentLocation();
    getDeviceIdentifier();
  }

  Future<List<String>> getDeviceIdentifier() async {
    String? identifier;
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;

        identifier = build.androidId;
        print(identifier); //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        identifier = data.identifierForVendor; //UUID for iOS
      }
    } on PlatformException {
      print('Failed to get platform version');
    }
    return [identifier!];
  }

  @override
  Widget build(BuildContext context) {
    return buildBuilder();
  }

  Builder buildBuilder() {
    return Builder(builder: (context) {
      final GenericState state = context.watch<SearchStoreCubit>().state;

      //final FiltersState filterState = context.watch<FiltersCubit>().state;

      if (state is GenericInitial) {
        return Container();
      } else if (state is GenericLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (state is GenericCompleted) {
        List<SearchStore> restaurants = [];
        List<double> distances = [];

        for (int i = 0; i < state.response.length; i++) {
          restaurants.add(state.response[i]);
        }

        return Center(child: buildBody(context, restaurants, distances, state));
      } else {
        final error = state as GenericError;
        return Center(child: Text("${error.message}\n${error.statusCode}"));
      }
    });
  }

  GestureDetector buildBody(BuildContext context, List<SearchStore> restaurants,
      List<double> distances, GenericCompleted state) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Builder(builder: (context) {
        return ListView(
          children: [
            Visibility(
                visible: context.watch<OrderBarCubit>().state,
                child: buildOrderStatusBar()),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: buildRowTitleLeftRightLocation(context,
                  LocaleKeys.home_page_location, LocaleKeys.home_page_edit),
            ),
            Padding(
              padding: EdgeInsets.only(left: 26),
              child: Divider(
                thickness: 4,
                color: AppColors.borderAndDividerColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 26),
              child: AddressText(),
            ),
            SizedBox(height: context.dynamicHeight(0.03)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 26),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildSearchBar(context),
                  Spacer(),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RouteConstant.FILTER_VIEW);
                      },
                      child:
                          SvgPicture.asset(ImageConstant.COMMONS_FILTER_ICON)),
                ],
              ),
            ),
            SizedBox(height: context.dynamicHeight(0.03)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 26),
              child: buildRowTitleLeftRightNearMeAll(context,
                  LocaleKeys.home_page_closer, LocaleKeys.home_page_see_all),
            ),
            Padding(
              padding: EdgeInsets.only(left: 26),
              child: Divider(
                thickness: 4,
                color: AppColors.borderAndDividerColor,
              ),
            ),
            SizedBox(height: context.dynamicHeight(0.02)),
            //bool scrool = false;
            Padding(
              padding: scroolNearMeLeft == true
                  ? EdgeInsets.only(
                      left: 26,
                      right: 0,
                    )
                  : scroolNearMeRight == true
                      ? EdgeInsets.only(
                          left: 0,
                          right: 26,
                        )
                      : EdgeInsets.only(),
              child:
                  buildListViewNearMe(context, restaurants, distances, state),
            ),
            SizedBox(height: context.dynamicHeight(0.04)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 26),
              child: LocaleText(
                text: LocaleKeys.home_page_categories,
                style: AppTextStyles.bodyTitleStyle,
              ),
            ),
            Padding(
              // scroll edildiğinde 0 olacak
              padding: EdgeInsets.only(left: 26),
              child: Divider(
                thickness: 4,
                color: AppColors.borderAndDividerColor,
              ),
            ),
            SizedBox(height: context.dynamicHeight(0.01)),
            Padding(
              padding: scroolCategoriesLeft == true
                  ? EdgeInsets.only(
                      left: 26,
                      right: 0,
                    )
                  : scroolCategoriesRight == true
                      ? EdgeInsets.only(
                          left: 0,
                          right: 26,
                        )
                      : EdgeInsets.only(),
              child: Container(
                  height: context.dynamicHeight(0.16),
                  child: NotificationListener<ScrollUpdateNotification>(
                      onNotification: (ScrollUpdateNotification notification) {
                        setState(() {
                          if (notification.metrics.pixels <= 0) {
                            scroolCategoriesLeft = true;
                          } else {
                            scroolCategoriesLeft = false;
                          }
                          if (notification.metrics.pixels >= 91) {
                            scroolCategoriesRight = true;
                          } else {
                            scroolCategoriesRight = false;
                          }
                        });

                        return true;
                      },
                      child: CustomHorizontalListCategory())),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 26),
              child: LocaleText(
                text: LocaleKeys.home_page_opportunities,
                style: AppTextStyles.bodyTitleStyle,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 26),
              child: Divider(
                thickness: 4,
                color: AppColors.borderAndDividerColor,
              ),
            ),
            SizedBox(height: context.dynamicHeight(0.01)),
            Padding(
              padding: scroolOpportunitiesLeft == true
                  ? EdgeInsets.only(
                      left: 26,
                      right: 0,
                    )
                  : scroolOpportunitiesRight == true
                      ? EdgeInsets.only(
                          left: 0,
                          right: 26,
                        )
                      : EdgeInsets.only(),
              child:
                  buildListViewOpportunities(context, restaurants, distances),
            ),
            SizedBox(height: context.dynamicHeight(0.01)),
          ],
        );
      }),
    );
  }

  Widget buildOrderStatusBar() {
    return Builder(builder: (context) {
      final stateOfOrder = context.watch<OrderReceivedCubit>().state;

      if (stateOfOrder is GenericInitial) {
        return Container();
      } else if (stateOfOrder is GenericLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (stateOfOrder is GenericCompleted) {
        List<OrderReceived> orderInfo = [];
        for (var i = 0; i < stateOfOrder.response.length; i++) {
          orderInfo.add(stateOfOrder.response[i]);
        }

        return GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(RouteConstant.PAST_ORDER_DETAIL_VIEW,
                    arguments: ScreenArgumentsRestaurantDetail(
                      orderInfo: orderInfo.last,
                    ));
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            height: 93,
            color: AppColors.greenColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    LocaleText(
                      text: 'Aktif Siparişin',
                      style: AppTextStyles.subTitleBoldStyle,
                    ),
                    LocaleText(
                      text:
                          '${orderInfo.last.address!.name} - ${orderInfo.last.buyingTime!.format(EuropeanDateFormats.standard)}',
                      style: AppTextStyles.subTitleBoldStyle,
                    ),
                    LocaleText(
                      text: orderInfo.last.boxes![0].store!.name,
                      style: AppTextStyles.bodyBoldTextStyle
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
                buildCountDown(context),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: context.dynamicWidht(0.01)),
                  width: 69,
                  height: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: AppColors.scaffoldBackgroundColor,
                  ),
                  child: Text(
                    '${orderInfo.last.cost} TL',
                    style: AppTextStyles.bodyBoldTextStyle
                        .copyWith(color: AppColors.greenColor),
                  ),
                ),
                SvgPicture.asset(
                  ImageConstant.COMMONS_FORWARD_ICON,
                  fit: BoxFit.fitWidth,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        );
      } else {
        final error = stateOfOrder as GenericError;
        return Center(child: Text("${error.message}\n${error.statusCode}"));
      }
    });
  }

  Container buildListViewNearMe(
      BuildContext context,
      List<SearchStore> restaurants,
      List<double> distances,
      GenericCompleted state) {
    return Container(
      width: context.dynamicWidht(0.64),
      height: context.dynamicHeight(0.29),
      child: NotificationListener<ScrollUpdateNotification>(
        onNotification: (ScrollUpdateNotification notification) {
          setState(() {});
          if (notification.metrics.pixels <= 0) {
            scroolNearMeLeft = true;
          } else {
            scroolNearMeLeft = false;
          }
          if (notification.metrics.pixels >= 630) {
            scroolNearMeRight = true;
          } else {
            scroolNearMeRight = false;
          }
          return true;
        },
        child: ListView.separated(
          //padding: EdgeInsets.symmetric(horizontal: 20),
          controller: _controller,
          itemCount: restaurants.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RouteConstant.RESTAURANT_DETAIL,
                    arguments: ScreenArgumentsRestaurantDetail(
                      restaurant: restaurants[index],
                    ));
              },
              child: Builder(builder: (context) {
                String? packettNumber() {
                  if (restaurants[index].calendar == null) {
                    return "tükendi";
                  } else if (restaurants[index].calendar != null) {
                    for (int i = 0;
                        i < restaurants[index].calendar!.length;
                        i++) {
                      var boxcount = restaurants[index].calendar![i].boxCount;

                      String now = DateTime.now().toIso8601String();
                      List<String> currentDate = now.split("T").toList();
                      print(currentDate[0]);
                      List<String> startDate = restaurants[index]
                          .calendar![i]
                          .startDate!
                          .split("T")
                          .toList();

                      if (currentDate[0] == startDate[0]) {
                        if (restaurants[index].calendar![i].boxCount != 0) {
                          return "${boxcount.toString()} paket";
                        } else if (restaurants[index].calendar![i].boxCount ==
                                null ||
                            restaurants[index].calendar![i].boxCount == 0) {
                          return "tükendi";
                        }
                      }
                    }
                  }
                }

                return RestaurantInfoCard(
                  restaurantId: restaurants[index].id,
                  courierPackageBGColor:
                      restaurants[index].packageSettings!.deliveryType == "2" ||
                              restaurants[index]
                                      .packageSettings!
                                      .deliveryType ==
                                  "3"
                          ? AppColors.greenColor
                          : Colors.white,
                  courierPackageIconColor:
                      restaurants[index].packageSettings!.deliveryType == "2" ||
                              restaurants[index]
                                      .packageSettings!
                                      .deliveryType ==
                                  "3"
                          ? Colors.white
                          : AppColors.unSelectedpackageDeliveryColor,
                  getItPackageBGColor:
                      restaurants[index].packageSettings!.deliveryType == "1" ||
                              restaurants[index]
                                      .packageSettings!
                                      .deliveryType ==
                                  "3"
                          ? AppColors.greenColor
                          : Colors.white,
                  getItPackageIconColor:
                      restaurants[index].packageSettings!.deliveryType == "1" ||
                              restaurants[index]
                                      .packageSettings!
                                      .deliveryType ==
                                  "3"
                          ? Colors.white
                          : AppColors.unSelectedpackageDeliveryColor,
                  minDiscountedOrderPrice: restaurants[index]
                      .packageSettings
                      ?.minDiscountedOrderPrice,
                  minOrderPrice:
                      restaurants[index].packageSettings?.minOrderPrice,
                  restaurantIcon: restaurants[index].photo,
                  backgroundImage: restaurants[index].background,
                  packetNumber: packettNumber() ?? "tükendi",
                  restaurantName: restaurants[index].name,
                  grade: restaurants[index].avgReview!.toStringAsFixed(1),
                  location: restaurants[index].city,
                  distance: Haversine.distance(
                          restaurants[index].latitude!,
                          restaurants[index].longitude,
                          LocationService.latitude,
                          LocationService.longitude)
                      .toString(),
                  availableTime:
                      '${restaurants[index].packageSettings?.deliveryTimeStart}-${restaurants[index].packageSettings?.deliveryTimeEnd}',
                );
              }),
            );
          },
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            width: context.dynamicWidht(0.04),
          ),
        ),
      ),
    );
  }

  Container buildListViewOpportunities(
    BuildContext context,
    List<SearchStore> restaurants,
    List<double> distances,
  ) {
    return Container(
      width: context.dynamicWidht(0.64),
      height: context.dynamicHeight(0.29),
      child: NotificationListener<ScrollUpdateNotification>(
        onNotification: (ScrollUpdateNotification notification) {
          setState(() {
            if (notification.metrics.pixels <= 0) {
              scroolOpportunitiesLeft = true;
            } else {
              scroolOpportunitiesLeft = false;
            }
            if (notification.metrics.pixels >= 630) {
              scroolOpportunitiesRight = true;
            } else {
              scroolOpportunitiesRight = false;
            }
          });

          return true;
        },
        child: ListView.separated(
          //padding: EdgeInsets.symmetric(horizontal: 20),
          controller: _controller,
          itemCount: restaurants.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RouteConstant.RESTAURANT_DETAIL,
                    arguments: ScreenArgumentsRestaurantDetail(
                      restaurant: restaurants[index],
                    ));
              },
              child: Builder(builder: (context) {
                String? packettNumber() {
                  if (restaurants[index].calendar == null) {
                    //calendar dizisi boş ise tükendi yazdırsın
                    return "tükendi";
                  } else if (restaurants[index].calendar != null) {
                    //calendar dizisi boş değilse aşağıdaki kodlar çalışsın
                    for (int i = 0;
                        i < restaurants[index].calendar!.length;
                        i++) {
                      var boxcount = restaurants[index].calendar![i].boxCount;

                      String now = DateTime.now().toIso8601String();
                      List<String> currentDate = now.split("T").toList();
                      print(currentDate[0]);
                      List<String> startDate = restaurants[index]
                          .calendar![i]
                          .startDate!
                          .split("T")
                          .toList();

                      if (currentDate[0] == startDate[0]) {
                        if (restaurants[index].calendar![i].boxCount != 0) {
                          return "${boxcount.toString()} paket";
                        } else if (restaurants[index].calendar![i].boxCount ==
                                null ||
                            restaurants[index].calendar![i].boxCount == 0) {
                          return "tükendi";
                        }
                      }
                    }
                  }
                }

                return RestaurantInfoCard(
                  restaurantId: restaurants[index].id,
                  courierPackageBGColor:
                      restaurants[index].packageSettings!.deliveryType == "2" ||
                              restaurants[index]
                                      .packageSettings!
                                      .deliveryType ==
                                  "3"
                          ? AppColors.greenColor
                          : Colors.white,
                  courierPackageIconColor:
                      restaurants[index].packageSettings!.deliveryType == "2" ||
                              restaurants[index]
                                      .packageSettings!
                                      .deliveryType ==
                                  "3"
                          ? Colors.white
                          : AppColors.unSelectedpackageDeliveryColor,
                  getItPackageBGColor:
                      restaurants[index].packageSettings!.deliveryType == "1" ||
                              restaurants[index]
                                      .packageSettings!
                                      .deliveryType ==
                                  "3"
                          ? AppColors.greenColor
                          : Colors.white,
                  getItPackageIconColor:
                      restaurants[index].packageSettings!.deliveryType == "1" ||
                              restaurants[index]
                                      .packageSettings!
                                      .deliveryType ==
                                  "3"
                          ? Colors.white
                          : AppColors.unSelectedpackageDeliveryColor,
                  minDiscountedOrderPrice: restaurants[index]
                      .packageSettings
                      ?.minDiscountedOrderPrice,
                  minOrderPrice:
                      restaurants[index].packageSettings?.minOrderPrice,
                  restaurantIcon: restaurants[index].photo,
                  backgroundImage: restaurants[index].background,
                  packetNumber: packettNumber() ?? "tükendi",
                  restaurantName: restaurants[index].name,
                  grade: restaurants[index].avgReview!.toStringAsFixed(1),
                  location: restaurants[index].city,
                  distance: Haversine.distance(
                          restaurants[index].latitude!,
                          restaurants[index].longitude,
                          LocationService.latitude,
                          LocationService.longitude)
                      .toString(),
                  availableTime:
                      '${restaurants[index].packageSettings?.deliveryTimeStart}-${restaurants[index].packageSettings?.deliveryTimeEnd}',
                );
              }),
            );
          },
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            width: context.dynamicWidht(0.04),
          ),
        ),
      ),
    );
  }

  Row buildRowTitleLeftRightLocation(
      BuildContext context, String titleLeft, String titleRight) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LocaleText(
          text: titleLeft,
          style: AppTextStyles.bodyTitleStyle,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, RouteConstant.ADDRESS_FROM_MAP_VIEW);
          },
          child: LocaleText(
            text: titleRight,
            style: GoogleFonts.montserrat(
              fontSize: 12.0,
              color: AppColors.orangeColor,
              fontWeight: FontWeight.w600,
              height: 2.0,
            ),
            alignment: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Row buildRowTitleLeftRightNearMeAll(
      BuildContext context, String titleLeft, String titleRight) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LocaleText(
          text: titleLeft,
          style: AppTextStyles.bodyTitleStyle,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, RouteConstant.MY_NEAR_VIEW);
          },
          child: LocaleText(
            text: titleRight,
            style: GoogleFonts.montserrat(
              fontSize: 12.0,
              color: AppColors.orangeColor,
              fontWeight: FontWeight.w600,
              height: 2.0,
            ),
            alignment: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Container buildSearchBar(BuildContext context) {
    return Container(
      width: context.dynamicWidht(0.72),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(25.0),
          left: Radius.circular(4.0),
        ),
        color: Colors.white,
      ),
      child: TextFormField(
        cursorColor: AppColors.cursorColor,
        style: AppTextStyles.bodyTextStyle,
        decoration: InputDecoration(
            suffixIcon: SvgPicture.asset(
              ImageConstant.COMMONS_SEARCH_ICON,
            ),
            border: buildOutlineInputBorder(),
            focusedBorder: buildOutlineInputBorder(),
            enabledBorder: buildOutlineInputBorder(),
            errorBorder: buildOutlineInputBorder(),
            disabledBorder: buildOutlineInputBorder(),
            contentPadding: EdgeInsets.only(left: context.dynamicWidht(0.046)),
            hintText: LocaleKeys.my_near_hint_text.locale),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.horizontal(
        right: Radius.circular(25.0),
        left: Radius.circular(4.0),
      ),
      borderSide: BorderSide(
        width: 2.0,
        color: AppColors.borderAndDividerColor,
      ),
    );
  }

  Text buildCountDown(BuildContext context) {
    List<int> timeNowHourCompo = buildTimeNow();
    String cachedTimeForDelivery = SharedPrefs.getCountDownString;
    List<String> cachedTimeForDeliveryStringList =
        cachedTimeForDelivery.split(":").toList();
    cachedTimeForDeliveryStringList.add("00");
    print(cachedTimeForDeliveryStringList);
    List<int> cachedTimeForDeliveryIntList = [];
    for (var i = 0; i < cachedTimeForDeliveryStringList.length; i++) {
      cachedTimeForDeliveryIntList
          .add(int.parse(cachedTimeForDeliveryStringList[i]));
    }

    int hour = (cachedTimeForDeliveryIntList[0] - timeNowHourCompo[0]);
    int minute = (cachedTimeForDeliveryIntList[1] - timeNowHourCompo[1]);
    int second = (cachedTimeForDeliveryIntList[2] - timeNowHourCompo[2]);
    int duration = ((hour * 60 * 60) + (minute * 60) + (second));
    int mathedHour = (duration ~/ (60 * 60));
    int mathedMinute = (duration - (mathedHour * 60 * 60)) ~/ 60;

    int mathedSeconds =
        (duration - (mathedMinute * 60) - (mathedHour * 60 * 60));
    if (duration <= 0) {
      context.read<OrderBarCubit>().stateOfBar(false);
    }
    String countDown =
        '${mathedHour < 10 ? "0$mathedHour" : "$mathedHour"}:${mathedMinute < 10 ? "0$mathedMinute" : "$mathedMinute"}:${mathedSeconds < 10 ? "0$mathedSeconds" : "$mathedSeconds"}';
    return Text(
      countDown,
      style: AppTextStyles.subTitleBoldStyle,
    );
  }

  List<int> buildTimeNow() {
    String timeNow = DateTime.now().toIso8601String();
    List<String> timeNowList = timeNow.split("T").toList();
    List<String> timeNowHourList = timeNowList[1].split(".").toList();
    List<String> timeNowComponentsList = timeNowHourList[0].split(":").toList();
    List<int> timeNowHourComponentList = [];

    timeNowComponentsList.forEach((e) {
      timeNowHourComponentList.add(int.parse(e));
    });
    return timeNowHourComponentList;
  }
}
