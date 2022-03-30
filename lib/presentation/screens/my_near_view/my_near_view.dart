import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:device_info/device_info.dart';
import 'package:dongu_mobile/presentation/widgets/circular_progress_indicator/custom_circular_progress_indicator.dart';
import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../data/model/box.dart';
import '../../../data/model/search_store.dart';
import '../../../data/services/location_service.dart';
import '../../../logic/cubits/generic_state/generic_state.dart';
import '../../../logic/cubits/search_store_cubit/search_store_cubit.dart';
import '../../../utils/constants/image_constant.dart';
import '../../../utils/constants/route_constant.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/extensions/string_extension.dart';
import '../../../utils/haversine.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/restaurant_info_list_tile/restaurant_info_list_tile.dart';
import '../../widgets/scaffold/custom_scaffold.dart';
import '../../widgets/text/locale_text.dart';
import '../my_favorites_view/components/address_text.dart';
import '../restaurant_details_views/screen_arguments/screen_arguments.dart';

class MyNearView extends StatefulWidget {
  final SearchStore? restaurant;
  final Box? boxes;
  const MyNearView({Key? key, this.restaurant, this.boxes}) : super(key: key);

  @override
  _MyNearViewState createState() => _MyNearViewState();
}

class _MyNearViewState extends State<MyNearView> {
  late BitmapDescriptor markerIcon;
  late BitmapDescriptor restaurantMarkerIcon;
  late BitmapDescriptor restaurantSoldoutMarkerIcon;
  late BitmapDescriptor packetNumberContainer;

  final MarkerId markerId = MarkerId("my_location");
  final MarkerId restaurantMarkerId = MarkerId("rest_1");

  Completer<GoogleMapController> _mapController = Completer();
  Map<MarkerId, Marker> markers = Map<MarkerId, Marker>();
  double latitude = 0;
  double longitude = 0;

  bool isShowOnMap = false;
  bool isShowBottomInfo = false;
  bool isShowOnList = true;
  bool isShowPacketNumber = false;
  List<SearchStore> restaurants = [];
  List<double> distances = [];
  List<SearchStore> mapsMarkers = [];
  int restaurantIndexOnMap = 1;

  @override
  void initState() {
    super.initState();
    getLocation().whenComplete(() {
      setState(() {});
    });
    context.read<SearchStoreCubit>().getSearchStore();
    LocationService.getCurrentLocation();
    getDeviceIdentifier();
    setCustomMarker();
  }

  Future<List<String>> getDeviceIdentifier() async {
    String? identifier;
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;

        identifier = build.androidId;
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        identifier = data.identifierForVendor; //UUID for iOS
      }
    } on PlatformException {}
    return [identifier!];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: LocaleKeys.my_near_title,
      isNavBar: false,
      body: buildBuilder(),
    );
  }

  Builder buildBuilder() {
    return Builder(builder: (context) {
      final GenericState state = context.watch<SearchStoreCubit>().state;
      if (state is GenericInitial) {
        LocationService.getCurrentLocation();

        return Container();
      } else if (state is GenericLoading) {
        return Center(child: CustomCircularProgressIndicator());
      } else if (state is GenericCompleted) {
        //List<double> getDistance = [];
        List<SearchStore> getrestaurants = [];

        for (int i = 0; i < state.response.length; i++) {
          getrestaurants.add(state.response[i]);
        }

        mapsMarkers = getrestaurants;

        return buildBody(context, getrestaurants, distances);
        // for (int i = 0; i < state.response[0].results.length; i++) {
        //   if (SharedPrefs.getUserAddress == state.response[0].results[i].city) {
        //     restaurants.add(state.response[0].results[i]);
        //     distances.add(Haversine.distance(
        //         LocationService.latitude!,
        //         LocationService.longitude!,
        //         state.response[0].results[i].latitude,
        //         state.response[0].results[i].longitude));
        //   }
        // }
      } else {
        final error = state as GenericError;
        return Center(child: Text("${error.message}\n${error.statusCode}"));
      }
    });
  }

  Column buildBody(BuildContext context, List<SearchStore> getrestaurants,
      List<double> distances) {
    return Column(
      children: [
        buildTitlesAndSearchBar(context),
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
                        myLocationEnabled: true,
                        myLocationButtonEnabled: false,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(LocationService.latitude,
                              LocationService.latitude),
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
                      child:
                          buildBottomInfo(context, getrestaurants, distances)),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: isShowOnList,
          child: Expanded(
            child: Container(
              height: 540.h,
              child: buildListViewRestaurantInfo(getrestaurants, distances),
            ),
          ),
        ),
      ],
    );
  }

  Positioned buildBottomInfo(BuildContext context,
      List<SearchStore> getrestaurants, List<double> distances) {
    return Positioned(
        right: 0,
        left: 0,
        bottom: 0,
        child: Container(
          width: double.infinity,
          height: 163.h,
          padding: EdgeInsets.symmetric(vertical: 20.h),
          color: Colors.white,
          child: RestaurantInfoListTile(
            deliveryType: 3,
            icon: getrestaurants[restaurantIndexOnMap].photo,
            restaurantName: getrestaurants[restaurantIndexOnMap].name,
            distance: Haversine.distance(
                    getrestaurants[restaurantIndexOnMap].latitude!,
                    getrestaurants[restaurantIndexOnMap].longitude,
                    LocationService.latitude,
                    LocationService.longitude)
                .toString(),
            availableTime:
                '${getrestaurants[restaurantIndexOnMap].packageSettings?.deliveryTimeStart}-${getrestaurants[restaurantIndexOnMap].packageSettings?.deliveryTimeEnd}',
            minDiscountedOrderPrice: getrestaurants[restaurantIndexOnMap]
                .packageSettings
                ?.minDiscountedOrderPrice,
            minOrderPrice: getrestaurants[restaurantIndexOnMap]
                .packageSettings
                ?.minOrderPrice,
            onPressed: () {
              Navigator.pushNamed(
                context,
                RouteConstant.RESTAURANT_DETAIL,
                arguments: ScreenArgumentsRestaurantDetail(
                  restaurant: getrestaurants[restaurantIndexOnMap],
                ),
              );
            },
            restaurantId: getrestaurants[restaurantIndexOnMap].id!,
          ),
        ));
  }

  Padding buildTitlesAndSearchBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 28.w,
        right: 28.w,
        top: 20.h,
        bottom: 20.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildRowTitleLeftRight(
              context, LocaleKeys.my_near_location, LocaleKeys.my_near_edit,
              () {
            if (SharedPrefs.getIsLogined) {
              Navigator.pushNamed(context, RouteConstant.ADDRESS_FROM_MAP_VIEW);
            } else {
              Navigator.pushNamed(context, RouteConstant.LOGIN_VIEW);
            }
          }),
          Divider(
            thickness: 4,
            color: AppColors.borderAndDividerColor,
          ),
          AddressText(),
          SizedBox(height: 30.h),
          Row(
            children: [
              buildSearchBar(context),
              Spacer(),
              GestureDetector(
                child: SvgPicture.asset(ImageConstant.COMMONS_FILTER_ICON),
                onTap: () {
                  Navigator.pushNamed(context, RouteConstant.FILTER_VIEW);
                },
              ),
            ],
          ),
          SizedBox(height: 40.h),
          buildRowTitleLeftRight(
              context,
              LocaleKeys.my_near_body_title,
              isShowOnMap
                  ? LocaleKeys.my_near_show_list
                  : LocaleKeys.my_near_show_map, () {
            setState(() {
              isShowOnMap = !isShowOnMap;
              isShowOnList = !isShowOnList;
              _mapController = Completer<GoogleMapController>();
              setCustomMarker();
            });
          }),
          Divider(
            thickness: 4,
            color: AppColors.borderAndDividerColor,
          ),
        ],
      ),
    );
  }

  ListView buildListViewRestaurantInfo(
      List<SearchStore> getrestaurants, List<double> distances) {
    return ListView.builder(
        itemCount: getrestaurants.length,
        itemBuilder: (context, index) {
          return Container(
            child: Builder(builder: (context) {
              return RestaurantInfoListTile(
                deliveryType: 3,
                minDiscountedOrderPrice: getrestaurants[index]
                    .packageSettings!
                    .minDiscountedOrderPrice,
                minOrderPrice:
                    getrestaurants[index].packageSettings!.minOrderPrice,
                onPressed: () {
                  Navigator.pushNamed(context, RouteConstant.RESTAURANT_DETAIL,
                      arguments: ScreenArgumentsRestaurantDetail(
                        restaurant: getrestaurants[index],
                      ));
                },
                icon: getrestaurants[index].photo,
                restaurantName: getrestaurants[index].name,
                // distance: (Haversine.distance(
                //             getrestaurants[index].latitude!,
                //             getrestaurants[index].longitude,
                //             LocationService.latitude,
                //             LocationService.longitude) /
                //         1000)
                //     .toStringAsFixed(2),
                distance: Haversine.distance(
                        getrestaurants[index].latitude!,
                        getrestaurants[index].longitude,
                        LocationService.latitude,
                        LocationService.longitude)
                    .toString(),
                availableTime:
                    '${getrestaurants[index].packageSettings!.deliveryTimeStart} - ${getrestaurants[index].packageSettings!.deliveryTimeEnd}',
                restaurantId: getrestaurants[index].id!,
              );
            }),
          );
        });
  }

  Row buildRowTitleLeftRight(BuildContext context, String titleLeft,
      String titleRight, VoidCallback onPressed) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LocaleText(
          text: titleLeft,
          style: AppTextStyles.bodyTitleStyle,
        ),
        GestureDetector(
          onTap: onPressed,
          child: LocaleText(
            text: titleRight,
            style: GoogleFonts.montserrat(
              fontSize: 12.0.sp,
              color: AppColors.orangeColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Container buildSearchBar(BuildContext context) {
    return Container(
      width: 308.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(25.0),
          left: Radius.circular(4.0),
        ),
        color: Colors.white,
      ),
      child: TextFormField(
        inputFormatters: [
          FilteringTextInputFormatter.singleLineFormatter,
        ],
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
            contentPadding: EdgeInsets.only(left: 20.w),
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

  void setCustomMarker() async {
    markerIcon =
        await _bitmapDescriptorFromSvgAsset(ImageConstant.COMMONS_MAP_MARKER);
    restaurantMarkerIcon = await _bitmapDescriptorFromSvgAsset(
        ImageConstant.COMMONS_RESTAURANT_MARKER);
    restaurantSoldoutMarkerIcon = await _bitmapDescriptorFromSvgAsset(
        ImageConstant.COMMONS_RESTAURANT_SOLDOUT_MARKER);
    //packetNumberContainer = await _bitmapDescriptorFromWidget(assetName);
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
      double mylatitude = LocationService.latitude;
      double mylongitude = LocationService.longitude;

      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(mylatitude, mylongitude),
          zoom: 17.0,
        ),
      ));
      final Marker marker = Marker(
        onTap: () {
          setState(() {
            isShowBottomInfo = false;
          });
        },
        infoWindow:
            InfoWindow(title: LocaleKeys.general_settings_my_location.locale),
        icon: markerIcon,
        markerId: markerId,
        position: LatLng(mylatitude, mylongitude),
      );
      markers[markerId] = marker;

      for (int i = 0; i < mapsMarkers.length; i++) {
        int? dailyBoxCount;

        for (var j = 0; j < mapsMarkers[i].calendar!.length; j++) {
          if (DateTime.parse(
                      mapsMarkers[i].calendar![j].startDate!.toIso8601String())
                  .day ==
              DateTime.now().toLocal().day) {
            dailyBoxCount = mapsMarkers[i].calendar![j].boxCount;
          }
        }
        Marker restMarker = Marker(
          onTap: () {
            setState(() {
              isShowBottomInfo = !isShowBottomInfo;
              restaurantIndexOnMap = i;
            });
          },
          infoWindow: InfoWindow(title: mapsMarkers[i].name),
          icon: dailyBoxCount != 0
              ? restaurantMarkerIcon
              : restaurantSoldoutMarkerIcon,
          markerId: MarkerId("rest_$i"),
          position: LatLng(mapsMarkers[i].latitude!, mapsMarkers[i].longitude!),
        );
        markers[MarkerId("rest_$i")] = restMarker;
      }
    });
  }
}
