import 'dart:async';
import 'dart:ui' as ui;

import 'package:dongu_mobile/data/model/search_store.dart';
import 'package:dongu_mobile/data/repositories/search_store_repository.dart';
import 'package:dongu_mobile/data/services/location_service.dart';
import 'package:dongu_mobile/data/services/locator.dart';
import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/logic/cubits/favourite_cubit/get_all_favourite.dart';
import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';
import 'package:dongu_mobile/logic/cubits/search_store_cubit/search_store_cubit.dart';
import 'package:dongu_mobile/presentation/screens/my_favorites_view/components/address_text.dart';
import 'package:dongu_mobile/presentation/screens/restaurant_details_views/screen_arguments/screen_arguments.dart';
import 'package:dongu_mobile/presentation/widgets/circular_progress_indicator/custom_circular_progress_indicator.dart';
import 'package:dongu_mobile/presentation/widgets/restaurant_info_list_tile/restaurant_info_list_tile.dart';
import 'package:dongu_mobile/presentation/widgets/scaffold/custom_scaffold.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:dongu_mobile/utils/haversine.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/extensions/context_extension.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



import '../../../../utils/extensions/string_extension.dart';

class FilterFavoritesView extends StatefulWidget {
  @override
  _FilterFavoritesViewState createState() => _FilterFavoritesViewState();
}

class _FilterFavoritesViewState extends State<FilterFavoritesView> {

  double latitude = 0;
  double longitude = 0;

  bool isShowOnMap = false;
  bool isShowBottomInfo = false;
  List<SearchStore> mapsMarkers = [];

  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    context.read<AllFavoriteCubit>().getFavorite();
    context.read<SearchStoreCubit>().getSearchStore();
    sl<SampleSearchStoreRepository>().searchStores;
  }

  @override
  Widget build(BuildContext context) {
    context.read<AllFavoriteCubit>().getFavorite();
    return buildBuilder();
  }

  Builder buildBuilder() {
    return Builder(builder: (context) {
      final GenericState state = context.watch<SearchStoreCubit>().state;
      //final FiltersState filterState = context.watch<FiltersCubit>().state;

      if (state is GenericInitial) {
        return Container(color: Colors.white);
      } else if (state is GenericLoading) {
        return Container(
            color: Colors.white,
            child: Center(child: CustomCircularProgressIndicator()));
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

  Builder buildBody(
      BuildContext context, List<SearchStore> favourites, GenericState state) {
    return Builder(builder: (context) {
      final GenericState stateOfFavorites =
          context.watch<AllFavoriteCubit>().state;

      if (stateOfFavorites is GenericInitial) {
        return Container(color: Colors.white);
      } else if (stateOfFavorites is GenericLoading) {
        return Container(
            color: Colors.white,
            child: Center(child: CustomCircularProgressIndicator()));
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
        return CustomScaffold(
          title: LocaleKeys.filters_done_title.locale,
          isDrawer: false,
        
          body: Column(
            children: [
              
              Visibility(
                  visible: !isShowOnMap,
                  child: !SharedPrefs.getIsLogined
                      ? Padding(
                          padding: EdgeInsets.all(24.h),
                          child: LocaleText(
                            alignment: ui.TextAlign.center,
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
                                        height: 40.h,
                                      ),
                                      SvgPicture.asset(
                                          ImageConstant.SURPRISE_PACK_ALERT),
                                      SizedBox(
                                        height: 20.h,
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
          ),
        );
      } else {
        final error = stateOfFavorites as GenericError;
        return Center(child: Text("${error.message}\n${error.statusCode}"));
      }
    });
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
                return LocaleKeys.home_page_soldout_icon.locale;
              } else if (favouriteRestaurant[index].calendar != null) {
                for (int i = 0;
                    i < favouriteRestaurant[index].calendar!.length;
                    i++) {
                  var boxcount =
                      favouriteRestaurant[index].calendar![i].boxCount;

                  String now = DateTime.now().toIso8601String();
                  List<String> currentDate = now.split("T").toList();
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
                      return LocaleKeys.home_page_soldout_icon.locale;
                    }
                  }
                }
              }
            }

            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RouteConstant.RESTAURANT_DETAIL,
                    arguments: ScreenArgumentsRestaurantDetail(
                      restaurant: favouriteRestaurant[index],
                    ));
              },
              child: RestaurantInfoListTile(
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
                    packettNumber() ?? LocaleKeys.home_page_soldout_icon.locale,
                availableTime:
                    '${favouriteRestaurant[index].packageSettings!.deliveryTimeStart} - ${favouriteRestaurant[index].packageSettings!.deliveryTimeEnd}',
              ),
            );
          }));
        });
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
