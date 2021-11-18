import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:device_info/device_info.dart';
import 'package:dongu_mobile/data/model/box.dart';
import 'package:dongu_mobile/data/model/search_store.dart';
import 'package:dongu_mobile/data/services/notification_service.dart';
import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';
import 'package:dongu_mobile/logic/cubits/search_store_cubit/search_store_cubit.dart';
import 'package:dongu_mobile/presentation/screens/restaurant_details_views/screen_arguments/screen_arguments.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';

import 'package:dongu_mobile/utils/haversine.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/services/location_service.dart';
import '../../../utils/constants/image_constant.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/extensions/string_extension.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/restaurant_info_list_tile/restaurant_info_list_tile.dart';
import '../../widgets/scaffold/custom_scaffold.dart';
import '../../widgets/text/locale_text.dart';
import '../my_favorites_view/components/address_text.dart';

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

  final MarkerId markerId = MarkerId("my_location");
  final MarkerId restaurantMarkerId = MarkerId("rest_1");

  late Completer<GoogleMapController> _mapController;
  Map<MarkerId, Marker> markers = Map<MarkerId, Marker>();
  double latitude = 0;
  double longitude = 0;

  bool isShowOnMap = false;
  bool isShowBottomInfo = false;
  bool restaurantInfo = true;
  List<SearchStore> restaurants = [];
  List<double> distances = [];
  List<SearchStore> mapsMarkers = [];
  int restaurantIndexOnMap = 1;

  @override
  void initState() {
    super.initState();
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
    return CustomScaffold(
      title: LocaleKeys.my_near_title,
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
        return Center(child: CircularProgressIndicator());
      } else if (state is GenericCompleted) {
        List<double> getDistance = [];
        List<SearchStore> getrestaurants = [];

        for (int i = 0; i < state.response.length; i++) {
          getrestaurants.add(state.response[i]);
        }

        mapsMarkers = getrestaurants;

        return buildBody(context, getrestaurants, getDistance);
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
      List<double> getDistance) {
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
                      child:
                          buildBottomInfo(context, getrestaurants, distances))
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: restaurantInfo,
          child: Expanded(
            child: Container(
              height: context.dynamicHeight(0.54),
              child: buildListViewRestaurantInfo(getrestaurants, getDistance),
            ),
          ),
        ),
      ],
    );
  }

  Positioned buildBottomInfo(BuildContext context,
      List<SearchStore> getrestaurants, List<double> distances) {
    print(getrestaurants);
    // String startTime =
    //     restaurants[restaurantIndexOnMap].calendar![0].startDate!.split("T")[1];
    // String endTime =
    //     restaurants[restaurantIndexOnMap].calendar![0].endDate!.split("T")[1];

    // startTime = "${startTime.split(":")[0]}:${startTime.split(":")[1]}";
    // endTime = "${endTime.split(":")[0]}:${endTime.split(":")[1]}";

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
            icon: "getrestaurants[restaurantIndexOnMap].photo",
            restaurantName: "getrestaurants[restaurantIndexOnMap].name",
            distance: "4m",
            packetNumber: 0 == 0 ? 'tükendi' : '4 paket',
            availableTime: '2',
            minDiscountedOrderPrice: 0,
            minOrderPrice: 0,
            onPressed: () {},
          ),
        ));
  }

  Padding buildTitlesAndSearchBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
        top: context.dynamicHeight(0.02),
        bottom: context.dynamicHeight(0.02),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildRowTitleLeftRight(
              context, LocaleKeys.my_near_location, LocaleKeys.my_near_edit),
          Divider(
            thickness: 4,
            color: AppColors.borderAndDividerColor,
          ),
          AddressText(),
          SizedBox(height: context.dynamicHeight(0.03)),
          Row(
            children: [
              buildSearchBar(context),
              Spacer(),
              SvgPicture.asset(ImageConstant.COMMONS_FILTER_ICON),
            ],
          ),
          SizedBox(height: context.dynamicHeight(0.03)),
          buildRowTitleLeftRight(
              context,
              LocaleKeys.my_near_body_title,
              isShowOnMap
                  ? LocaleKeys.my_near_show_list
                  : LocaleKeys.my_near_show_map),
          Divider(
            thickness: 4,
            color: AppColors.borderAndDividerColor,
          ),
        ],
      ),
    );
  }

  ListView buildListViewRestaurantInfo(
      List<SearchStore> getrestaurants, List<double> getDistance) {
    print("Search Store: ${getrestaurants.length}");
    print("Distance: ${getDistance.length}");
    return ListView.builder(
        itemCount: getrestaurants.length,
        itemBuilder: (context, index) {
          var boxcount = getrestaurants[index].calendar!.first.boxCount;
          return RestaurantInfoListTile(
            minDiscountedOrderPrice:
                getrestaurants[index].packageSettings!.minDiscountedOrderPrice,
            minOrderPrice: getrestaurants[index].packageSettings!.minOrderPrice,
            onPressed: () {
              Navigator.pushNamed(context, RouteConstant.RESTAURANT_DETAIL,
                  arguments: ScreenArgumentsRestaurantDetail(
                    restaurant: getrestaurants[index],
                  ));
            },
            icon: getrestaurants[index].photo,
            restaurantName: getrestaurants[index].name,
            // distance: "${(double.parse(distance) / 1000).toStringAsFixed(2)}",
            distance: (Haversine.distance(
                        getrestaurants[index].latitude!,
                        getrestaurants[index].longitude,
                        LocationService.latitude,
                        LocationService.longitude) /
                    1000)
                .toStringAsFixed(2),
            packetNumber: "1 paket",
            // getrestaurants[index].calendar?.first.boxCount == null &&
            //         getrestaurants[index].calendar!.first.boxCount == 0
            //     ? "tükendi"
            //     : "${boxcount.toString()} paket",
            availableTime:
                '${getrestaurants[index].packageSettings!.deliveryTimeStart} - ${getrestaurants[index].packageSettings!.deliveryTimeEnd}',
          );
        });
  }

  Row buildRowTitleLeftRight(
      BuildContext context, String titleLeft, String titleRight) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
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
              restaurantInfo = !restaurantInfo;
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
      double mylatitude = LocationService.latitude;
      double mylongitude = LocationService.longitude;
      print("latitude $mylatitude");
      print("longitude $mylongitude");

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
        infoWindow: InfoWindow(title: "Benim Konumum"),
        icon: markerIcon,
        markerId: markerId,
        position: LatLng(mylatitude, mylongitude),
      );
      markers[markerId] = marker;
      for (int i = 0; i < mapsMarkers.length; i++) {
        print("AAAAA ${mapsMarkers[i].latitude!}");
        print("BBBBB ${mapsMarkers[i].longitude!}");

        Marker restMarker = Marker(
          onTap: () {
            setState(() {
              isShowBottomInfo = !isShowBottomInfo;
              restaurantIndexOnMap = i;
            });
          },
          infoWindow: InfoWindow(title: mapsMarkers[i].name),
          icon: restaurantMarkerIcon,
          markerId: MarkerId("rest_$i"),
          position: LatLng(mapsMarkers[i].latitude!, mapsMarkers[i].longitude!),
        );
        markers[MarkerId("rest_$i")] = restMarker;
      }
    });
  }
}
