import 'package:bloc/bloc.dart';
import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:flutter/material.dart';


part 'splash_cubit_state.dart';

class SplashCubit extends Cubit<SplashCubitState> {
  SplashCubit() : super(SplashCubitInitial());

  splashInit(BuildContext context) async {
    print('hello init calisti');
    emit(SplashCubitLoading());
    await Future.delayed(Duration(seconds: 3));
    navigateToScreens(context);
  }

  navigateToScreens(BuildContext context) {
    // Navigator.of(context).pushNamed(RouteConstant.CUSTOM_SCAFFOLD);
    if (SharedPrefs.getIsLogined) {
      SharedPrefs.clearCache();
      Navigator.pushNamed(context, RouteConstant.CUSTOM_SCAFFOLD);
    } else {
      Navigator.of(context).pushNamed(RouteConstant.ONBOARDINGS_VIEW);
    }
  }
}