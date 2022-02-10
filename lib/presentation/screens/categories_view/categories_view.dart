import 'package:dongu_mobile/presentation/widgets/circular_progress_indicator/custom_circular_progress_indicator.dart';
import 'package:dongu_mobile/utils/extensions/string_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';

import '../../../data/model/category_name.dart';
import '../../../data/model/search_store.dart';
import '../../../data/services/location_service.dart';
import '../../../logic/cubits/generic_state/generic_state.dart';
import '../../../logic/cubits/search_store_cubit/search_store_cubit.dart';
import '../restaurant_details_views/screen_arguments/screen_arguments.dart';
import '../../widgets/restaurant_info_list_tile/restaurant_info_list_tile.dart';
import '../../widgets/scaffold/custom_scaffold.dart';
import '../../widgets/text/locale_text.dart';
import '../../../utils/constants/image_constant.dart';
import '../../../utils/constants/route_constant.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/haversine.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CategoriesView extends StatelessWidget {
  final Result? category;
  CategoriesView({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return builBody();
  }

  Widget builBody() {
    return Builder(builder: (context) {
      final GenericState state = context.watch<SearchStoreCubit>().state;

      if (state is GenericInitial) {
        return Container(color: Colors.white);
      } else if (state is GenericLoading) {
        return Center(child: CustomCircularProgressIndicator());
      } else if (state is GenericCompleted) {
        List<SearchStore> restaurants = [];
        List<SearchStore> categorizedRestaurants = [];

        for (int i = 0; i < state.response.length; i++) {
          restaurants.add(state.response[i]);
        }
        for (var i = 0; i < restaurants.length; i++) {
          for (var j = 0; j < restaurants[i].categories!.length; j++) {
            if (restaurants[i].categories![j].name == category!.id) {
              categorizedRestaurants.add(restaurants[i]);
            }
          }
        }
        return buildCustomScaffold(context, categorizedRestaurants);
      } else {
        final error = state as GenericError;
        return Center(child: Text("${error.message}\n${error.statusCode}"));
      }
    });
  }

  CustomScaffold buildCustomScaffold(
      BuildContext context, List<SearchStore> categorizedRestaurants) {
    return CustomScaffold(
      title: LocaleKeys.home_page_categories,
      body: Padding(
        padding: EdgeInsets.only(
          left: context.dynamicWidht(0.06),
          right: context.dynamicWidht(0.06),
          top: context.dynamicHeight(0.02),
          bottom: context.dynamicHeight(0.02),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTitle(category!.name!),
            Divider(
              thickness: 4,
              color: AppColors.borderAndDividerColor,
            ),
            SizedBox(
              height: 10,
            ),
            buildRestaurantList(categorizedRestaurants),
          ],
        ),
      ),
    );
  }

  Text buildTitle(String title) {
    return Text(
      title,
      style: AppTextStyles.bodyTitleStyle,
    );
  }

  Widget buildRestaurantList(List<SearchStore> categorizedRestaurants) {
    return categorizedRestaurants.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: categorizedRestaurants.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
                      Navigator.pushNamed(context, RouteConstant.RESTAURANT_DETAIL,
                      arguments: ScreenArgumentsRestaurantDetail(
                        restaurant: categorizedRestaurants[index],
                      ));
                },
                child: RestaurantInfoListTile(
                  deliveryType: int.parse(categorizedRestaurants[index]
                          .packageSettings!
                          .deliveryType ??
                      '3'),
                  packetNumber: categorizedRestaurants[index]
                              .calendar!
                              .first
                              .boxCount ==
                          0
                      ? LocaleKeys.home_page_soldout_icon
                      : "${categorizedRestaurants[index].calendar!.first.boxCount} ${LocaleKeys.home_page_packet_number.locale}",
                  minDiscountedOrderPrice: categorizedRestaurants[index]
                      .packageSettings!
                      .minDiscountedOrderPrice,
                  minOrderPrice: categorizedRestaurants[index]
                      .packageSettings!
                      .minOrderPrice,
                  onPressed: () {
                    Navigator.pushNamed(context, RouteConstant.RESTAURANT_DETAIL,
                        arguments: ScreenArgumentsRestaurantDetail(
                          restaurant: categorizedRestaurants[index],
                        ));
                  },
                  icon: categorizedRestaurants[index].photo,
                  restaurantName: categorizedRestaurants[index].name,
                  distance: Haversine.distance(
                          categorizedRestaurants[index].latitude!,
                          categorizedRestaurants[index].longitude,
                          LocationService.latitude,
                          LocationService.longitude)
                      .toStringAsFixed(2),
                  availableTime:
                      '${categorizedRestaurants[index].packageSettings!.deliveryTimeStart} - ${categorizedRestaurants[index].packageSettings!.deliveryTimeEnd}',
                ),
              );
            })
        : Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                ),
                SvgPicture.asset(ImageConstant.SURPRISE_PACK_ALERT),
                SizedBox(
                  height: 20,
                ),
                LocaleText(
                  alignment: TextAlign.center,
                  text: LocaleKeys.restaurant_food_categories_no_category_text,
                  style: AppTextStyles.myInformationBodyTextStyle,
                ),
              ],
            ),
          );
  }
}
