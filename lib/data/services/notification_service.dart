import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';

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
  } on PlatformException {
  }
  return [identifier!];
}
