import 'package:dongu_mobile/logic/cubits/category_filter_cubit/category_filter_cubit.dart';
import 'package:dongu_mobile/utils/extensions/string_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/model/category_name.dart';
import '../../../data/model/search_store.dart';
import '../../../data/services/location_service.dart';
import '../../../data/services/locator.dart';
import '../../widgets/circular_progress_indicator/custom_circular_progress_indicator.dart';
import '../restaurant_details_views/screen_arguments/screen_arguments.dart';
import '../../widgets/restaurant_info_list_tile/restaurant_info_list_tile.dart';
import '../../widgets/scaffold/custom_scaffold.dart';
import '../../widgets/text/locale_text.dart';
import '../../../utils/constants/image_constant.dart';
import '../../../utils/constants/route_constant.dart';
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
    return builBody(context);
  }

  Widget builBody(BuildContext context) {
    return BlocProvider(
        create: (context) => sl<CategoryFilterCubit>()
          ..getCategoriesQuery(category!.id.toString()),
        child: buildCustomScaffold(context));
  }

  CustomScaffold buildCustomScaffold(BuildContext context) {
    return CustomScaffold(
      title: LocaleKeys.home_page_categories,
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTitle(category!.name!),
              Divider(
                thickness: 4,
                color: AppColors.borderAndDividerColor,
              ),
              SizedBox(
                height: 10.h,
              ),
              BlocBuilder<CategoryFilterCubit, CategoryFilterState>(
                builder: (context, state) {
                  if (state is FilterCategoriesLoading) {
                    return Center(child: CustomCircularProgressIndicator());
                  } else if (state is FilterCategoriesCompleted) {
                    return buildRestaurantList(state.response!);
                  }
                  return SizedBox();
                },
              ),
            ],
          ),
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
                onTap: () {
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
                  minDiscountedOrderPrice: categorizedRestaurants[index]
                      .packageSettings!
                      .minDiscountedOrderPrice,
                  minOrderPrice: categorizedRestaurants[index]
                      .packageSettings!
                      .minOrderPrice,
                  onPressed: () {
                    Navigator.pushNamed(
                        context, RouteConstant.RESTAURANT_DETAIL,
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
                  restaurantId: categorizedRestaurants[index].id!,
                ),
              );
            })
        : Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40.h,
                ),
                SvgPicture.asset(ImageConstant.SURPRISE_PACK_ALERT),
                SizedBox(
                  height: 20.h,
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
