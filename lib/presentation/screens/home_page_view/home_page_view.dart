import 'package:dongu_mobile/data/model/search_store.dart';
import 'dart:io';
import 'package:device_info/device_info.dart';

import 'package:dongu_mobile/data/services/location_service.dart';
import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/logic/cubits/box_cubit/box_cubit.dart';
import 'package:dongu_mobile/logic/cubits/search_store_cubit/search_store_cubit.dart';
import 'package:dongu_mobile/logic/cubits/store_boxes_cubit/store_boxes_cubit.dart';
import 'package:dongu_mobile/presentation/screens/home_page_view/components/order_status_bar.dart';
import 'package:dongu_mobile/utils/haversine.dart';

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
                visible: SharedPrefs.getOrderBar, child: OrderStatusBar()),
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
                          if (notification.metrics.pixels >= 338) {
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
          ],
        );
      }),
    );
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
                      restaurants[index],
                    ));
              },
              child: RestaurantInfoCard(
                restaurantId: restaurants[index].id,
                courierPackageBGColor:
                    restaurants[index].packageSettings!.deliveryType == "2" ||
                            restaurants[index].packageSettings!.deliveryType ==
                                "3"
                        ? AppColors.greenColor
                        : Colors.white,
                courierPackageIconColor:
                    restaurants[index].packageSettings!.deliveryType == "2" ||
                            restaurants[index].packageSettings!.deliveryType ==
                                "3"
                        ? Colors.white
                        : AppColors.unSelectedpackageDeliveryColor,
                getItPackageBGColor:
                    restaurants[index].packageSettings!.deliveryType == "1" ||
                            restaurants[index].packageSettings!.deliveryType ==
                                "3"
                        ? AppColors.greenColor
                        : Colors.white,
                getItPackageIconColor:
                    restaurants[index].packageSettings!.deliveryType == "1" ||
                            restaurants[index].packageSettings!.deliveryType ==
                                "3"
                        ? Colors.white
                        : AppColors.unSelectedpackageDeliveryColor,
                minDiscountedOrderPrice:
                    restaurants[index].packageSettings?.minDiscountedOrderPrice,
                minOrderPrice:
                    restaurants[index].packageSettings?.minOrderPrice,
                restaurantIcon: restaurants[index].photo,
                backgroundImage: restaurants[index].background,
                packetNumber: "3 paket",
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
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            width: context.dynamicWidht(0.04),
          ),
        ),
      ),
    );
  }

  Container buildListViewOpportunities(BuildContext context,
      List<SearchStore> restaurants, List<double> distances) {
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
                      restaurants[index],
                    ));
              },
              child: Builder(builder: (context) {
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
                  packetNumber: 0 == 0 ? 'tükendi' : '4 paket',
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
}
