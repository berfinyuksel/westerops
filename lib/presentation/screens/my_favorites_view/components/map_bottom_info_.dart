import 'package:dongu_mobile/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/services/location_service.dart';
import '../../../../logic/cubits/my_favorites_page/cubit/my_favorites_cubit.dart';
import '../../../../utils/constants/route_constant.dart';
import '../../../../utils/haversine.dart';
import '../../../../utils/locale_keys.g.dart';
import '../../../widgets/restaurant_info_list_tile/restaurant_info_list_tile.dart';
import '../../restaurant_details_views/screen_arguments/screen_arguments.dart';

class MapBottomInfo extends StatelessWidget {
  final MyFavoritesState state;
  const MapBottomInfo({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      left: 0,
      bottom: 0,
      child: state.favoritedRestaurants?.isNotEmpty ?? false
          ? GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RouteConstant.RESTAURANT_DETAIL,
                  arguments: ScreenArgumentsRestaurantDetail(
                    restaurant:
                        state.favoritedRestaurants![state.selectedIndex],
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                height: 124.h,
                padding: EdgeInsets.symmetric(vertical: 28.w),
                color: Colors.white,
                child: RestaurantInfoListTile(
                  minDiscountedOrderPrice: state
                      .favoritedRestaurants![state.selectedIndex]
                      .packageSettings!
                      .minDiscountedOrderPrice,
                  minOrderPrice: state
                      .favoritedRestaurants![state.selectedIndex]
                      .packageSettings!
                      .minOrderPrice,
                  deliveryType: int.parse(state
                      .favoritedRestaurants![state.selectedIndex]
                      .packageSettings!
                      .deliveryType!),
                  restaurantName:
                      state.favoritedRestaurants![state.selectedIndex].name,
                  distance: Haversine.distance(
                          state.favoritedRestaurants![state.selectedIndex]
                              .latitude!,
                          state.favoritedRestaurants![state.selectedIndex]
                              .longitude!,
                          LocationService.latitude,
                          LocationService.longitude)
                      .toStringAsFixed(2),
                  availableTime:
                      '${state.favoritedRestaurants![state.selectedIndex].packageSettings!.deliveryTimeStart} - ${state.favoritedRestaurants![state.selectedIndex].packageSettings!.deliveryTimeEnd}',
                  onPressed: () {
                    Navigator.pushNamed(
                        context, RouteConstant.RESTAURANT_DETAIL,
                        arguments: ScreenArgumentsRestaurantDetail(
                          restaurant:
                              state.favoritedRestaurants![state.selectedIndex],
                        ));
                  },
                  icon: state.favoritedRestaurants![state.selectedIndex].photo,
                  restaurantId:
                      state.favoritedRestaurants![state.selectedIndex].id!,
                ),
              ),
            )
          : SizedBox(height: 0, width: 0),
    );
  }
}
