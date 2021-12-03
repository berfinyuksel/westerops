import 'package:dongu_mobile/data/repositories/update_permission_for_com_repository.dart';

import 'package:dongu_mobile/data/services/locator.dart';
import 'package:dongu_mobile/data/shared/shared_prefs.dart';

import 'package:geolocator/geolocator.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'components/contact_confirmation_list_tile.dart';
import 'components/general_settings_body_title.dart';
import '../../widgets/scaffold/custom_scaffold.dart';
import '../../widgets/text/locale_text.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GeneralSettingsView extends StatefulWidget {
  @override
  _GeneralSettingsViewState createState() => _GeneralSettingsViewState();
}

class _GeneralSettingsViewState extends State<GeneralSettingsView> {
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
  LocationPermission? permission;
  @override
  void initState() {
    super.initState();
    checkLocationPermission();
    permissionStatusFuture = getCheckNotificationPermStatus();
  }

  Future<String> getCheckNotificationPermStatus() {
    return NotificationPermissions.getNotificationPermissionStatus()
        .then((status) {
      switch (status) {
        case PermissionStatus.denied:
          isSwitchedNotification = false;
          return permDenied;
        case PermissionStatus.granted:
          isSwitchedNotification = true;
          return permGranted;
        case PermissionStatus.provisional:
          return permProvisional;
        default:
          return '';
      }
    });
  }

  checkLocationPermission() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
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
      title: LocaleKeys.general_settings_title,
      body: buildBody(context),
    );
  }

  Padding buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: context.dynamicHeight(0.02),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GeneralSettingsBodyTitle(
            text: LocaleKeys.general_settings_body_title_1,
          ),
          Spacer(
            flex: 1,
          ),
          ContactConfirmationListTile(),
          buildListTileSms(context),
          buildListTileEmail(context),
          buildListTilePhoneCall(context),
          Spacer(
            flex: 4,
          ),
          GeneralSettingsBodyTitle(
            text: LocaleKeys.general_settings_body_title_2,
          ),
          Spacer(
            flex: 1,
          ),
          buildListTileNotification(context),
          Spacer(
            flex: 4,
          ),
          GeneralSettingsBodyTitle(
            text: LocaleKeys.general_settings_body_title_3,
          ),
          Spacer(
            flex: 1,
          ),
          buildListTileLocation(context),
          Spacer(
            flex: 15,
          ),
        ],
      ),
    );
  }

  ListTile buildListTileSms(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
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
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
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
              sl<UpdatePermissonRepository>()
                  .updateEmailPermission(isSwitchedEmail);
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
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
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
              sl<UpdatePermissonRepository>()
                  .updatePhoneCallPermission(isSwitchedPhoneCall);
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
        style: AppTextStyles.subTitleStyle,
      ),
    );
  }

  ListTile buildListTileNotification(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
      ),
      tileColor: Colors.white,
      trailing: Transform.scale(
        alignment: Alignment.centerRight,
        scale: 0.8,
        child: CupertinoSwitch(
            value: isSwitchedNotification,
            onChanged: (value) {
              setState(() {
                NotificationPermissions.requestNotificationPermissions(
                        iosSettings: const NotificationSettingsIos(
                            sound: true, badge: true, alert: true))
                    .then((_) {
                  // when finished, check the permission status
                  setState(() {
                    permissionStatusFuture = getCheckNotificationPermStatus();
                    isSwitchedNotification = value;
                  });
                });
              });
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
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
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
