import 'package:dongu_mobile/data/model/search_store.dart';
import 'package:dongu_mobile/data/model/store_courier_hours.dart';
import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';
import 'package:dongu_mobile/logic/cubits/search_store_cubit/search_store_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/extensions/context_extension.dart';
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
    return chosenRestaurantList != null || chosenRestaurantList != []
        ? Builder(builder: (context) {
            final GenericState stateOfRestaurants =
                context.watch<SearchStoreCubit>().state;

            if (stateOfRestaurants is GenericInitial) {
              return Container();
            } else if (stateOfRestaurants is GenericLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (stateOfRestaurants is GenericCompleted) {
              List<SearchStore> restaurants = [];
              List<SearchStore> chosenRestaurant = [];

              if (chosenRestaurantList != null) {
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
                  left: context.dynamicWidht(0.06),
                  right: context.dynamicWidht(0.06),
                ),
                trailing: DeliveryAvailableTime(
                  time:
                      "${chosenRestaurant[0].packageSettings!.deliveryTimeStart}-${chosenRestaurant[0].packageSettings!.deliveryTimeEnd}",
                  height: context.dynamicHeight(0.05),
                  width: context.dynamicWidht(0.35),
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
        : Text('      Restoran teslimat saatleri uygun degildir.');
  }
}
