import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dongu_mobile/data/services/location_service.dart';
import 'package:dongu_mobile/presentation/widgets/restaurant_info_list_tile/restaurant_info_list_tile.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../utils/constants/image_constant.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/extensions/string_extension.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/text/locale_text.dart';
import '../payment_views/payment_address_view/components/get_it_address_list_tile.dart';
import 'components/order_summary_container.dart';

class OrderReceivedView extends StatefulWidget {
  @override
  _OrderReceivedViewState createState() => _OrderReceivedViewState();
}

class _OrderReceivedViewState extends State<OrderReceivedView> {
  late Timer timer;
  int hour = 1;
  int minute = 51;
  int second = 30;
  bool isShowOnMap = false;
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

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }

  ListView buildBody(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: context.dynamicHeight(0.02),
        ),
        buildOrderNumberContainer(context),
        SizedBox(
          height: context.dynamicHeight(0.02),
        ),
        buildCountDown(context),
        SizedBox(
          height: context.dynamicHeight(0.04),
        ),
        Padding(
          padding: EdgeInsets.only(left: context.dynamicWidht(0.06)),
          child: LocaleText(
              text: LocaleKeys.order_received_order_summary,
              style: AppTextStyles.bodyTitleStyle),
        ),
        SizedBox(
          height: context.dynamicHeight(0.01),
        ),
        OrderSummaryContainer(),
        SizedBox(
          height: context.dynamicHeight(0.04),
        ),
        buildRowTitleLeftRight(
            context,
            LocaleKeys.order_received_delivery_address,
            isShowOnMap
                ? LocaleKeys.order_received_order_summary
                : LocaleKeys.order_received_show_on_map),
        SizedBox(
          height: context.dynamicHeight(0.01),
        ),
        Visibility(
          visible: !isShowOnMap,
          child: GetItAddressListTile(
            restaurantName: "Canım Büfe",
            address: "Kuruçeşme, Muallim Cad., No:18 Beşiktaş/İstanbul",
          ),
        ),
        Visibility(
          visible: isShowOnMap,
          child: Expanded(
            child: Container(
              height: context.dynamicHeight(0.54),
              width: double.infinity,
              child: Stack(
                children: [
                  Stack(
                    alignment: Alignment(0.81, 0.88),
                    children: [
                      GoogleMap(
                        myLocationButtonEnabled: false,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(latitude, longitude),
                          zoom: 17.0,
                        ),
                        onMapCreated: (GoogleMapController controller) {
                          _mapController.complete(controller);
                        },
                        mapType: MapType.normal,
                        markers: Set<Marker>.of(markers.values),
                      ),
                      GestureDetector(
                        onTap: () async {
                          final GoogleMapController controller =
                              await _mapController.future;
                          setState(() {
                            latitude = LocationService.latitude;
                            longitude = LocationService.longitude;

                            controller
                                .animateCamera(CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: LatLng(latitude, longitude),
                                zoom: 17.0,
                              ),
                            ));
                          });
                        },
                        child: SvgPicture.asset(
                            ImageConstant.COMMONS_MY_LOCATION_BUTTON),
                      ),
                      Visibility(
                          visible: isShowBottomInfo,
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isShowBottomInfo = false;
                                });
                              },
                              child: Container(
                                  color: Colors.black.withOpacity(0.2)))),
                    ],
                  ),
                  Visibility(
                    visible: isShowBottomInfo,
                    child: buildBottomInfo(context),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: context.dynamicHeight(0.04),
        ),
        buildButton(
            context,
            LocaleKeys.order_received_button_1,
            Colors.transparent,
            AppColors.greenColor,
            () => Navigator.pushNamed(context, RouteConstant.PAST_ORDER_VIEW)),
        SizedBox(
          height: context.dynamicHeight(0.02),
        ),
        buildButton(
          context,
          LocaleKeys.order_received_button_2,
          AppColors.greenColor,
          Colors.white,
          () => Navigator.pushNamed(context, RouteConstant.CUSTOM_SCAFFOLD),
        ),
        SizedBox(
          height: context.dynamicHeight(0.06),
        ),
      ],
    );
  }

  Container buildOrderNumberContainer(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.dynamicHeight(0.22),
      color: Colors.white,
      child: Column(
        children: [
          Spacer(flex: 8),
          SvgPicture.asset(ImageConstant.ORDER_RECEIVING_PACKAGE_ICON),
          Spacer(flex: 4),
          LocaleText(
            text: LocaleKeys.order_received_headline,
            style: AppTextStyles.appBarTitleStyle.copyWith(
                fontWeight: FontWeight.w400, color: AppColors.orangeColor),
            alignment: TextAlign.center,
          ),
          Spacer(flex: 2),
          buildOrderNumber(),
          Spacer(flex: 5),
        ],
      ),
    );
  }

  AutoSizeText buildOrderNumber() {
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
            text: '86123345',
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

  Container buildCountDown(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.dynamicHeight(0.1),
      color: Colors.white,
      child: Row(
        children: [
          Spacer(flex: 5),
          SvgPicture.asset(ImageConstant.ORDER_RECEIVED_CLOCK_ICON),
          Spacer(flex: 1),
          LocaleText(
              text: LocaleKeys.order_received_count_down,
              style: AppTextStyles.bodyTitleStyle),
          Spacer(flex: 1),
          Text(
              '0$hour:${minute < 10 ? "0$minute" : minute}:${second < 10 ? "0$second" : second}',
              style: AppTextStyles.appBarTitleStyle),
          Spacer(flex: 5),
        ],
      ),
    );
  }

  Padding buildButton(BuildContext context, String title, Color color,
      Color textColor, VoidCallback onPressedd) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
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

  Padding buildRowTitleLeftRight(
      BuildContext context, String titleLeft, String titleRight) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LocaleText(
            text: titleLeft,
            style: AppTextStyles.bodyTitleStyle,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isShowOnMap = !isShowOnMap;
                _mapController = Completer<GoogleMapController>();
                setCustomMarker();
              });
            },
            child: LocaleText(
              text: titleRight,
              style: GoogleFonts.montserrat(
                fontSize: 12.0,
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
        onPressed: () =>
            Navigator.pushNamed(context, RouteConstant.CUSTOM_SCAFFOLD),
      ),
      title: SvgPicture.asset(ImageConstant.COMMONS_APP_BAR_LOGO),
      centerTitle: true,
    );
  }

  void setCustomMarker() async {
    markerIcon =
        await _bitmapDescriptorFromSvgAsset(ImageConstant.COMMONS_MAP_MARKER);
    restaurantMarkerIcon = await _bitmapDescriptorFromSvgAsset(
        ImageConstant.COMMONS_RESTAURANT_MARKER);
    restaurantSoldoutMarkerIcon = await _bitmapDescriptorFromSvgAsset(
        ImageConstant.COMMONS_RESTAURANT_SOLDOUT_MARKER);
    getLocation();
  }

  Future<BitmapDescriptor> _bitmapDescriptorFromSvgAsset(
      String assetName) async {
    // Read SVG file as String
    String svgString =
        await DefaultAssetBundle.of(context).loadString(assetName);
    // Create DrawableRoot from SVG String
    DrawableRoot svgDrawableRoot = await svg.fromSvgString(svgString, "");

    // toPicture() and toImage() don't seem to be pixel ratio aware, so we calculate the actual sizes here
    MediaQueryData queryData = MediaQuery.of(context);
    double devicePixelRatio = queryData.devicePixelRatio;
    double width =
        64 * devicePixelRatio; // where 32 is your SVG's original width
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

  Future<void> getLocation() async {
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
        infoWindow: InfoWindow(title: "Benim Konumum"),
        icon: markerIcon,
        markerId: markerId,
        position: LatLng(latitude, longitude),
      );
      markers[markerId] = marker;
      for (int i = 1; i < 3; i++) {
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
      }
    });
  }

  Positioned buildBottomInfo(
    BuildContext context,
  ) {
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
            restaurantName: "Mini Burger",
            distance: "74m",
            packetNumber: "4 paket",
            availableTime: "18:00-21:00",
          ),
        ));
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (hour == 0 && minute == 0 && second == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            if (second != 0) {
              second--;
            } else {
              second = 59;
              if (minute != 0) {
                minute--;
              } else {
                minute = 59;
                hour--;
              }
            }
          });
        }
      },
    );
  }
}
