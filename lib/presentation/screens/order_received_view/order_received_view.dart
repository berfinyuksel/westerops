import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dongu_mobile/data/model/search_store.dart';
import 'package:dongu_mobile/logic/cubits/iyzico_send_request_cubit.dart/iyzico_send_request_cubit.dart';
import 'package:dongu_mobile/logic/cubits/search_store_cubit/search_store_cubit.dart';
import 'package:dongu_mobile/presentation/screens/home_page_view/components/timer_countdown.dart';

import 'package:dongu_mobile/presentation/screens/restaurant_details_views/screen_arguments/screen_arguments.dart';
import 'package:dongu_mobile/presentation/widgets/circular_progress_indicator/custom_circular_progress_indicator.dart';
import 'package:dongu_mobile/utils/haversine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart';

import '../../../data/model/order_received.dart';
import '../../../data/services/local_notifications/local_notifications_service/local_notifications_service.dart';
import '../../../data/services/location_service.dart';
import '../../../data/shared/shared_prefs.dart';
import '../../../logic/cubits/generic_state/generic_state.dart';
import '../../../logic/cubits/order_bar_cubit/order_bar_cubit.dart';
import '../../../logic/cubits/payment_cubit/payment_cubit.dart';
import '../../../utils/constants/image_constant.dart';
import '../../../utils/constants/route_constant.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/extensions/string_extension.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/restaurant_info_list_tile/restaurant_info_list_tile.dart';
import '../../widgets/text/locale_text.dart';
import '../payment_views/payment_address_view/components/get_it_address_list_tile.dart';
import 'components/order_summary_container.dart';

class OrderReceivedView extends StatefulWidget {
  @override
  _OrderReceivedViewState createState() => _OrderReceivedViewState();
}

class _OrderReceivedViewState extends State<OrderReceivedView> {
  late Timer timer;
  int durationFinal = 10;
  bool isShowBottomInfo = false;

  double latitude = 0;
  double longitude = 0;
  late Completer<GoogleMapController> _mapController;
  Map<MarkerId, Marker> markers = Map<MarkerId, Marker>();
  late BitmapDescriptor markerIcon;
  late BitmapDescriptor restaurantMarkerIcon;
  late BitmapDescriptor restaurantSoldoutMarkerIcon;
  final MarkerId markerId = MarkerId("my_location");
  final MarkerId restaurantMarkerId = MarkerId("rest_1");
  int hour = 0;
  int minute = 0;
  int second = 0;
  @override
  void initState() {
    super.initState();
    listenNotifications();
  }

  void listenNotifications() {
    NotificationService.onNotification.stream.listen(onClickedNotification);
  }

  void onClickedNotification(String? payload) {
    Navigator.of(context).pushNamed(RouteConstant.SURPRISE_PACK_VIEW);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }

  Builder buildBody(BuildContext context) {
    return Builder(builder: (context) {
      final GenericState state = context.watch<SendRequestCubit>().state;

      if (state is GenericInitial) {
        print("ORDER INITIAL");
        return Container();
      } else if (state is GenericLoading) {
        print("ORDER LOADING");

        return Center(child: CustomCircularProgressIndicator());
      } else if (state is GenericCompleted) {
        print("ORDER COMPLETED");

        OrderReceived? orderInfo;

        for (var i = 0; i < state.response.length; i++) {
          orderInfo = state.response[i];
        }
        print(orderInfo!.refCode!);
        SharedPrefs.setOrderRefCode(orderInfo.refCode!);

        bool surprisePackageStatus = true;
        for (var i = 0; i < orderInfo.boxes!.length; i++) {
          if (orderInfo.boxes![i].defined == false) {
            surprisePackageStatus = false;
            break;
          }
        }

        if (orderInfo.boxes != null &&
            surprisePackageStatus == false &&
            DateTime.now().toLocal().isBefore(orderInfo.boxes!.first.saleDay!.startDate!.toLocal())) {
          NotificationService()
              .initSurprisePackage(orderInfo.refCode.toString(), orderInfo.boxes!.first.saleDay!.startDate!.toLocal().subtract(Duration(hours: 2)));
        }

        return orderInfo.id != null
            ? ListView(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  buildOrderNumberContainer(context, orderInfo),
                  SizedBox(
                    height: 20.h,
                  ),
                  buildCountDown(context, orderInfo),
                  SizedBox(
                    height: 40.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 26.w),
                    child: LocaleText(text: LocaleKeys.order_received_order_summary, style: AppTextStyles.bodyTitleStyle),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  OrderSummaryContainer(
                    orderInfo: orderInfo,
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  buildRowTitleLeftRight(
                    context,
                    LocaleKeys.order_received_delivery_address,
                    LocaleKeys.payment_address_to_address,
                    LocaleKeys.order_received_show_on_map,
                    orderInfo,
                  ),
                  SizedBox(
                    height: context.dynamicHeight(0.01),
                  ),
                  GetItAddressListTile(
                    userAddress: orderInfo.address!.address,
                    userAddressName: orderInfo.address!.name,
                    restaurantName: orderInfo.boxes!.length != 0 ? orderInfo.boxes![0].store!.name : "",
                    address: orderInfo.boxes!.length != 0 ? orderInfo.boxes![0].store!.address : "",
                  ),
                  SizedBox(
                    height: context.dynamicHeight(0.04),
                  ),
                  buildButton(context, LocaleKeys.order_received_button_1, Colors.transparent, AppColors.greenColor,
                      () => Navigator.pushNamed(context, RouteConstant.PAST_ORDER_VIEW)),
                  SizedBox(
                    height: context.dynamicHeight(0.02),
                  ),
                  buildButton(
                    context,
                    LocaleKeys.order_received_button_2,
                    AppColors.greenColor,
                    Colors.white,
                    () {
                      Navigator.pushNamed(context, RouteConstant.CUSTOM_SCAFFOLD);
                      SharedPrefs.setDeleteOrder(false);
                    },
                  ),
                  SizedBox(
                    height: context.dynamicHeight(0.06),
                  ),
                ],
              )
            : Text("${orderInfo.id} order endpointi boş");
      } else {
        final error = state as GenericError;
        return Center(child: Text("${error.message}\n${error.statusCode} aaaa"));
      }
    });
  }

  Container buildOrderNumberContainer(BuildContext context, OrderReceived orderInfo) {
    return Container(
      width: double.infinity,
      height: 280.h,
      color: Colors.white,
      child: Column(
        children: [
          Spacer(flex: 8),
          SvgPicture.asset(ImageConstant.ORDER_RECEIVING_PACKAGE_ICON),
          Spacer(flex: 4),
          LocaleText(
            text: LocaleKeys.order_received_headline,
            style: AppTextStyles.appBarTitleStyle.copyWith(fontWeight: FontWeight.w400, color: AppColors.orangeColor),
            alignment: TextAlign.center,
          ),
          Spacer(flex: 2),
          buildOrderNumber(orderInfo),
          Spacer(flex: 5),
        ],
      ),
    );
  }

  AutoSizeText buildOrderNumber(OrderReceived orderInfo) {
    return AutoSizeText.rich(
      TextSpan(
        style: AppTextStyles.bodyTextStyle,
        children: [
          TextSpan(
            text: LocaleKeys.order_received_order_number.locale,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: orderInfo.refCode.toString(),
            style: GoogleFonts.montserrat(
              color: AppColors.greenColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  Container buildCountDown(BuildContext context, OrderReceived orderInfo) {
    return orderInfo.boxes! != [] || durationFinal <= 0
        ? Container(
            width: double.infinity,
            height: 100.h,
            color: Colors.white,
            child: Row(
              children: [
                Spacer(flex: 5),
                SvgPicture.asset(ImageConstant.ORDER_RECEIVED_CLOCK_ICON),
                Spacer(flex: 1),
                LocaleText(text: LocaleKeys.order_received_count_down, style: AppTextStyles.bodyTitleStyle),
                Spacer(flex: 1),
                countdown(orderInfo),
                Spacer(flex: 5),
              ],
            ),
          )
        : Container(
            width: 0,
            height: 0,
          );
  }

  Padding buildButton(BuildContext context, String title, Color color, Color textColor, VoidCallback onPressedd) {
    return Padding(
      padding: EdgeInsets.only(
        left: 28.w,
        right: 28.w,
      ),
      child: CustomButton(
        width: double.infinity,
        title: title,
        color: color,
        borderColor: AppColors.greenColor,
        textColor: textColor,
        onPressed: onPressedd,
      ),
    );
  }

  Padding buildRowTitleLeftRight(BuildContext context, String titleLeft, String titleCourier, String titleRight, OrderReceived orderInfo) {
    return Padding(
      padding: EdgeInsets.only(
        left: 28.w,
        right: 28.w,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Builder(builder: (context) {
            final PaymentState state = context.watch<PaymentCubit>().state;
            return LocaleText(
              text: state.isGetIt! ? titleLeft : titleCourier,
              style: AppTextStyles.bodyTitleStyle,
            );
          }),
          GestureDetector(
            onTap: () {
              openMapsSheet(orderInfo);
            },
            child: LocaleText(
              text: titleRight,
              style: GoogleFonts.montserrat(
                fontSize: 14.0.sp,
                color: AppColors.orangeColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      shadowColor: Colors.transparent,
      leading: IconButton(
        icon: SvgPicture.asset(ImageConstant.COMMONS_CLOSE_ICON),
        onPressed: () => Navigator.pushNamed(context, RouteConstant.CUSTOM_SCAFFOLD),
      ),
      title: SvgPicture.asset(ImageConstant.COMMONS_APP_BAR_LOGO),
      centerTitle: true,
    );
  }

  void setCustomMarker(OrderReceived orderInfo) async {
    markerIcon = await _bitmapDescriptorFromSvgAsset(ImageConstant.COMMONS_MAP_MARKER);
    restaurantMarkerIcon = await _bitmapDescriptorFromSvgAsset(ImageConstant.COMMONS_RESTAURANT_MARKER);
    restaurantSoldoutMarkerIcon = await _bitmapDescriptorFromSvgAsset(ImageConstant.COMMONS_RESTAURANT_SOLDOUT_MARKER);
    getLocation(orderInfo);
  }

  Future<BitmapDescriptor> _bitmapDescriptorFromSvgAsset(String assetName) async {
    // Read SVG file as String
    String svgString = await DefaultAssetBundle.of(context).loadString(assetName);
    // Create DrawableRoot from SVG String
    DrawableRoot svgDrawableRoot = await svg.fromSvgString(svgString, "");

    // toPicture() and toImage() don't seem to be pixel ratio aware, so we calculate the actual sizes here
    MediaQueryData queryData = MediaQuery.of(context);
    double devicePixelRatio = queryData.devicePixelRatio;
    double width = 64 * devicePixelRatio; // where 32 is your SVG's original width
    double height = 64 * devicePixelRatio; // same thing

    // Convert to ui.Picture
    ui.Picture picture = svgDrawableRoot.toPicture(size: Size(width, height));

    // Convert to ui.Image. toImage() takes width and height as parameters
    // you need to find the best size to suit your needs and take into account the
    // screen DPI
    ui.Image image = await picture.toImage(width.toInt(), height.toInt());
    ByteData? bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
  }

  Future<void> getLocation(OrderReceived orderInfo) async {
    await LocationService.getCurrentLocation();
    final GoogleMapController controller = await _mapController.future;
    setState(() {
      latitude = LocationService.latitude;
      longitude = LocationService.longitude;

      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 17.0,
        ),
      ));
      final Marker marker = Marker(
        onTap: () {
          setState(() {
            isShowBottomInfo = false;
          });
        },
        infoWindow: InfoWindow(title: LocaleKeys.general_settings_my_location),
        icon: markerIcon,
        markerId: markerId,
        position: LatLng(latitude, longitude),
      );
      markers[markerId] = marker;
      Marker restMarker = Marker(
        onTap: () {
          setState(() {
            isShowBottomInfo = !isShowBottomInfo;
          });
        },
        icon: restaurantMarkerIcon,
        markerId: MarkerId(orderInfo.refCode!.toString()),
        position: LatLng(orderInfo.boxes!.last.store!.latitude!, orderInfo.boxes!.last.store!.longitude!),
      );
      markers[MarkerId(orderInfo.refCode!.toString())] = restMarker;
/*       for (int i = 1; i < 3; i++) {
        Marker restMarker = Marker(
          onTap: () {
            setState(() {
              isShowBottomInfo = !isShowBottomInfo;
            });
          },
          icon: restaurantMarkerIcon,
          markerId: MarkerId("rest_$i"),
          position: LatLng(latitude + i * 0.0005, longitude + i * 0.0005),
        );
        markers[MarkerId("rest_$i")] = restMarker;
      }
      for (int i = 1; i < 3; i++) {
        Marker restMarker = Marker(
          onTap: () {
            setState(() {
              isShowBottomInfo = !isShowBottomInfo;
            });
          },
          icon: restaurantSoldoutMarkerIcon,
          markerId: MarkerId("rest_${3 + i}"),
          position: LatLng(latitude - i * 0.0005, longitude - i * 0.0005),
        );
        markers[MarkerId("rest_${3 + i}")] = restMarker;
      } */
    });
  }

  Builder buildBottomInfo(BuildContext context, OrderReceived orderInfo) {
    return Builder(builder: (context) {
      final GenericState state = context.watch<SearchStoreCubit>().state;

      if (state is GenericInitial) {
        return Container();
      } else if (state is GenericLoading) {
        return Center(child: CustomCircularProgressIndicator());
      } else if (state is GenericCompleted) {
        List<SearchStore> restaurants = [];
        List<SearchStore> chosenRestaurant = [];

        for (int i = 0; i < state.response.length; i++) {
          restaurants.add(state.response[i]);
        }
        for (var i = 0; i < restaurants.length; i++) {
          for (var j = 0; j < orderInfo.boxes!.length; j++) {
            if (orderInfo.boxes![j].store!.id == restaurants[i].id) {
              chosenRestaurant.add(restaurants[i]);
            }
          }
        }
        return Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: Container(
              width: double.infinity,
              height: context.dynamicHeight(0.176),
              padding: EdgeInsets.symmetric(vertical: context.dynamicHeight(0.02)),
              color: Colors.white,
              child: RestaurantInfoListTile(
                minDiscountedOrderPrice: chosenRestaurant.first.packageSettings!.minDiscountedOrderPrice,
                minOrderPrice: chosenRestaurant.first.packageSettings!.minOrderPrice,
                deliveryType: int.parse(orderInfo.deliveryType!),
                restaurantName: orderInfo.boxes!.first.store!.name,
                distance: Haversine.distance(orderInfo.boxes!.last.store!.latitude!, orderInfo.boxes!.last.store!.longitude!,
                        LocationService.latitude, LocationService.longitude)
                    .toStringAsFixed(2),
                availableTime:
                    '${orderInfo.boxes!.last.saleDay!.startDate!.hour}:${orderInfo.boxes!.last.saleDay!.startDate!.minute}0 - ${orderInfo.boxes!.last.saleDay!.endDate!.hour}:${orderInfo.boxes!.last.saleDay!.endDate!.minute}0',
                onPressed: () {
                  Navigator.pushNamed(context, RouteConstant.RESTAURANT_DETAIL,
                      arguments: ScreenArgumentsRestaurantDetail(
                        restaurant: chosenRestaurant.first,
                      ));
                },
                icon: orderInfo.boxes!.first.store!.photo,
                restaurantId: chosenRestaurant.first.id!,
              ),
            ));
      } else {
        final error = state as GenericError;
        return Center(child: Text("${error.message}\n${error.statusCode}"));
      }
    });
  }

  List<int> buildDurationForCountdown(DateTime dateTime, DateTime? endDate) {
    List<int> results = [];
    int durationOfNow = buildDurationSecondsForDateTimes(dateTime);
    int durationOfEnd = buildDurationSecondsForDateTimes(endDate!);

    durationFinal = durationOfEnd - durationOfNow;
    int hourOfitem = (durationFinal ~/ (60 * 60));
    results.add(hourOfitem);
    int minuteOfitem = (durationFinal - (hourOfitem * 60 * 60)) ~/ 60;
    results.add(minuteOfitem);

    int secondOfitem = (durationFinal - (minuteOfitem * 60) - (hourOfitem * 60 * 60));
    results.add(secondOfitem);

    return results;
  }

  int buildDurationSecondsForDateTimes(DateTime dateTime) {
    int hourOfItem = dateTime.hour;
    int minuteOfitem = dateTime.minute;
    int secondsOfitem = dateTime.second;
    int durationOfitems = ((hourOfItem * 60 * 60) + (minuteOfitem * 60) + (secondsOfitem));
    return durationOfitems;
  }

  Widget countdown(OrderReceived orderInfo) {
    List<int> itemsOfCountDown = buildDurationForCountdown(
        DateTime.now(), orderInfo.boxes!.isNotEmpty ? orderInfo.boxes!.first.saleDay!.endDate!.toLocal() : orderInfo.buyingTime!.toLocal());
    int hour = itemsOfCountDown[0];
    int minute = itemsOfCountDown[1];
    int second = itemsOfCountDown[2];
    if (durationFinal <= 0) {
      context.read<OrderBarCubit>().stateOfBar(false);
      SharedPrefs.setOrderBar(false);
    }
    return TimerCountDown(hour: hour, minute: minute, second: second);
  }

  openMapsSheet(OrderReceived orderInfo) async {
    try {
      final coords = Coords(
        orderInfo.boxes!.first.store!.latitude!,
        orderInfo.boxes!.first.store!.longitude!,
      );
      final title = orderInfo.boxes!.first.store!.address!;
      final availableMaps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
                children: <Widget>[
                  for (var map in availableMaps)
                    ListTile(
                      onTap: () => map.showMarker(
                        coords: coords,
                        title: title,
                      ),
                      title: Text(map.mapName),
                      leading: SvgPicture.asset(
                        map.icon,
                        height: 30.0,
                        width: 30.0,
                      ),
                    ),
                ],
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }
/* 
  int buildHourForCountDown(DateTime dateTime, DateTime? endDate) {
    int hourNow = dateTime.hour;
    int hourEnd = endDate!.hour;
    int result = hourEnd - hourNow;
    return result;
  }

  int buildMinuteForCountDown(DateTime dateTime, DateTime? endDate) {
    int minuteNow = dateTime.minute;
    int minuteEnd = endDate!.minute;
    int result = minuteEnd - minuteNow;
    return result;
  }

  int buildSecondsForCountDown(DateTime dateTime, DateTime? endDate) {
    int secondNow = dateTime.second;
    int secondEnd = endDate!.second;
    int result = secondEnd - secondNow;
    return result;
  } */
}

/*     int hour = buildHourForCountDown(
        DateTime.now(), orderInfo.last.boxes!.first.saleDay!.endDate);
    int minute = buildMinuteForCountDown(
        DateTime.now(), orderInfo.last.boxes!.first.saleDay!.endDate);
    int second = buildSecondsForCountDown(
        DateTime.now(), orderInfo.last.boxes!.first.saleDay!.endDate); */
/*    List<int> timeNowHourCompo = buildTimeNow();
    String cachedTimeForDelivery = SharedPrefs.getCountDownString;
    List<String> cachedTimeForDeliveryStringList =
        cachedTimeForDelivery.split(":").toList();
    cachedTimeForDeliveryStringList.add("00");

    List<int> cachedTimeForDeliveryIntList = [];
    for (var i = 0; i < cachedTimeForDeliveryStringList.length; i++) {
      cachedTimeForDeliveryIntList
          .add(int.parse(cachedTimeForDeliveryStringList[i]));
    }

    int hour = (cachedTimeForDeliveryIntList[0] - timeNowHourCompo[0]);
    int minute = (cachedTimeForDeliveryIntList[1] - timeNowHourCompo[1]);
    int second = (cachedTimeForDeliveryIntList[2] - timeNowHourCompo[2]);
    int duration = ((hour * 60 * 60) + (minute * 60) + (second));
    hour = (duration ~/ (60 * 60));
    minute = (duration - (hour * 60 * 60)) ~/ 60;
    second = (duration - (minute * 60) - (minute * 60 * 60)); */

/*    if (duration <= 0) {
      context.read<OrderBarCubit>().stateOfBar(false);
    } */
