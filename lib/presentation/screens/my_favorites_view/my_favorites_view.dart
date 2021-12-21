import 'dart:async';
import 'dart:ui' as ui;

import '../../../data/model/search_store.dart';
import '../../../data/shared/shared_prefs.dart';
import '../../../logic/cubits/favourite_cubit/favourite_cubit.dart';
import '../../../logic/cubits/search_store_cubit/search_store_cubit.dart';
import '../restaurant_details_views/screen_arguments/screen_arguments.dart';
import '../../../utils/constants/route_constant.dart';
import '../../../utils/haversine.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../data/services/location_service.dart';
import '../../../logic/cubits/generic_state/generic_state.dart';

import '../../../utils/constants/image_constant.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/restaurant_info_list_tile/restaurant_info_list_tile.dart';
import '../../widgets/text/locale_text.dart';
import 'components/address_text.dart';
import '../../../utils/extensions/string_extension.dart';

class MyFavoritesView extends StatefulWidget {
  @override
  _MyFavoritesViewState createState() => _MyFavoritesViewState();
}

class _MyFavoritesViewState extends State<MyFavoritesView> {
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
  List<SearchStore> mapsMarkers = [];

  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    context.read<FavoriteCubit>().getFavorite();
    context.read<SearchStoreCubit>().getSearchStore();
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
        List<SearchStore> favourites = [];
        //List<double> distances = [];
        print(state.response[0].address);
        for (int i = 0; i < state.response.length; i++) {
          favourites.add(state.response[i]);
        }

        return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Center(child: buildBody(context, favourites, state)));
      } else {
        final error = state as GenericError;
        return Center(child: Text("${error.message}\n${error.statusCode}"));
      }
    });
  }

  Builder buildBody(BuildContext context, List<SearchStore> favourites,
      GenericCompleted state) {
    return Builder(builder: (context) {
      final GenericState stateOfFavorites =
          context.watch<FavoriteCubit>().state;

      if (stateOfFavorites is GenericInitial) {
        return Container();
      } else if (stateOfFavorites is GenericLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (stateOfFavorites is GenericCompleted) {
        List<SearchStore> favouriteRestaurant = [];
        for (var i = 0; i < favourites.length; i++) {
          for (var j = 0; j < stateOfFavorites.response.length; j++) {
            if (favourites[i].id == stateOfFavorites.response[j].id) {
              favouriteRestaurant.add(favourites[i]);
            }
          }
        }
        mapsMarkers = favouriteRestaurant;

        List<String> favoriteListForShared = [];
        for (var i = 0; i < favouriteRestaurant.length; i++) {
          favoriteListForShared.add(favouriteRestaurant[i].id.toString());
        }

        SharedPrefs.setFavoriteIdList(favoriteListForShared);
        return Column(
          children: [
            buildTitlesAndSearchBar(context, favouriteRestaurant),
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

                                controller.animateCamera(
                                    CameraUpdate.newCameraPosition(
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
                        child: buildBottomInfo(context, favouriteRestaurant),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
                visible: !isShowOnMap,
                child: !SharedPrefs.getIsLogined
                    ? Center(
                        child: LocaleText(
                          text: LocaleKeys.my_favorites_sign_in_to_monitor,
                          style: AppTextStyles.bodyTextStyle
                              .copyWith(color: AppColors.cursorColor),
                        ),
                      )
                    : Expanded(
                        child: favouriteRestaurant.isNotEmpty
                            ? buildListViewRestaurantInfo(favouriteRestaurant)
                            : Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 40,
                                    ),
                                    SvgPicture.asset(
                                        ImageConstant.SURPRISE_PACK_ALERT),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    LocaleText(
                                      alignment: TextAlign.center,
                                      text:
                                          LocaleKeys.my_favorites_no_favorites,
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                              ))),
          ],
        );
      } else {
        final error = stateOfFavorites as GenericError;
        return Center(child: Text("${error.message}\n${error.statusCode}"));
      }
    });
  }

  Padding buildTitlesAndSearchBar(
      BuildContext context, List<SearchStore> favouriteRestaurant) {
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
          buildRowTitleLeftRight(context, LocaleKeys.my_favorites_location,
              LocaleKeys.my_favorites_edit, favouriteRestaurant, () {
            Navigator.pushNamed(context, RouteConstant.ADDRESS_FROM_MAP_VIEW);
          }),
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
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RouteConstant.FILTER_VIEW);
                  },
                  child: SvgPicture.asset(ImageConstant.COMMONS_FILTER_ICON)),
            ],
          ),
          SizedBox(height: context.dynamicHeight(0.03)),
          buildRowTitleLeftRight(
              context,
              LocaleKeys.my_favorites_body_title,
              isShowOnMap
                  ? LocaleKeys.my_near_show_list
                  : LocaleKeys.my_favorites_show_map,
              favouriteRestaurant, () {
            setState(() {
              isShowOnMap = !isShowOnMap;
              _mapController = Completer<GoogleMapController>();
              setCustomMarker(favouriteRestaurant);
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

  Widget buildListViewRestaurantInfo(
    List<SearchStore> favouriteRestaurant,
  ) {
    return ListView.builder(
        itemCount: favouriteRestaurant.length,
        itemBuilder: (context, index) {
          return Container(child: Builder(builder: (context) {
            String? packettNumber() {
              if (favouriteRestaurant[index].calendar == null) {
                return LocaleKeys.home_page_soldout_icon;
              } else if (favouriteRestaurant[index].calendar != null) {
                for (int i = 0;
                    i < favouriteRestaurant[index].calendar!.length;
                    i++) {
                  var boxcount =
                      favouriteRestaurant[index].calendar![i].boxCount;

                  String now = DateTime.now().toIso8601String();
                  List<String> currentDate = now.split("T").toList();
                  print(currentDate[0]);
                  List<String> startDate = favouriteRestaurant[index]
                      .calendar![i]
                      .startDate!
                      .toString()
                      .split("T")
                      .toList();

                  if (currentDate[0] == startDate[0]) {
                    if (favouriteRestaurant[index].calendar![i].boxCount != 0) {
                      return "${boxcount.toString()} ${LocaleKeys.home_page_packet_number.locale}";
                    } else if (favouriteRestaurant[index]
                                .calendar![i]
                                .boxCount ==
                            null ||
                        favouriteRestaurant[index].calendar![i].boxCount == 0) {
                      return LocaleKeys.home_page_soldout_icon;
                    }
                  }
                }
              }
            }

            return RestaurantInfoListTile(
              deliveryType: int.parse(
                  favouriteRestaurant[index].packageSettings!.deliveryType ??
                      '3'),
              minDiscountedOrderPrice: favouriteRestaurant[index]
                  .packageSettings!
                  .minDiscountedOrderPrice,
              minOrderPrice:
                  favouriteRestaurant[index].packageSettings!.minOrderPrice,
              onPressed: () {
                Navigator.pushNamed(context, RouteConstant.RESTAURANT_DETAIL,
                    arguments: ScreenArgumentsRestaurantDetail(
                      restaurant: favouriteRestaurant[index],
                    ));
              },
              icon: favouriteRestaurant[index].photo,
              restaurantName: favouriteRestaurant[index].name,
              distance: Haversine.distance(
                      favouriteRestaurant[index].latitude!,
                      favouriteRestaurant[index].longitude,
                      LocationService.latitude,
                      LocationService.longitude)
                  .toStringAsFixed(2),
              packetNumber:
                  packettNumber() ?? LocaleKeys.home_page_soldout_icon,
              availableTime:
                  '${favouriteRestaurant[index].packageSettings!.deliveryTimeStart} - ${favouriteRestaurant[index].packageSettings!.deliveryTimeEnd}',
            );
          }));
        });
  }

  Row buildRowTitleLeftRight(BuildContext context, String titleLeft,
      String titleRight, favouriteRestaurant, VoidCallback onPressed) {
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
        inputFormatters: [
          //FilteringTextInputFormatter.deny(RegExp('[a-zA-Z0-9]'))
          FilteringTextInputFormatter.singleLineFormatter,
        ],
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

  void setCustomMarker(List<SearchStore> favouriteRestaurant) async {
    markerIcon =
        await _bitmapDescriptorFromSvgAsset(ImageConstant.COMMONS_MAP_MARKER);
    restaurantMarkerIcon = await _bitmapDescriptorFromSvgAsset(
        ImageConstant.COMMONS_RESTAURANT_MARKER);
    restaurantSoldoutMarkerIcon = await _bitmapDescriptorFromSvgAsset(
        ImageConstant.COMMONS_RESTAURANT_SOLDOUT_MARKER);
    getLocation(favouriteRestaurant);
  }

  Positioned buildBottomInfo(
      BuildContext context, List<SearchStore> favourites) {
    return Positioned(
      right: 0,
      left: 0,
      bottom: 0,
      child: favourites.isNotEmpty
          ? Container(
              width: double.infinity,
              height: context.dynamicHeight(0.176),
              padding:
                  EdgeInsets.symmetric(vertical: context.dynamicHeight(0.02)),
              color: Colors.white,
              child: RestaurantInfoListTile(
                minDiscountedOrderPrice: favourites[selectedIndex]
                    .packageSettings!
                    .minDiscountedOrderPrice,
                minOrderPrice:
                    favourites[selectedIndex].packageSettings!.minOrderPrice,
                packetNumber: favourites[selectedIndex]
                            .calendar!
                            .first
                            .boxCount ==
                        0
                    ? LocaleKeys.home_page_soldout_icon
                    : "${favourites[selectedIndex].calendar!.first.boxCount} ${LocaleKeys.home_page_packet_number.locale}",
                deliveryType: int.parse(
                    favourites[selectedIndex].packageSettings!.deliveryType!),
                restaurantName: favourites[selectedIndex].name,
                distance: Haversine.distance(
                        favourites[selectedIndex].latitude!,
                        favourites[selectedIndex].longitude!,
                        LocationService.latitude,
                        LocationService.longitude)
                    .toStringAsFixed(2),
                availableTime:
                    '${favourites[selectedIndex].packageSettings!.deliveryTimeStart} - ${favourites[selectedIndex].packageSettings!.deliveryTimeEnd}',
                onPressed: () {
                  Navigator.pushNamed(context, RouteConstant.RESTAURANT_DETAIL,
                      arguments: ScreenArgumentsRestaurantDetail(
                        restaurant: favourites[selectedIndex],
                      ));
                },
                icon: favourites[selectedIndex].photo,
              ),
            )
          : SizedBox(height: 0, width: 0),
    );
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

  Future<void> getLocation(List<SearchStore> favouriteRestaurant) async {
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
        infoWindow:
            InfoWindow(title: LocaleKeys.general_settings_my_location.locale),
        icon: markerIcon,
        markerId: markerId,
        position: LatLng(latitude, longitude),
      );
      markers[markerId] = marker;

      for (int i = 0; i < mapsMarkers.length; i++) {
        int? dailyBoxCount;

        for (var j = 0; j < mapsMarkers[i].calendar!.length; j++) {
          if (DateTime.parse(mapsMarkers[i].calendar![j].startDate!).day ==
              DateTime.now().toLocal().day) {
            dailyBoxCount = mapsMarkers[i].calendar![j].boxCount;
          }
        }
        Marker restMarker = Marker(
          onTap: () {
            setState(() {
              isShowBottomInfo = !isShowBottomInfo;
              selectedIndex = i;
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
