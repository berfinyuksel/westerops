import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:device_info/device_info.dart';
import 'package:dongu_mobile/data/services/location_service.dart';
import 'package:dongu_mobile/data/services/locator.dart';
import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/logic/cubits/order_cubit/order_received_cubit.dart';
import 'package:dongu_mobile/logic/cubits/search_store_cubit/search_store_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  late ScrollController nearMeScrollController;
  late ScrollController opportunitiesScrollController;
  bool isCancelVisible = false;
  HomePageCubit() : super(HomePageInitial());

  init(TextEditingController controller) async {
    emit(HomePageLoading());
    await sl<SearchStoreCubit>().getSearchStore();
    nearMeScrollController = ScrollController();
    opportunitiesScrollController = ScrollController();
    LocationService.getCurrentLocation();
    getDeviceIdentifier();
    SharedPrefs.onboardingShown(true);
    sl<OrderReceivedCubit>().getPastOrder();
    buildSharedPrefNoData();
    SharedPrefs.setBoolPaymentCardControl(false);
    addControllerListener(controller);
    emit(HomePageCompleted());
  }

  void addControllerListener(TextEditingController controller) {
    controller.addListener(() {
      if (controller.text.length == 0) {
        isCancelVisible = false;
      } else {
        isCancelVisible = true;
      }
      print(isCancelVisible);
      emit(HomePageCancelState(isCancelVisible));
    });
  }

  Future<List<String>> getDeviceIdentifier() async {
    String? identifier;
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;

        identifier = build.androidId;
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        identifier = data.identifierForVendor; //UUID for iOS
      }
    } on PlatformException {}
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
