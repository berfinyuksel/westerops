import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/logic/cubits/basket_counter_cubit/basket_counter_cubit.dart';
import 'package:dongu_mobile/logic/cubits/favourite_cubit/favourite_cubit.dart';
import 'package:dongu_mobile/logic/cubits/notifications_counter_cubit/notifications_counter_cubit.dart';
import 'package:dongu_mobile/logic/cubits/order_bar_cubit/order_bar_cubit.dart';
import 'package:dongu_mobile/logic/cubits/sum_price_order_cubit/sum_old_price_order_cubit.dart';
import 'package:dongu_mobile/logic/cubits/sum_price_order_cubit/sum_price_order_cubit.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_cubit_state.dart';

class SplashCubit extends Cubit<SplashCubitState> {
  SplashCubit() : super(SplashCubitInitial());

  splashInit(BuildContext context) async {
    //await Future.delayed(Duration(seconds: 3));

    //await
    try {
      print('hello init calisti');
      emit(SplashCubitLoading());
      await basketCounter(context);
      await notificationsCounter(context);
      await addFavorite(context);
      await stateOfBar(context);
      await sumOldNewPrice(context);
      
      navigateToScreens(context);
      print("SPLASH try");
    } catch (e) {
      print("SPLASH ERROR");
    }
  }

  navigateToScreens(BuildContext context) {
    // Navigator.of(context).pushNamed(RouteConstant.CUSTOM_SCAFFOLD);
    if (SharedPrefs.getIsLogined) {
      //SharedPrefs.clearCache();
      Navigator.pushNamed(context, RouteConstant.CUSTOM_SCAFFOLD);
    } else {
      Navigator.of(context).pushNamed(RouteConstant.ONBOARDINGS_VIEW);
    }
  }

  basketCounter(BuildContext context) {
    context.read<BasketCounterCubit>().setCounter(SharedPrefs.getCounter);
  }

  notificationsCounter(BuildContext context) {
    context
        .read<NotificationsCounterCubit>()
        .setCounter(SharedPrefs.getCounter);
  }

  addFavorite(BuildContext context) {
    for (var i = 0; i < SharedPrefs.getFavorites.length; i++) {
      context
          .read<FavoriteCubit>()
          .addFavorite(int.parse(SharedPrefs.getFavorites[i]));
    }
  }

  stateOfBar(BuildContext context) {
    context.read<OrderBarCubit>().stateOfBar(SharedPrefs.getOrderBar);
  }

  sumOldNewPrice(BuildContext context) {
    context.read<SumPriceOrderCubit>().incrementPrice(SharedPrefs.getSumPrice);
    context
        .read<SumOldPriceOrderCubit>()
        .incrementOldPrice(SharedPrefs.getOldSumPrice);
  }
}
