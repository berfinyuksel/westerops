import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/extensions/string_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../data/model/search_store.dart';
import '../../../data/services/location_service.dart';
import '../../../logic/cubits/filters_cubit/filters_manager_cubit.dart';
import '../../../logic/cubits/filters_cubit/sort_filters_cubit.dart';
import '../../../logic/cubits/generic_state/generic_state.dart';
import '../../../logic/cubits/search_store_cubit/search_store_cubit.dart';
import '../../../utils/constants/route_constant.dart';
import '../../../utils/haversine.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../widgets/restaurant_info_list_tile/restaurant_info_list_tile.dart';
import '../../widgets/scaffold/custom_scaffold.dart';
import '../restaurant_details_views/screen_arguments/screen_arguments.dart';

class FilteredView extends StatefulWidget {
  FilteredView({Key? key}) : super(key: key);

  @override
  _FilteredViewState createState() => _FilteredViewState();
}

class _FilteredViewState extends State<FilteredView> {
  @override
  void initState() {
    context.read<SearchStoreCubit>().getSearchStore();
    context.read<SortFilterCubit>();
    context.read<FiltersManagerCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildBuilder();
  }

  Builder buildBuilder() {
    return Builder(builder: (context) {
      final GenericState state = context.watch<FiltersManagerCubit>().state;

      //final FiltersState filterState = context.watch<FiltersCubit>().state;

      if (state is GenericInitial) {
        return Container(color: Colors.white);
      } else if (state is GenericLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (state is GenericCompleted) {
        List<SearchStore> restaurants = [];
        //List<double> distances = [];

        for (int i = 0; i < state.response.length; i++) {
          restaurants.add(state.response[i]);
        }

        return CustomScaffold(
            isDrawer: false,
            title: LocaleKeys.filters_done_title.locale,
            body: buildListViewRestaurantInfo(state, restaurants));
      } else {
        final error = state as GenericError;
        return Center(child: Text("${error.message}\n${error.statusCode}"));
      }
    });
  }

  Widget buildListViewRestaurantInfo(
    GenericState state,
    List<SearchStore> restaurants,
  ) {
    return restaurants.isNotEmpty
     ? ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          String? packettNumber() {
            if (restaurants[index].calendar == null) {
              return LocaleKeys.home_page_soldout_icon.locale;
            } else if (restaurants[index].calendar != null) {
              for (int i = 0; i < restaurants[index].calendar!.length; i++) {
                var boxcount = restaurants[index].calendar![i].boxCount;

                String now = DateTime.now().toIso8601String();
                List<String> currentDate = now.split("T").toList();
                print(currentDate[0]);
                List<String> startDate = restaurants[index]
                    .calendar![i]
                    .startDate!
                    .toString()
                    .split("T")
                    .toList();

                if (currentDate[0] == startDate[0]) {
                  if (restaurants[index].calendar![i].boxCount != 0) {
                    return "${boxcount.toString()} ${LocaleKeys.home_page_packet_number.locale}";
                  } else if (restaurants[index].calendar![i].boxCount == null ||
                      restaurants[index].calendar![i].boxCount == 0) {
                    return LocaleKeys.home_page_soldout_icon;
                  }
                }
              }
            }
          }

          return RestaurantInfoListTile(
            deliveryType:
                int.parse(restaurants[index].packageSettings!.deliveryType!),
            icon: restaurants[index].photo,
            restaurantName: restaurants[index].name,
            distance: Haversine.distance(
                    restaurants[index].latitude!,
                    restaurants[index].longitude,
                    LocationService.latitude,
                    LocationService.longitude)
                .toString(),
            packetNumber:
                packettNumber() ?? LocaleKeys.home_page_soldout_icon.locale,
            availableTime:
                '${restaurants[index].packageSettings?.deliveryTimeStart}-${restaurants[index].packageSettings?.deliveryTimeEnd}',
            border: Border.all(
              width: 1.0,
              color: AppColors.borderAndDividerColor,
            ),
            minDiscountedOrderPrice:
                restaurants[index].packageSettings?.minDiscountedOrderPrice,
            minOrderPrice: restaurants[index].packageSettings?.minOrderPrice,
            onPressed: () {
              Navigator.pushNamed(context, RouteConstant.RESTAURANT_DETAIL,
                  arguments: ScreenArgumentsRestaurantDetail(
                      restaurant: restaurants[index]));
            },
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
                            text: LocaleKeys.filters_no_restaurant_text,
                            style: AppTextStyles.myInformationBodyTextStyle,
                          ),
                        ],
                      ),
                    )  ;
  }
}
