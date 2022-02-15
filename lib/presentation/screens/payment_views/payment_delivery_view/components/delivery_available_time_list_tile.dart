import 'package:dongu_mobile/presentation/widgets/circular_progress_indicator/custom_circular_progress_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../data/model/search_store.dart';
import '../../../../../data/model/store_courier_hours.dart';
import '../../../../../logic/cubits/generic_state/generic_state.dart';
import '../../../../../logic/cubits/search_store_cubit/search_store_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../utils/locale_keys.g.dart';
import '../../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../../widgets/text/locale_text.dart';
import 'delivery_available_time.dart';

class DeliveryAvailableTimeListTile extends StatelessWidget {
  final List<StoreCourierHours>? chosenRestaurantList;

  DeliveryAvailableTimeListTile({Key? key, this.chosenRestaurantList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return chosenRestaurantList!.isNotEmpty
        ? Builder(builder: (context) {
            final GenericState stateOfRestaurants =
                context.watch<SearchStoreCubit>().state;

            if (stateOfRestaurants is GenericInitial) {
              return Container();
            } else if (stateOfRestaurants is GenericLoading) {
              return Center(child: CustomCircularProgressIndicator());
            } else if (stateOfRestaurants is GenericCompleted) {
              List<SearchStore> restaurants = [];
              List<SearchStore> chosenRestaurant = [];

              if (chosenRestaurantList!.isNotEmpty) {
                for (int i = 0; i < stateOfRestaurants.response.length; i++) {
                  restaurants.add(stateOfRestaurants.response[i]);
                }
                for (var i = 0; i < restaurants.length; i++) {
                  if (chosenRestaurantList![0].storeId == restaurants[i].id) {
                    chosenRestaurant.add(restaurants[i]);
                  }
                }
              }
              return ListTile(
                contentPadding: EdgeInsets.only(
                  left: 28.w,
                  right: 28.w,
                ),
                trailing: DeliveryAvailableTime(
                  time:
                      "${chosenRestaurant[0].packageSettings!.deliveryTimeStart}-${chosenRestaurant[0].packageSettings!.deliveryTimeEnd}",
                  height: 48.h,
                  width: 151.w,
                ),
                tileColor: Colors.white,
                title: LocaleText(
                  text: LocaleKeys.payment_delivery_delivery_time,
                  style: AppTextStyles.myInformationBodyTextStyle,
                ),
              );
            } else {
              final error = stateOfRestaurants as GenericError;
              return Center(
                  child: Text("${error.message}\n${error.statusCode}"));
            }
          })
        : Center(
            child: LocaleText(
            text: LocaleKeys.payment_delivery_delivery_available_time,
          ));
  }
}
