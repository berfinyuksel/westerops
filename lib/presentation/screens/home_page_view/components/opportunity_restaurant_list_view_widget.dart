import 'package:dongu_mobile/data/model/search_store.dart';
import 'package:dongu_mobile/data/services/location_service.dart';
import 'package:dongu_mobile/logic/cubits/padding_values_cubit/opportunity_padding_values.dart';
import 'package:dongu_mobile/presentation/screens/restaurant_details_views/screen_arguments/screen_arguments.dart';
import 'package:dongu_mobile/presentation/widgets/restaurant_info_card/restaurant_info_card.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/extensions/string_extension.dart';
import 'package:dongu_mobile/utils/haversine.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class OpportunityRestaurantListViewWidget extends StatelessWidget {
  final List<SearchStore> restaurants;
  final ScrollController? controller;

  const OpportunityRestaurantListViewWidget(
      {Key? key, required this.restaurants, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthOfOpportunity = context.dynamicWidht(0.64);
    double sumOfWidthOpportunity = 0;
    return ListView.separated(
      //padding: EdgeInsets.symmetric(horizontal: 20),
      controller: controller,
      itemCount: restaurants.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        sumOfWidthOpportunity +=
            widthOfOpportunity + context.dynamicWidht(0.04);
        if (index + 1 == restaurants.length) {
          context.read<OpportunityPaddingCubit>().setPadding(
              sumOfWidthOpportunity -
                  context.dynamicWidht(1) -
                  context.dynamicWidht(0.04));
        }
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, RouteConstant.RESTAURANT_DETAIL,
                arguments: ScreenArgumentsRestaurantDetail(
                  restaurant: restaurants[index],
                ));
          },
          child: Builder(builder: (context) {
            String? packettNumber() {
              if (restaurants[index].calendar == null) {
                //calendar dizisi boş ise tükendi yazdırsın
                return LocaleKeys.home_page_soldout_icon.locale;
              } else if (restaurants[index].calendar != null) {
                //calendar dizisi boş değilse aşağıdaki kodlar çalışsın
                for (int i = 0; i < restaurants[index].calendar!.length; i++) {
                  var boxcount = restaurants[index].calendar![i].boxCount;

                  String now = DateTime.now().toIso8601String();
                  List<String> currentDate = now.split("T").toList();

                  List<String> startDate = restaurants[index]
                      .calendar![i]
                      .startDate!
                      .toString()
                      .split("T")
                      .toList();

                  if (currentDate[0] == startDate[0]) {
                    if (restaurants[index].calendar![i].boxCount != 0) {
                      return "${boxcount.toString()} ${LocaleKeys.home_page_packet_number.locale}";
                    } else if (restaurants[index].calendar![i].boxCount ==
                            null ||
                        restaurants[index].calendar![i].boxCount == 0) {
                      return LocaleKeys.home_page_soldout_icon.locale;
                    }
                  }
                }
              }
              return null;
            }

            return RestaurantInfoCard(
              width: widthOfOpportunity,
              restaurantId: restaurants[index].id!,
              courierPackageBGColor:
                  restaurants[index].packageSettings!.deliveryType == "2" ||
                          restaurants[index].packageSettings!.deliveryType ==
                              "3"
                      ? AppColors.greenColor
                      : Colors.white,
              courierPackageIconColor:
                  restaurants[index].packageSettings!.deliveryType == "2" ||
                          restaurants[index].packageSettings!.deliveryType ==
                              "3"
                      ? Colors.white
                      : AppColors.unSelectedpackageDeliveryColor,
              getItPackageBGColor:
                  restaurants[index].packageSettings!.deliveryType == "1" ||
                          restaurants[index].packageSettings!.deliveryType ==
                              "3"
                      ? AppColors.greenColor
                      : Colors.white,
              getItPackageIconColor:
                  restaurants[index].packageSettings!.deliveryType == "1" ||
                          restaurants[index].packageSettings!.deliveryType ==
                              "3"
                      ? Colors.white
                      : AppColors.unSelectedpackageDeliveryColor,
              minDiscountedOrderPrice:
                  restaurants[index].packageSettings?.minDiscountedOrderPrice,
              minOrderPrice: restaurants[index].packageSettings?.minOrderPrice,
              restaurantIcon: restaurants[index].photo,
              backgroundImage: restaurants[index].background,
              packetNumber:
                  packettNumber() ?? LocaleKeys.home_page_soldout_icon.locale,
              restaurantName: restaurants[index].name,
              grade: restaurants[index].avgReview!.toStringAsFixed(1),
              location: restaurants[index].city,
              distance: Haversine.distance(
                      restaurants[index].latitude!,
                      restaurants[index].longitude,
                      LocationService.latitude,
                      LocationService.longitude)
                  .toString(),
              availableTime:
                  '${restaurants[index].packageSettings?.deliveryTimeStart}-${restaurants[index].packageSettings?.deliveryTimeEnd}',
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
