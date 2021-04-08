import 'dart:async';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:dongu_mobile/data/model/place.dart';
import 'package:dongu_mobile/data/services/location_service.dart';
import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';
import 'package:dongu_mobile/logic/cubits/search_location_cubit/search_location_cubit.dart';
import 'package:dongu_mobile/presentation/widgets/button/custom_button.dart';
import 'package:dongu_mobile/presentation/widgets/scaffold/custom_scaffold.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/extensions/string_extension.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddNewAddressView extends StatefulWidget {
  @override
  _AddNewAddressViewState createState() => _AddNewAddressViewState();
}

class _AddNewAddressViewState extends State<AddNewAddressView> {
  double latitude = 0;
  double longitude = 0;
  final TextEditingController searchController = new TextEditingController();
  List<Placemark> placemark = [];
  String searchedText = "";
  bool isSearchesShown = true;

  Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();

  Map<MarkerId, Marker> markers = Map<MarkerId, Marker>();
  late BitmapDescriptor markerIcon;
  final MarkerId markerId = MarkerId("center");

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      if (searchController.text.isEmpty) {
        setState(() {
          searchedText = " ";
        });
      } else {
        setState(() {
          searchedText = searchController.text;
        });
      }
    });
    setCustomMarker();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: LocaleKeys.address_from_map_title,
      body: Column(
        children: [
          Stack(
            alignment: Alignment(0, -0.965),
            children: [
              Container(
                height: context.dynamicHeight(0.7),
                width: double.infinity,
                child: Stack(
                  alignment: Alignment(0.81, 0.88),
                  children: [
                    GoogleMap(
                      myLocationButtonEnabled: false,
                      onCameraMove: (object) {
                        latitude = object.target.latitude;
                        longitude = object.target.longitude;
                        final Marker marker = Marker(
                          icon: markerIcon,
                          markerId: markerId,
                          position: LatLng(latitude, longitude),
                        );
                        setState(() {
                          markers.clear();
                          markers[markerId] = marker;
                        });
                      },
                      initialCameraPosition: CameraPosition(
                        target: LatLng(latitude, longitude),
                        zoom: 17.0,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        _mapController.complete(controller);
                        final Marker marker = Marker(
                          icon: markerIcon,
                          markerId: markerId,
                          position: LatLng(latitude, longitude),
                        );
                        setState(() {
                          markers[markerId] = marker;
                        });
                      },
                      mapType: MapType.normal,
                      markers: Set<Marker>.of(markers.values),
                    ),
                    GestureDetector(
                        onTap: () async {
                          final GoogleMapController controller = await _mapController.future;
                          setState(() {
                            latitude = LocationService.latitude!;
                            longitude = LocationService.longitude!;

                            controller.animateCamera(CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: LatLng(latitude, longitude),
                                zoom: 17.0,
                              ),
                            ));
                            final Marker marker = Marker(
                              icon: markerIcon,
                              markerId: markerId,
                              position: LatLng(latitude, longitude),
                            );

                            markers.clear();

                            markers[markerId] = marker;
                          });
                        },
                        child: SvgPicture.asset(ImageConstant.COMMONS_MY_LOCATION_BUTTON)),
                  ],
                ),
              ),
              buildSearchBar(context),
              Positioned(
                right: 0,
                left: 0,
                top: context.dynamicHeight(0.07),
                child: buildBuilder(),
              )
            ],
          ),
          Spacer(),
          buildButton(context),
        ],
      ),
    );
  }

  Builder buildBuilder() {
    return Builder(builder: (context) {
      final GenericState state = context.watch<SearchLocationCubit>().state;

      if (state is GenericInitial) {
        return Container();
      } else if (state is GenericLoading) {
        return Container();
      } else if (state is GenericCompleted) {
        return ListView.builder(
            shrinkWrap: true,
            itemCount: state.response.length > 4 ? 5 : state.response.length,
            itemBuilder: (context, index) {
              return state.response.length == 0 || !isSearchesShown ? Container() : buildGestureDetector(state, index, context);
            });
      } else {
        final error = state as GenericError;
        return Center(child: Text("${error.message}\n${error.statusCode}"));
      }
    });
  }

  GestureDetector buildGestureDetector(GenericCompleted state, int index, BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Place place = await getPlace(state.response[index].placeId);
        print("clicked");
        final GoogleMapController controller = await _mapController.future;
        setState(() {
          isSearchesShown = false;
          searchController.text = state.response[index].description;
          latitude = place.geometry!.locationDetails!.lat!;
          longitude = place.geometry!.locationDetails!.lng!;
          controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(latitude, longitude),
              zoom: 17.0,
            ),
          ));
          final Marker marker = Marker(
            icon: markerIcon,
            markerId: markerId,
            position: LatLng(latitude, longitude),
          );

          markers.clear();

          markers[markerId] = marker;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.06)),
        alignment: Alignment.centerLeft,
        color: Colors.white,
        height: 50,
        width: double.infinity,
        child: Text(
          state.response[index].description,
          style: AppTextStyles.bodyTextStyle,
        ),
      ),
    );
  }

  Padding buildSearchBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
      ),
      child: buildTextFormField(context),
    );
  }

  Container buildTextFormField(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(25.0),
          right: Radius.circular(4.0),
        ),
        color: Colors.white,
      ),
      child: TextFormField(
        onTap: () {
          searchController.text = "";
        },
        onChanged: (value) {
          setState(() {
            isSearchesShown = true;
          });
          context.read<SearchLocationCubit>().getLocations(searchedText);
          print("getloc");
        },
        controller: searchController,
        cursorColor: AppColors.cursorColor,
        style: AppTextStyles.bodyTextStyle,
        decoration: InputDecoration(
          prefixIcon: Container(
            margin: EdgeInsets.only(right: context.dynamicWidht(0.03)),
            child: SvgPicture.asset(
              ImageConstant.COMMONS_SEARCH_ICON,
            ),
          ),
          border: buildOutlineInputBorder(),
          focusedBorder: buildOutlineInputBorder(),
          enabledBorder: buildOutlineInputBorder(),
          errorBorder: buildOutlineInputBorder(),
          disabledBorder: buildOutlineInputBorder(),
          contentPadding: EdgeInsets.zero,
          hintText: LocaleKeys.address_from_map_hint_text.locale,
        ),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(25.0),
        right: Radius.circular(4.0),
      ),
      borderSide: BorderSide(
        width: 2.0,
        color: AppColors.borderAndDividerColor,
      ),
    );
  }

  Padding buildButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
        bottom: context.dynamicHeight(0.03),
      ),
      child: CustomButton(
        width: double.infinity,
        title: LocaleKeys.address_from_map_button,
        color: AppColors.greenColor,
        borderColor: AppColors.greenColor,
        textColor: Colors.white,
        onPressed: () async {
          await getLocationDetails();
          print(placemark[0].locality);
          print(placemark[0].administrativeArea);
          print(placemark[0].subLocality);
          print(placemark[0].subThoroughfare);
          print(placemark[0].thoroughfare);
        },
      ),
    );
  }

  Future<Place> getPlace(String placeId) async {
    var url = 'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=AIzaSyDmbISvHTI8ohyLzmek96__1ACHqTNkPLg';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResult = json['result'] as Map<String, dynamic>;
    return Place.fromJson(jsonResult);
  }

  void setCustomMarker() async {
    markerIcon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5), ImageConstant.COMMONS_MAP_MARKER);
    getLocation();
  }

  Future<void> getLocation() async {
    await LocationService.getCurrentLocation();
    final GoogleMapController controller = await _mapController.future;
    setState(() {
      latitude = LocationService.latitude!;
      longitude = LocationService.longitude!;

      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 17.0,
        ),
      ));
      final Marker marker = Marker(
        icon: markerIcon,
        markerId: markerId,
        position: LatLng(latitude, longitude),
      );

      markers.clear();

      markers[markerId] = marker;
    });
  }

  Future<void> getLocationDetails() async {
    placemark = await placemarkFromCoordinates(latitude, longitude);
  }
}
