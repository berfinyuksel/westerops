import 'dart:async';

import 'package:dongu_mobile/data/model/iyzico_card_model/iyzico_order_model.dart';
import 'package:dongu_mobile/data/model/order_received.dart';
import 'package:dongu_mobile/data/model/search.dart';
import 'package:dongu_mobile/data/model/search_store.dart';
import 'dart:io';
import 'package:device_info/device_info.dart';

import 'package:dongu_mobile/data/services/location_service.dart';
import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/logic/cubits/iyzico_send_request_cubit.dart/iyzico_send_request_cubit.dart';

import 'package:dongu_mobile/logic/cubits/order_cubit/order_received_cubit.dart';
import 'package:dongu_mobile/logic/cubits/order_bar_cubit/order_bar_cubit.dart';
import 'package:dongu_mobile/logic/cubits/padding_values_cubit/category_padding_values_cubit.dart';
import 'package:dongu_mobile/logic/cubits/padding_values_cubit/near_me_padding_values.dart';
import 'package:dongu_mobile/logic/cubits/padding_values_cubit/opportunity_padding_values.dart';
import 'package:dongu_mobile/logic/cubits/search_cubit/search_cubit.dart';
import 'package:dongu_mobile/logic/cubits/search_store_cubit/search_store_cubit.dart';
import 'package:dongu_mobile/presentation/screens/home_page_view/components/near_me_restaurant_list.dart';
import 'package:dongu_mobile/presentation/screens/home_page_view/components/opportunity_restaurant_list_view_widget.dart';

import 'package:dongu_mobile/presentation/screens/home_page_view/components/timer_countdown.dart';

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

  late Timer timer;
  int? durationFinal;

  ScrollController? _controller;
  int? duration;
  String mealNames = "";

  bool visible = true;
  TextEditingController? controller = TextEditingController();
  List<Search> names = [];
  List<Search> filteredNames = [];
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
    buildSharedPrefNoData();

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

  Builder buildBuilderSearch() {
    return Builder(builder: (context) {
      final GenericState stateSearch = context.watch<SearchCubit>().state;

      if (stateSearch is GenericInitial) {
        return Container();
      } else if (stateSearch is GenericLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (stateSearch is GenericCompleted) {
        List<Search> searchList = [];

        for (int i = 0; i < stateSearch.response.length; i++) {
          searchList.add(stateSearch.response[i]);
        }
        names = searchList;
        filteredNames = names;

        return Center(
            child: filteredNames.length == 0
                ? emptySearchHistory()
                : searchListViewBuilder(stateSearch, searchList));
      } else {
        final error = stateSearch as GenericError;
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
            Visibility(
              visible: visible,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: buildRowTitleLeftRightLocation(context,
                    LocaleKeys.home_page_location, LocaleKeys.home_page_edit),
              ),
            ),
            Visibility(
              visible: visible,
              child: Padding(
                padding: EdgeInsets.only(left: 26),
                child: Divider(
                  thickness: 4,
                  color: AppColors.borderAndDividerColor,
                ),
              ),
            ),
            Visibility(
              visible: visible,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 26),
                child: AddressText(),
              ),
            ),
            Visibility(
                visible: visible,
                child: SizedBox(height: context.dynamicHeight(0.03))),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 26),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildSearchBar(context),
                  // Spacer(),
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
            Visibility(visible: true, child: buildBuilderSearch()),
            Visibility(
              visible: visible,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 26),
                child: buildRowTitleLeftRightNearMeAll(context,
                    LocaleKeys.home_page_closer, LocaleKeys.home_page_see_all),
              ),
            ),
            Visibility(
              visible: visible,
              child: Padding(
                padding: EdgeInsets.only(left: 26),
                child: Divider(
                  thickness: 4,
                  color: AppColors.borderAndDividerColor,
                ),
              ),
            ),
            Visibility(
                visible: visible,
                child: SizedBox(height: context.dynamicHeight(0.02))),
            //bool scrool = false;
            Visibility(
              visible: visible,
              child: Padding(
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
            ),
            Visibility(
                visible: visible,
                child: SizedBox(height: context.dynamicHeight(0.04))),
            Visibility(
              visible: visible,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 26),
                child: LocaleText(
                  text: LocaleKeys.home_page_categories,
                  style: AppTextStyles.bodyTitleStyle,
                ),
              ),
            ),
            Visibility(
              visible: visible,
              child: Padding(
                // scroll edildiğinde 0 olacak
                padding: EdgeInsets.only(left: 26),
                child: Divider(
                  thickness: 4,
                  color: AppColors.borderAndDividerColor,
                ),
              ),
            ),
            Visibility(
                visible: visible,
                child: SizedBox(height: context.dynamicHeight(0.01))),
            Visibility(
              visible: visible,
              child: Padding(
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
                    height: context.dynamicHeight(0.18),
                    child: Builder(builder: (context) {
                      final categoryPadding =
                          context.watch<CategoryPaddingCubit>().state;
                      return NotificationListener<ScrollUpdateNotification>(
                          onNotification:
                              (ScrollUpdateNotification notification) {
                            setState(() {
                              if (notification.metrics.pixels <= 0) {
                                scroolCategoriesLeft = true;
                              } else {
                                scroolCategoriesLeft = false;
                              }
                              if (notification.metrics.pixels >=
                                  categoryPadding) {
                                scroolCategoriesRight = true;
                              } else {
                                scroolCategoriesRight = false;
                              }
                            });
                            return true;
                          },
                          child: CustomHorizontalListCategory());
                    })),
              ),
            ),
            Visibility(
              visible: visible,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 26),
                child: LocaleText(
                  text: LocaleKeys.home_page_opportunities,
                  style: AppTextStyles.bodyTitleStyle,
                ),
              ),
            ),
            Visibility(
              visible: visible,
              child: Padding(
                padding: EdgeInsets.only(left: 26),
                child: Divider(
                  thickness: 4,
                  color: AppColors.borderAndDividerColor,
                ),
              ),
            ),
            Visibility(
                visible: visible,
                child: SizedBox(height: context.dynamicHeight(0.01))),
            Visibility(
              visible: visible,
              child: Padding(
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
            ),
            Visibility(
                visible: visible,
                child: SizedBox(height: context.dynamicHeight(0.01))),
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
        List<IyzcoOrderCreate> orderInfoTotal = [];
        List<IyzcoOrderCreate> orderInfo = [];

        for (var i = 0; i < stateOfOrder.response.length; i++) {
          orderInfoTotal.add(stateOfOrder.response[i]);
        }
        for (var i = 0; i < orderInfoTotal.length; i++) {
          if (SharedPrefs.getOrderRefCode == orderInfoTotal[i].refCode) {
            orderInfo.add(orderInfoTotal[i]);
          }
        }

        return orderInfo.isNotEmpty
            ? GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(RouteConstant.PAST_ORDER_DETAIL_VIEW,
                          arguments: ScreenArgumentsRestaurantDetail(
                            orderInfo: orderInfo.first,
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
                            text: LocaleKeys.home_page_active_order,
                            style: AppTextStyles.subTitleBoldStyle,
                          ),
                          LocaleText(
                            text:
                                '${orderInfo.first.address!.name} - ${orderInfo.first.buyingTime!.toLocal().day}.${orderInfo.first.buyingTime!.toLocal().month}.${orderInfo.first.buyingTime!.toLocal().year}',
                            style: AppTextStyles.subTitleBoldStyle,
                          ),
                          LocaleText(
                            text: orderInfo.first.boxes!.isNotEmpty
                                ? orderInfo.first.boxes![0].store!.name
                                : '',
                            style: AppTextStyles.bodyBoldTextStyle
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: orderInfo.first.boxes!.isNotEmpty,
                        child: countdown(orderInfo),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin:
                            EdgeInsets.only(left: context.dynamicWidht(0.01)),
                        width: 69,
                        height: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: AppColors.scaffoldBackgroundColor,
                        ),
                        child: Text(
                          '${orderInfo.first.cost} TL',
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
              )
            : SizedBox(height: 0, width: 0);
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
      child: Builder(builder: (context) {
        double valueOfPaddingForNearMe =
            context.watch<NearMePaddingCubit>().state;
        return NotificationListener<ScrollUpdateNotification>(
            onNotification: (ScrollUpdateNotification notification) {
              setState(() {});
              print(valueOfPaddingForNearMe);
              print("AAAAA");
              print(notification.metrics.pixels);
              if (notification.metrics.pixels <= 0) {
                scroolNearMeLeft = true;
              } else {
                scroolNearMeLeft = false;
              }
              if (notification.metrics.pixels >= valueOfPaddingForNearMe) {
                scroolNearMeRight = true;
              } else {
                scroolNearMeRight = false;
              }
              return true;
            },
            child: NearMeRestaurantListViewWidget(
                restaurants: restaurants, controller: _controller));
      }),
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
      child: Builder(builder: (context) {
        double valueOfPaddingForOpportunity =
            context.watch<OpportunityPaddingCubit>().state;
        return NotificationListener<ScrollUpdateNotification>(
            onNotification: (ScrollUpdateNotification notification) {
              setState(() {
                if (notification.metrics.pixels <= 0) {
                  scroolOpportunitiesLeft = true;
                } else {
                  scroolOpportunitiesLeft = false;
                }
                if (notification.metrics.pixels >=
                    valueOfPaddingForOpportunity) {
                  scroolOpportunitiesRight = true;
                } else {
                  scroolOpportunitiesRight = false;
                }
              });

              return true;
            },
            child: OpportunityRestaurantListViewWidget(
                restaurants: restaurants, controller: _controller));
      }),
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
        inputFormatters: [
          //  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
          FilteringTextInputFormatter.singleLineFormatter,
        ],
        onChanged: (value) {
          context.read<SearchCubit>().getSearches(controller!.text);
        },
        onTap: () {
          setState(() {
            visible = !visible;
          });
        },
        controller: controller,
      ),
    );
  }

  emptySearchHistory() {
    return Container(
      height: context.dynamicHeight(0.05),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 25),
        child: LocaleText(
            text: LocaleKeys.search_search_history_clean,
            style: AppTextStyles.bodyTextStyle
                .copyWith(color: AppColors.cursorColor)),
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

  Widget countdown(List<IyzcoOrderCreate> orderInfo) {
    List<int> itemsOfCountDown = buildDurationForCountdown(
        DateTime.now(),
        orderInfo.first.boxes!.isNotEmpty
            ? orderInfo.first.boxes!.first.saleDay!.endDate!.toLocal()
            : orderInfo.first.buyingTime!.toLocal());
    int hour = itemsOfCountDown[0];
    int minute = itemsOfCountDown[1];
    int second = itemsOfCountDown[2];
    return TimerCountDown(
        hour: hour,
        minute: minute,
        second: second,
        textStyle:
            AppTextStyles.bodyBoldTextStyle.copyWith(color: Colors.white));
  }

  List<int> buildDurationForCountdown(DateTime dateTime, DateTime local) {
    List<int> results = [];
    int durationOfNow = buildDurationSecondsForDateTimes(dateTime);
    int durationOfEnd = buildDurationSecondsForDateTimes(local);

    durationFinal = durationOfEnd - durationOfNow;
    int hourOfitem = (durationFinal! ~/ (60 * 60));
    results.add(hourOfitem);
    int minuteOfitem = (durationFinal! - (hourOfitem * 60 * 60)) ~/ 60;
    results.add(minuteOfitem);

    int secondOfitem =
        (durationFinal! - (minuteOfitem * 60) - (hourOfitem * 60 * 60));
    results.add(secondOfitem);

    return results;
  }

  int buildDurationSecondsForDateTimes(DateTime dateTime) {
    int hourOfItem = dateTime.hour;
    int minuteOfitem = dateTime.minute;
    int secondsOfitem = dateTime.second;
    int durationOfitems =
        ((hourOfItem * 60 * 60) + (minuteOfitem * 60) + (secondsOfitem));
    return durationOfitems;
  }

  ListView searchListViewBuilder(
      GenericState stateSearch, List<Search> searchList) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: searchList.isEmpty ||
                controller!.text.isEmpty ||
                filteredNames.isEmpty
            ? 0
            : filteredNames.length,
        itemBuilder: (context, index) {
          List<String> meals = [];

          if (filteredNames[index].storeMeals == null) {
            return Text("Aradığınız isimde bir yemek bulunmamaktadır.");
          } else if (filteredNames[index].storeMeals != null) {
            for (var i = 0; i < filteredNames[index].storeMeals!.length; i++) {
              meals.add(filteredNames[index].storeMeals![i].name!);
            }
            mealNames = meals.join(', ');
          }
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.dynamicWidht(0.06),
              // vertical: context.dynamicHeight(0.00006)
            ),
            decoration: BoxDecoration(color: Colors.white),
            child: ListTile(
              trailing: SvgPicture.asset(ImageConstant.COMMONS_FORWARD_ICON),

              // leading: Image.network(
              //   searches.urlImage,
              //   fit: BoxFit.cover,
              //   width: 50,
              //   height: 50,
              // ),
              title: Text("${filteredNames[index].name}".isEmpty ||
                      searchList.isEmpty ||
                      filteredNames.isEmpty
                  ? ""
                  : "${filteredNames[index].name}"),
              subtitle: Text(mealNames.isEmpty ||
                      searchList.isEmpty ||
                      filteredNames.isEmpty
                  ? ""
                  : mealNames),
            ),
          );
        });
  }

  void buildSharedPrefNoData() {
    SharedPrefs.setCardRegisterBool(false);
    SharedPrefs.setThreeDBool(false);
    SharedPrefs.setCardAlias("");
    SharedPrefs.setCardHolderName("");
    SharedPrefs.setCardNumber("");
    SharedPrefs.setExpireMonth("");
    SharedPrefs.setExpireYear("");
    SharedPrefs.setCVC("");
    SharedPrefs.setConversationId("");
    SharedPrefs.setBoolForRegisteredCard(false);
    SharedPrefs.setCardToken("");
  }
}
