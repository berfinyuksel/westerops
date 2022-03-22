import 'package:app_settings/app_settings.dart';
import 'package:dongu_mobile/data/repositories/update_permission_for_com_repository.dart';

import 'package:dongu_mobile/data/services/locator.dart';
import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/presentation/widgets/scaffold/custom_scaffold.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:geolocator/geolocator.dart';
import 'components/contact_confirmation_list_tile.dart';
import 'components/general_settings_body_title.dart';
import '../../widgets/text/locale_text.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GeneralSettingsView extends StatefulWidget {
  @override
  _GeneralSettingsViewState createState() => _GeneralSettingsViewState();
}

class _GeneralSettingsViewState extends State<GeneralSettingsView> with WidgetsBindingObserver {
  Future<String>? permissionStatusFuture;
  var permGranted = "granted";
  var permDenied = "denied";
  var permUnknown = "unknown";
  var permProvisional = "provisional";
  bool isSwitchedSMS = false;
  bool isSwitchedEmail = SharedPrefs.getPermissionForEmail;
  bool isSwitchedPhoneCall = SharedPrefs.getPermissionForPhone;
  bool isSwitchedNotification = false;
  bool isSwitchedLocation = false;
  bool _nofiticationState = false;
  AppLifecycleState? _appLifecycleState;
  LocationPermission? permission;
  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await setNotificationState();
    await checkLocationPermission();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    _appLifecycleState = state;
    print(_appLifecycleState);
    if (_appLifecycleState == AppLifecycleState.resumed) {
      await setNotificationState();
      await checkLocationPermission();
    }
  }

  Future<void> setNotificationState() async {
    var messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission();
    setState(() {
      _nofiticationState = settings.authorizationStatus == AuthorizationStatus.authorized;
    });
  }

  checkLocationPermission() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      setState(() {
        isSwitchedLocation = false;
      });
    } else {
      setState(() {
        isSwitchedLocation = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isNavBar: true,
      title: LocaleKeys.general_settings_title,
      body: buildBody(context),
    );
  }

  Padding buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 20.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GeneralSettingsBodyTitle(
            text: LocaleKeys.general_settings_body_title_1,
          ),
          Spacer(flex: 1),
          ContactConfirmationListTile(),
          //  buildListTileSms(context),
          Spacer(flex: 2),
          buildListTileEmail(context),
          Spacer(flex: 1),
          buildListTilePhoneCall(context),
          Spacer(flex: 4),
          GeneralSettingsBodyTitle(
            text: LocaleKeys.general_settings_body_title_2,
          ),
          Spacer(flex: 1),
          buildListTileNotification(context),
          Spacer(flex: 4),
          GeneralSettingsBodyTitle(
            text: LocaleKeys.general_settings_body_title_3,
          ),
          Spacer(flex: 1),
          buildListTileLocation(context),
          Spacer(flex: 15),
        ],
      ),
    );
  }

  ListTile buildListTileSms(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        left: 28.w,
        right: 28.w,
      ),
      tileColor: Colors.white,
      trailing: Transform.scale(
        alignment: Alignment.centerRight,
        scale: 0.8,
        child: CupertinoSwitch(
            value: isSwitchedSMS,
            onChanged: (value) {
              setState(() {
                isSwitchedSMS = value;
              });
            },
            trackColor: Colors.white,
            activeColor: AppColors.greenColor),
      ),
      title: LocaleText(
        text: LocaleKeys.general_settings_sms,
        style: AppTextStyles.bodyTextStyle,
      ),
    );
  }

  ListTile buildListTileEmail(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        left: 28.w,
        right: 28.w,
      ),
      tileColor: Colors.white,
      trailing: Transform.scale(
        alignment: Alignment.centerRight,
        scale: 0.8,
        child: CupertinoSwitch(
            value: isSwitchedEmail,
            onChanged: (value) {
              setState(() {
                isSwitchedEmail = !isSwitchedEmail;
                isSwitchedEmail = value;
              });
              SharedPrefs.setPermissionForEmail(isSwitchedEmail);
              sl<UpdatePermissonRepository>().updateEmailPermission(isSwitchedEmail);
            },
            trackColor: Colors.white,
            activeColor: AppColors.greenColor),
      ),
      title: LocaleText(
        text: LocaleKeys.general_settings_email,
        style: AppTextStyles.bodyTextStyle,
      ),
    );
  }

  ListTile buildListTilePhoneCall(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        // bottom: 10.h,
        left: 28.w,
        right: 28.w,
      ),
      tileColor: Colors.white,
      trailing: Transform.scale(
        alignment: Alignment.centerRight,
        scale: 0.8,
        child: CupertinoSwitch(
            value: isSwitchedPhoneCall,
            onChanged: (value) {
              setState(() {
                isSwitchedPhoneCall = !isSwitchedPhoneCall;
                isSwitchedPhoneCall = value;
              });
              sl<UpdatePermissonRepository>().updatePhoneCallPermission(isSwitchedPhoneCall);
              SharedPrefs.setPermissionForPhone(isSwitchedPhoneCall);
            },
            trackColor: Colors.white,
            activeColor: AppColors.greenColor),
      ),
      title: LocaleText(
        text: LocaleKeys.general_settings_phone_call,
        style: AppTextStyles.bodyTextStyle,
      ),
      subtitle: LocaleText(
        text: LocaleKeys.general_settings_phone_call_subtitle,
        style: AppTextStyles.subTitleStyle.copyWith(height: 1.5),
      ),
    );
  }

  ListTile buildListTileNotification(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        left: 28.w,
        right: 28.w,
      ),
      tileColor: Colors.white,
      trailing: Transform.scale(
        alignment: Alignment.centerRight,
        scale: 0.8,
        child: CupertinoSwitch(
            value: _nofiticationState,
            onChanged: (value) {
              AppSettings.openNotificationSettings();
            },
            trackColor: Colors.white,
            activeColor: AppColors.greenColor),
      ),
      title: LocaleText(
        text: LocaleKeys.general_settings_notification,
        style: AppTextStyles.bodyTextStyle,
      ),
    );
  }

  ListTile buildListTileLocation(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        left: 28.w,
        right: 28.w,
      ),
      tileColor: Colors.white,
      trailing: Transform.scale(
        alignment: Alignment.centerRight,
        scale: 0.8,
        child: CupertinoSwitch(
            value: isSwitchedLocation,
            onChanged: (value) async {
              await Geolocator.openLocationSettings();
            },
            trackColor: Colors.white,
            activeColor: AppColors.greenColor),
      ),
      title: LocaleText(
        text: LocaleKeys.general_settings_location,
        style: AppTextStyles.bodyTextStyle,
      ),
    );
  }
}
