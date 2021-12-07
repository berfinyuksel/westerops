import 'package:dongu_mobile/data/model/search_store.dart';
import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';
import 'package:dongu_mobile/logic/cubits/search_store_cubit/search_store_cubit.dart';
import 'package:dongu_mobile/presentation/screens/restaurant_details_views/screen_arguments/screen_arguments.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:flutter/material.dart';

import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/locale_keys.g.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/text/locale_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuyButton extends StatelessWidget {
  final int id;
  const BuyButton({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final GenericState state = context.watch<SearchStoreCubit>().state;

      //final FiltersState filterState = context.watch<FiltersCubit>().state;

      if (state is GenericInitial) {
        return Container();
      } else if (state is GenericLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (state is GenericCompleted) {
        List<SearchStore> restaurants = [];
        List<SearchStore> chosenRestaurants = [];

        for (int i = 0; i < state.response.length; i++) {
          restaurants.add(state.response[i]);
        }

        for (var i = 0; i < restaurants.length; i++) {
          if (id == restaurants[i].id) {
            chosenRestaurants.add(restaurants[i]);
          }
        }

        return Container(
          height: context.dynamicHeight(0.04),
          width: context.dynamicWidht(0.28),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: AppColors.greenColor,
            border: Border.all(
              width: 2.0,
              color: AppColors.greenColor,
            ),
          ),
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteConstant.RESTAURANT_DETAIL,
                  arguments: ScreenArgumentsRestaurantDetail(
                    restaurant: chosenRestaurants.first,
                  ));
            },
            child: LocaleText(
              text: LocaleKeys.surprise_pack_canceled_button_buy,
              style: AppTextStyles.bodyTitleStyle.copyWith(color: Colors.white),
            ),
          ),
        );
      } else {
        final error = state as GenericError;
        return Center(child: Text("${error.message}\n${error.statusCode}"));
      }
    });
  }
}
