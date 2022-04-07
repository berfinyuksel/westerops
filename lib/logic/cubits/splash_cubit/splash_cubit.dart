import 'package:dongu_mobile/data/repositories/favourite_repository.dart';
import 'package:dongu_mobile/data/repositories/search_store_repository.dart';
import 'package:dongu_mobile/data/services/locator.dart';
import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/logic/cubits/basket_counter_cubit/basket_counter_cubit.dart';
import 'package:dongu_mobile/logic/cubits/favourite_cubit/favourite_cubit.dart';
import 'package:dongu_mobile/logic/cubits/notifications_counter_cubit/notifications_counter_cubit.dart';
import 'package:dongu_mobile/logic/cubits/order_bar_cubit/order_bar_cubit.dart';
import 'package:dongu_mobile/logic/cubits/sum_price_order_cubit/sum_old_price_order_cubit.dart';
import 'package:dongu_mobile/logic/cubits/sum_price_order_cubit/sum_price_order_cubit.dart';
import 'package:dongu_mobile/utils/base/svg_image_repository.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/update_permission_for_com_repository.dart';

part 'splash_cubit_state.dart';

class SplashCubit extends Cubit<SplashCubitState> {
  SplashCubit() : super(SplashCubitInitial());

  splashInit(BuildContext context) async {
    try {
      emit(SplashCubitLoading());
      await sl<SvgImageRepository>().preCacheSvgPictures();
      await sl<SampleSearchStoreRepository>().getSearchStores();
      await checksIsLogin();
      await basketCounter(context);
      await notificationsCounter(context);
      await addFavorite(context);
      await stateOfBar(context);
      await sumOldNewPrice(context);
      await navigateToScreens(context);
//TODO User social login control continue - received object of wrong instance error
      print("USER TOKEN ${SharedPrefs.getToken}");
      print("USER ID ${SharedPrefs.getUserId}");
      await sl<UpdatePermissonRepository>().userSocialControl();
    } catch (e) {}
  }

  navigateToScreens(BuildContext context) {
    // Navigator.of(context).pushNamed(RouteConstant.CUSTOM_SCAFFOLD);
    if (SharedPrefs.getIsLogined) {
      //SharedPrefs.clearCache();
      Navigator.pushNamedAndRemoveUntil(
          context, RouteConstant.CUSTOM_SCAFFOLD, ModalRoute.withName('/scaf'));
    } else {
      Navigator.pushNamedAndRemoveUntil(context, RouteConstant.ONBOARDINGS_VIEW,
          ModalRoute.withName('/onBoardings'));
      //  Navigator.of(context).pushNamed(RouteConstant.ONBOARDINGS_VIEW);
    }
  }

  basketCounter(BuildContext context) {
    context.read<BasketCounterCubit>().setCounter(0);
  }

  notificationsCounter(BuildContext context) {
    context.read<NotificationsCounterCubit>().setCounter(0);
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

  checksIsLogin() async {
    await sl<SampleFavoriteRepository>().getFavorites();
    if (sl<SampleFavoriteRepository>().getFovarites == 401) {
      SharedPrefs.logoutControl();
    } else if (sl<SampleFavoriteRepository>().getFovarites == 200) {
      SharedPrefs.login();
    } else {
      SharedPrefs.logoutControl();
    }
  }
}
