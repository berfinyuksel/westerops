import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:device_info/device_info.dart';
import 'package:dongu_mobile/data/services/location_service.dart';
import 'package:dongu_mobile/data/services/locator.dart';
import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';
import 'package:dongu_mobile/logic/cubits/order_cubit/order_received_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  late ScrollController nearMeScrollController;
  late ScrollController opportunitiesScrollController;
  HomePageCubit() : super(HomePageInitial());

  init() async {
    emit(HomePageLoading());
    nearMeScrollController = ScrollController();
    opportunitiesScrollController = ScrollController();
    LocationService.getCurrentLocation();
    getDeviceIdentifier();
    SharedPrefs.onboardingShown(true);
    sl<OrderReceivedCubit>().getPastOrder();
    buildSharedPrefNoData();
    emit(HomePageCompleted());
  }

  Future<List<String>> getDeviceIdentifier() async {
    String? identifier;
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;

        identifier = build.androidId;
        print(identifier); //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        identifier = data.identifierForVendor; //UUID for iOS
      }
    } on PlatformException {
      print('Failed to get platform version');
    }
    return [identifier!];
  }

  void buildSharedPrefNoData() {
    SharedPrefs.setCardRegisterBool(false);
    SharedPrefs.setThreeDBool(false);
    SharedPrefs.setCardAlias("");
    SharedPrefs.setCardHolderName("");
    SharedPrefs.setCardNumber("");
    SharedPrefs.setExpireMonth("");
    SharedPrefs.setExpireYear("");
    SharedPrefs.setCVC("");
    SharedPrefs.setConversationId("");
    SharedPrefs.setBoolForRegisteredCard(false);
    SharedPrefs.setCardToken("");
  }
}
