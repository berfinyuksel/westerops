import 'package:dongu_mobile/data/model/category_name.dart';
import 'package:dongu_mobile/data/model/search_store.dart';
import 'package:dongu_mobile/data/services/location_service.dart';
import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';
import 'package:dongu_mobile/logic/cubits/search_store_cubit/search_store_cubit.dart';
import 'package:dongu_mobile/presentation/screens/restaurant_details_views/screen_arguments/screen_arguments.dart';
import 'package:dongu_mobile/presentation/widgets/restaurant_info_list_tile/restaurant_info_list_tile.dart';
import 'package:dongu_mobile/presentation/widgets/scaffold/custom_scaffold.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/haversine.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
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
        return Container();
      } else if (state is GenericLoading) {
        return Center(child: CircularProgressIndicator());
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
      title: 'Kategoriler',
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

  LocaleText buildTitle(String title) {
    return LocaleText(
      text: title,
      style: AppTextStyles.bodyTitleStyle,
    );
  }

  Widget buildRestaurantList(List<SearchStore> categorizedRestaurants) {
    return categorizedRestaurants.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: categorizedRestaurants.length,
            itemBuilder: (context, index) {
              return RestaurantInfoListTile(
                deliveryType: int.parse(categorizedRestaurants[index]
                        .packageSettings!
                        .deliveryType ??
                    '3'),
                packetNumber: categorizedRestaurants[index]
                            .calendar!
                            .first
                            .boxCount ==
                        0
                    ? 'tükendi'
                    : '${categorizedRestaurants[index].calendar!.first.boxCount} paket',
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
                  text:
                      "Üzgünüz.\nBu kategori için bulunduğunuz bölgede henüz bir işletme bulunmamaktadır.",
                  style: AppTextStyles.myInformationBodyTextStyle,
                ),
              ],
            ),
          );
  }
}