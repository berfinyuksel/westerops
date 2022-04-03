import 'package:dongu_mobile/presentation/widgets/circular_progress_indicator/custom_circular_progress_indicator.dart';
import 'dart:typed_data';

import 'package:dongu_mobile/data/services/location_service.dart';
import 'package:dongu_mobile/presentation/screens/restaurant_details_views/screen_arguments/screen_arguments.dart';
import 'package:dongu_mobile/presentation/widgets/restaurant_info_list_tile/restaurant_info_list_tile.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/extensions/string_extension.dart';
import 'package:dongu_mobile/utils/haversine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'dart:ui' as ui;
import '../../../../data/model/search_store.dart';
import '../../../../data/services/locator.dart';
import '../../../../data/shared/shared_prefs.dart';
import '../../../../logic/cubits/address_cubit/address_cubit.dart';
import '../../../../logic/cubits/generic_state/generic_state.dart';
import '../../../../logic/cubits/search_store_cubit/search_store_cubit.dart';
import '../../../../utils/constants/route_constant.dart';
import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/locale_keys.g.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/button/custom_button.dart';
import '../../../widgets/text/locale_text.dart';
import '../../address_view/components/adress_list_tile.dart';
import 'components/get_it_address_list_tile.dart';

class PaymentAddressView extends StatefulWidget {
  final bool? isGetIt;

  const PaymentAddressView({Key? key, this.isGetIt}) : super(key: key);

  @override
  _PaymentAddressViewState createState() => _PaymentAddressViewState();
}

class _PaymentAddressViewState extends State<PaymentAddressView> {
  bool checkboxValue = false;
  bool isShowOnMap = false;
  bool isShowBottomInfo = false;
  double latitude = 0;
  double longitude = 0;
  Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  Map<MarkerId, Marker> markers = Map<MarkerId, Marker>();
  late BitmapDescriptor markerIcon;
  late BitmapDescriptor restaurantMarkerIcon;
  late BitmapDescriptor restaurantSoldoutMarkerIcon;
  final MarkerId markerId = MarkerId("my_location");
  final MarkerId restaurantMarkerId = MarkerId("rest_1");
/*   @override
  void initState() {
    super.initState();
   // context.read<SearchStoreCubit>().getSearchStore();
  //  context.read<AddressCubit>().getActiveAddress();
  } */

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<SearchStoreCubit>(
            create: (BuildContext context) =>
                sl<SearchStoreCubit>()..getSearchStore(),
          ),
          BlocProvider<SearchStoreCubit>(
            create: (BuildContext context) =>
                sl<SearchStoreCubit>()..getSearchStoreAddress(),
          ),
          BlocProvider.value(value: sl<AddressCubit>()..getActiveAddress()),
        ],
        child: BlocBuilder<SearchStoreCubit, GenericState>(
          builder: (context, state) {
            if (state is GenericInitial) {
              print("GENERIC INITIAL ADDRESS");

              return Container();
            } else if (state is GenericLoading) {
              print("GENERIC LOADING ADDRESS");
              return Center(child: CustomCircularProgressIndicator());
            } else if (state is GenericCompleted) {
              print("GENERIC COMPLETED ADDRESS");

              List<SearchStore> restaurants = [];
              List<SearchStore> deliveredRestaurant = [];
              int? restaurantId = SharedPrefs.getDeliveredRestaurantAddressId;

              for (int i = 0; i < state.response.length; i++) {
                restaurants.add(state.response[i]);
              }

              for (var i = 0; i < restaurants.length; i++) {
                if (restaurants[i].id == restaurantId) {
                  deliveredRestaurant.add(restaurants[i]);
                }
              }

              return Center(
                child: buildBody(context, deliveredRestaurant),
              );
            } else {
              final error = state as GenericError;
              return Center(
                  child: Text("${error.message}\n${error.statusCode}"));
            }
          },
        ));
  }

  Widget buildBody(
      BuildContext context, List<SearchStore> deliveredRestaurant) {
    return BlocBuilder<AddressCubit, GenericState>(builder: (context, state) {
      if (state is GenericCompleted) {
        if (deliveredRestaurant.isEmpty) {
          return LocaleText(
            text: LocaleKeys.payment_address_restaurant_address,
          );
        } else {
          return Container(
            height: 530.h,
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: 40.h,
                ),
                buildRowTitleLeftRight(
                    context,
                    widget.isGetIt!
                        ? LocaleKeys.payment_address_from_address
                        : LocaleKeys.payment_address_to_address,
                    widget.isGetIt!
                        ? LocaleKeys.payment_address_show_on_map
                        : LocaleKeys.payment_address_change,
                    deliveredRestaurant),
                SizedBox(
                  height: 10.h,
                ),
                Visibility(
                  visible: widget.isGetIt!,
                  child: !isShowOnMap
                      ? GetItAddressListTile(
                          userAddress:
                              '${deliveredRestaurant[0].address} ${deliveredRestaurant[0].province}',
                          userAddressName: deliveredRestaurant[0].name,
                          restaurantName: deliveredRestaurant[0].name,
                          address:
                              '${deliveredRestaurant[0].address} ${deliveredRestaurant[0].province}',
                        )
                      : Container(
                          height: context.dynamicHeight(0.5),
                          width: double.infinity,
                          child: Stack(
                            children: [
                              Stack(
                                alignment: Alignment(0.81, 0.88),
                                children: [
                                  GoogleMap(
                                    //  myLocationEnabled: true,
                                    myLocationButtonEnabled: false,
                                    initialCameraPosition: CameraPosition(
                                      target: LatLng(41.0082, 28.9784),
                                      zoom: 10.0,
                                    ),
                                    onMapCreated:
                                        (GoogleMapController controller) {
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
                                    child: SvgPicture.asset(ImageConstant
                                        .COMMONS_MY_LOCATION_BUTTON),
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
                                              color: Colors.black
                                                  .withOpacity(0.2)))),
                                ],
                              ),
                              Visibility(
                                visible: isShowBottomInfo,
                                child: buildBottomInfo(
                                    context, deliveredRestaurant),
                              ),
                            ],
                          ),
                        ),
                ),
                Visibility(
                  visible: !widget.isGetIt!,
                  child: Column(children: [
                    AddressListTile(
                      title: state.response[0].name,
                      subtitleBold: state.response[0].province,
                      address:
                          "\n${state.response[0].address}\n${state.response[0].phoneNumber}\n${state.response[0].description}",
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    buildButtonDeliveryAndBillingAddress(
                        context, LocaleKeys.payment_address_button_add_address),
                    SizedBox(
                      height: 20.h,
                    ),
                  ]),
                ),
              ],
            ),
          );
        }
      } else if (state is GenericInitial) {
        return Container();
      } else if (state is GenericLoading) {
        return Center(child: CustomCircularProgressIndicator());
      } else {
        final error = state as GenericError;
        if (error.statusCode == 204.toString()) {
          return Column(
            children: [
              SizedBox(height: 20.h),
              LocaleText(
                text: LocaleKeys.payment_address_active_address,
              ),
            ],
          );
        }
        return Center(child: Text("${error.message}\n${error.statusCode}"));
      }
    });
    /*    Builder(builder: (context) {
      final GenericState state =
          context.watch<AddressCubit>().state;

  
    }); */
  }

  Padding buildRowCheckBox(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 28.w),
      child: Row(
        children: [
          buildCheckBox(context),
          SizedBox(width: 20.h),
          LocaleText(
            text: LocaleKeys.payment_address_use_as_billing,
            style: AppTextStyles.subTitleStyle,
          ),
        ],
      ),
    );
  }

  Padding buildRowTitleLeftRight(BuildContext context, String titleLeft,
      String titleRight, List<SearchStore> deliveredRestaurant) {
    return Padding(
      padding: EdgeInsets.only(
        left: 28.w,
        right: 28.w,
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
              if (titleRight == LocaleKeys.payment_address_change) {
                //   Navigator.of(context).pushNamed(RouteConstant.ADDRESS_VIEW);
                Navigator.of(context)
                    .pushReplacementNamed(RouteConstant.ADDRESS_VIEW);
              } else {
                setState(() {
                  isShowOnMap = !isShowOnMap;
                  _mapController = Completer<GoogleMapController>();
                  setCustomMarker(deliveredRestaurant);
                });
              }
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

  Padding buildButtonDeliveryAndBillingAddress(
      BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.only(
        left: 28.w,
        right: 28.w,
      ),
      child: CustomButton(
        width: double.infinity,
        title: title,
        color: Colors.transparent,
        borderColor: AppColors.greenColor,
        textColor: AppColors.greenColor,
        onPressed: () {
          Navigator.of(context).pushNamed(RouteConstant.ADDRESS_VIEW);
        },
      ),
    );
  }

  Container buildCheckBox(BuildContext context) {
    return Container(
      height: 40.h,
      width: 40.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
          color: Color(0xFFD1D0D0),
        ),
      ),
      child: Theme(
        data: ThemeData(unselectedWidgetColor: Colors.transparent),
        child: Checkbox(
          checkColor: Colors.greenAccent,
          activeColor: Colors.transparent,
          value: checkboxValue,
          onChanged: (value) {
            setState(() {
              checkboxValue = value!;
            });
          },
        ),
      ),
    );
  }

  Widget buildBottomInfo(
      BuildContext context, List<SearchStore> deliveredRestaurant) {
    return BlocBuilder<SearchStoreCubit, GenericState>(
        builder: ((context, state) {
      if (state is GenericInitial) {
        return Container();
      } else if (state is GenericLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (state is GenericCompleted) {
        return Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: Container(
              width: double.infinity,
              height: 176.h,
              padding: EdgeInsets.symmetric(vertical: 20.h),
              color: Colors.white,
              child: RestaurantInfoListTile(
                minDiscountedOrderPrice: deliveredRestaurant
                    .first.packageSettings!.minDiscountedOrderPrice,
                minOrderPrice:
                    deliveredRestaurant.first.packageSettings!.minOrderPrice,
                deliveryType: int.parse(
                    deliveredRestaurant.first.packageSettings!.deliveryType!),
                restaurantName: deliveredRestaurant.first.name,
                distance: Haversine.distance(
                        deliveredRestaurant.first.latitude!,
                        deliveredRestaurant.first.longitude!,
                        LocationService.latitude,
                        LocationService.longitude)
                    .toStringAsFixed(2),
                availableTime:
                    '${deliveredRestaurant[0].packageSettings!.deliveryTimeStart} - ${deliveredRestaurant[0].packageSettings!.deliveryTimeEnd}',
                onPressed: () {
                  Navigator.pushNamed(context, RouteConstant.RESTAURANT_DETAIL,
                      arguments: ScreenArgumentsRestaurantDetail(
                        restaurant: deliveredRestaurant.first,
                      ));
                },
                icon: deliveredRestaurant.first.photo,
                restaurantId: deliveredRestaurant.first.id!,
              ),
            ));
      } else {
        final error = state as GenericError;
        return Center(child: Text("${error.message}\n${error.statusCode}"));
      }
    }));
  }

  void setCustomMarker(List<SearchStore> deliveredRestaurant) async {
    markerIcon =
        await _bitmapDescriptorFromSvgAsset(ImageConstant.COMMONS_MAP_MARKER);
    restaurantMarkerIcon = await _bitmapDescriptorFromSvgAsset(
        ImageConstant.COMMONS_RESTAURANT_MARKER);
    restaurantSoldoutMarkerIcon = await _bitmapDescriptorFromSvgAsset(
        ImageConstant.COMMONS_RESTAURANT_SOLDOUT_MARKER);
    getLocation(deliveredRestaurant);
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

  Future<void> getLocation(List<SearchStore> deliveredRestaurant) async {
    await LocationService.getCurrentLocation();
    final GoogleMapController controller = await _mapController.future;
    setState(() {
      latitude = LocationService.latitude;
      longitude = LocationService.longitude;

      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(41.0082, 28.9784),
          zoom: 10.0,
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
        markerId: MarkerId(deliveredRestaurant.first.id.toString()),
        position: LatLng(deliveredRestaurant.first.latitude!,
            deliveredRestaurant.first.longitude!),
      );
      markers[MarkerId(deliveredRestaurant.first.id.toString())] = restMarker;
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
}
