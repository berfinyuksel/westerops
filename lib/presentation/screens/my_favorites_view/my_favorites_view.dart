import 'dart:async';
import 'dart:ui' as ui;

import 'package:dongu_mobile/logic/cubits/my_favorites_page/cubit/my_favorites_cubit.dart';
import 'package:dongu_mobile/presentation/screens/my_favorites_view/components/search_bar.dart';
import 'package:dongu_mobile/presentation/screens/my_favorites_view/empty_my_favorites_view.dart';
import 'package:dongu_mobile/presentation/widgets/circular_progress_indicator/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../data/model/search_store.dart';
import '../../../data/services/location_service.dart';
import '../../../data/shared/shared_prefs.dart';
import '../../../utils/constants/image_constant.dart';
import '../../../utils/constants/route_constant.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/extensions/string_extension.dart';
import '../../../utils/haversine.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/restaurant_info_list_tile/restaurant_info_list_tile.dart';
import '../../widgets/text/locale_text.dart';
import '../restaurant_details_views/screen_arguments/screen_arguments.dart';
import 'components/address_text.dart';
import 'components/map_bottom_info_.dart';
import 'components/no_favorites.dart';

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
  List<SearchStore> mapsMarkers = [];

  @override
  Widget build(BuildContext context) {
    if (SharedPrefs.getIsLogined == false) {
      return EmptyMyFavoritesView();
    } else {
      return MultiBlocProvider(
        providers: [
          BlocProvider<MyFavoritesCubit>(
            create: (BuildContext context) => MyFavoritesCubit()..init(),
          ),
        ],
        child: BlocBuilder<MyFavoritesCubit, MyFavoritesState>(
          builder: (context, state) {
            if (state.isLoading) {
              return Center(child: CustomCircularProgressIndicator());
            }
            return buildBody(context, state);
          },
        ),
      );
    }
  }

  Widget buildBody(BuildContext context, MyFavoritesState state) {
    mapsMarkers = state.favoritedRestaurants ?? [];
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Center(
        child: Column(
          children: [
            buildTitlesAndSearchBar(context, state.favoritedRestaurants ?? []),
            state.isShowOnMap
                ? buildMapBody(context, state)
                : buildListBody(state),
          ],
        ),
      ),
    );
  }

  Expanded buildMapBody(BuildContext context, MyFavoritesState state) {
    return Expanded(
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
                    target: LatLng(41.0082, 28.9784),
                    zoom: 10.0,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _mapController.complete(controller);
                  },
                  mapType: MapType.normal,
                  markers: Set<Marker>.of(markers.values),
                ),
                GestureDetector(
                  onTap: () {
                    showLocationOnMap();
                  },
                  child: SvgPicture.asset(
                      ImageConstant.COMMONS_MY_LOCATION_BUTTON),
                ),
                Visibility(
                  visible: state.isShowBottomInfo,
                  child: GestureDetector(
                    onTap: () {
                      context.read<MyFavoritesCubit>().hideBottomInfo();
                    },
                    child: Container(
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: state.isShowBottomInfo,
              child: MapBottomInfo(
                state: state,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListBody(MyFavoritesState state) {
    if (state.favoritedRestaurants == null) {
      return CustomCircularProgressIndicator();
    } else {
      if (state.favoritedRestaurants!.isNotEmpty) {
        return buildListViewRestaurantInfo(state.favoritedRestaurants ?? []);
      }
      return NoFavorites();
    }
  }

  Padding buildTitlesAndSearchBar(
      BuildContext context, List<SearchStore> favouriteRestaurant) {
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
            context,
            LocaleKeys.my_favorites_location,
            LocaleKeys.my_favorites_edit,
            favouriteRestaurant,
            () {
              Navigator.pushNamed(context, RouteConstant.ADDRESS_FROM_MAP_VIEW);
            },
          ),
          Divider(
            thickness: 4,
            color: AppColors.borderAndDividerColor,
          ),
          AddressText(),
          SizedBox(height: 30.h),
          Row(
            children: [
              SearchBar(),
              SizedBox(width: 16.w),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RouteConstant.FILTER_VIEW);
                  },
                  child: SvgPicture.asset(ImageConstant.COMMONS_FILTER_ICON)),
            ],
          ),
          SizedBox(height: 40.h),
          BlocBuilder<MyFavoritesCubit, MyFavoritesState>(
            builder: (context, state) {
              return buildRowTitleLeftRight(
                context,
                LocaleKeys.my_favorites_body_title,
                state.isShowOnMap
                    ? LocaleKeys.my_near_show_list
                    : LocaleKeys.my_favorites_show_map,
                favouriteRestaurant,
                () {
                  context.read<MyFavoritesCubit>().toogleShowOnMap();
                  if (state.isShowOnMap)
                    context.read<MyFavoritesCubit>().init();
                  setState(() {
                    _mapController = Completer<GoogleMapController>();
                    setCustomMarker(favouriteRestaurant);
                  });
                },
              );
            },
          ),
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
    return Expanded(
      child: ListView.builder(
          itemCount: favouriteRestaurant.length,
          itemBuilder: (context, index) {
            return Container(child: Builder(builder: (context) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RouteConstant.RESTAURANT_DETAIL,
                    arguments: ScreenArgumentsRestaurantDetail(
                      restaurant: favouriteRestaurant[index],
                    ),
                  );
                },
                child: RestaurantInfoListTile(
                  deliveryType: int.parse(favouriteRestaurant[index]
                          .packageSettings!
                          .deliveryType ??
                      '3'),
                  minDiscountedOrderPrice: favouriteRestaurant[index]
                      .packageSettings!
                      .minDiscountedOrderPrice,
                  minOrderPrice:
                      favouriteRestaurant[index].packageSettings!.minOrderPrice,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RouteConstant.RESTAURANT_DETAIL,
                      arguments: ScreenArgumentsRestaurantDetail(
                        restaurant: favouriteRestaurant[index],
                      ),
                    );
                  },
                  icon: favouriteRestaurant[index].photo,
                  restaurantName: favouriteRestaurant[index].name,
                  distance: Haversine.distance(
                          favouriteRestaurant[index].latitude!,
                          favouriteRestaurant[index].longitude,
                          LocationService.latitude,
                          LocationService.longitude)
                      .toStringAsFixed(2),
                  availableTime:
                      '${favouriteRestaurant[index].packageSettings!.deliveryTimeStart} - ${favouriteRestaurant[index].packageSettings!.deliveryTimeEnd}',
                  restaurantId: favouriteRestaurant[index].id!,
                ),
              );
            }));
          }),
    );
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

  void setCustomMarker(List<SearchStore> favouriteRestaurant) async {
    markerIcon =
        await _bitmapDescriptorFromSvgAsset(ImageConstant.COMMONS_MAP_MARKER);
    restaurantMarkerIcon = await _bitmapDescriptorFromSvgAsset(
        ImageConstant.COMMONS_RESTAURANT_MARKER);
    restaurantSoldoutMarkerIcon = await _bitmapDescriptorFromSvgAsset(
        ImageConstant.COMMONS_RESTAURANT_SOLDOUT_MARKER);
    getLocation(favouriteRestaurant);
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
          context.read<MyFavoritesCubit>().hideBottomInfo();
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
          if (DateTime.parse(
                      mapsMarkers[i].calendar![j].startDate!.toIso8601String())
                  .day ==
              DateTime.now().toLocal().day) {
            dailyBoxCount = mapsMarkers[i].calendar![j].boxCount;
          }
        }
        Marker restMarker = Marker(
          onTap: () {
            context.read<MyFavoritesCubit>().toggleBottomInfo();
            context.read<MyFavoritesCubit>().setSelectedIndex(i);
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

  showLocationOnMap() async {
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
    });
  }
}
