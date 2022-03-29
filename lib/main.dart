import 'dart:io';
import 'package:dongu_mobile/data/services/ip_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'utils/base/my_app.dart';
import 'data/services/http_overrides.dart';
import 'data/services/locator.dart';
import 'data/shared/shared_prefs.dart';
import 'utils/constants/locale_constant.dart';

Future<void> main() async {
  await buildInit();
  runApp(
    EasyLocalization(
      child: MyApp(),
      path: LocaleConstant.LANG_PATH,
      supportedLocales: LocaleConstant.SUPPORTED_LOCALES,
    ),
  );
}

Future<void> buildInit() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // NotificationService().init();
  await setUpLocator();
  await EasyLocalization.ensureInitialized();
  await SharedPrefs.initialize();
  await Firebase.initializeApp();
  await IpService().detectIP();
  HttpOverrides.global = MyHttpOverrides();
}
