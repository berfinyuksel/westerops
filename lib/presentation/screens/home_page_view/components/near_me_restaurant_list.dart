import 'package:dongu_mobile/data/model/search_store.dart';
import 'package:dongu_mobile/data/services/location_service.dart';
import 'package:dongu_mobile/presentation/screens/restaurant_details_views/screen_arguments/screen_arguments.dart';
import 'package:dongu_mobile/presentation/widgets/restaurant_info_card/restaurant_info_card.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/haversine.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NearMeRestaurantListViewWidget extends StatelessWidget {
  final List<SearchStore> restaurants;
  final ScrollController? controller;

  const NearMeRestaurantListViewWidget({Key? key, required this.restaurants, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthOfOpportunity = context.dynamicWidht(0.64);
    return ListView.separated(
      padding: EdgeInsets.only(
        left: 26.w,
        right: 26.w,
      ),
      controller: controller,
      itemCount: restaurants.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, RouteConstant.RESTAURANT_DETAIL,
                arguments: ScreenArgumentsRestaurantDetail(
                  restaurant: restaurants[index],
                ));
          },
          child: Builder(builder: (context) {
            return RestaurantInfoCard(
              width: widthOfOpportunity,
              restaurantId: restaurants[index].id!,
              courierPackageBGColor:
                  restaurants[index].packageSettings!.deliveryType == "2" || restaurants[index].packageSettings!.deliveryType == "3"
                      ? AppColors.greenColor
                      : Colors.white,
              courierPackageIconColor:
                  restaurants[index].packageSettings!.deliveryType == "2" || restaurants[index].packageSettings!.deliveryType == "3"
                      ? Colors.white
                      : AppColors.unSelectedpackageDeliveryColor,
              getItPackageBGColor: restaurants[index].packageSettings!.deliveryType == "1" || restaurants[index].packageSettings!.deliveryType == "3"
                  ? AppColors.greenColor
                  : Colors.white,
              getItPackageIconColor:
                  restaurants[index].packageSettings!.deliveryType == "1" || restaurants[index].packageSettings!.deliveryType == "3"
                      ? Colors.white
                      : AppColors.unSelectedpackageDeliveryColor,
              minDiscountedOrderPrice: restaurants[index].packageSettings?.minDiscountedOrderPrice,
              minOrderPrice: restaurants[index].packageSettings?.minOrderPrice,
              restaurantIcon: restaurants[index].photo,
              backgroundImage: restaurants[index].background,
              restaurantName: restaurants[index].name,
              grade: restaurants[index].avgReview!.toStringAsFixed(1),
              location: restaurants[index].province,
              distance:
                  Haversine.distance(restaurants[index].latitude!, restaurants[index].longitude, LocationService.latitude, LocationService.longitude)
                      .toString(),
              availableTime: '${restaurants[index].packageSettings?.deliveryTimeStart}-${restaurants[index].packageSettings?.deliveryTimeEnd}',
            );
          }),
        );
      },
      separatorBuilder: (BuildContext context, int index) => SizedBox(
        width: context.dynamicWidht(0.04),
      ),
    );
  }
}
