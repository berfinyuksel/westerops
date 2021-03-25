import 'package:dongu_mobile/presentation/screens/general_settings_view/components/contact_confirmation_list_tile.dart';
import 'package:dongu_mobile/presentation/screens/general_settings_view/components/general_settings_body_title.dart';
import 'package:dongu_mobile/presentation/widgets/scaffold/custom_scaffold.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GeneralSettingsView extends StatefulWidget {
  @override
  _GeneralSettingsViewState createState() => _GeneralSettingsViewState();
}

class _GeneralSettingsViewState extends State<GeneralSettingsView> {
  bool isSwitchedSMS = false;
  bool isSwitchedEmail = false;
  bool isSwitchedPhoneCall = false;
  bool isSwitchedNotification = false;
  bool isSwitchedLocation = false;
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
                isSwitchedEmail = value;
              });
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
                isSwitchedPhoneCall = value;
              });
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
                isSwitchedNotification = value;
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
            onChanged: (value) {
              setState(() {
                isSwitchedLocation = value;
              });
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