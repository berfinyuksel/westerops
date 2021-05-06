import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/constants/image_constant.dart';
import '../../../../utils/constants/route_constant.dart';
import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/extensions/string_extension.dart';
import '../../../../utils/locale_keys.g.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/button/custom_button.dart';

class LocationView extends StatefulWidget {
  const LocationView({Key? key}) : super(key: key);

  @override
  _LocationViewState createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      backgroundColor: AppColors.scaffoldBackgroundColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(
           
            bottom: context.dynamicHeight(0.06),
          ),
          child: Column(
            children: [
                     Spacer(
                flex: 6,
              ),
              locationImage(context),
              Spacer(
                flex: 6,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.dynamicWidht(0.06),
                ),
                child: titleText(),
              ),
              Spacer(
                flex: 1,
              ),
              Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.dynamicWidht(0.06),
                  ),
                  child: descriptionText()),
              Spacer(
                flex: 4,
              ),
              enableButton(context),
              SizedBox(
                height: context.dynamicHeight(0.01),
              ),
              lateForNowButton(),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector lateForNowButton() {
    return GestureDetector(
      onTap: () {},
      child: AutoSizeText(
        LocaleKeys.premission_notification_button2.locale,
        style:
            AppTextStyles.bodyTextStyle.copyWith(fontWeight: FontWeight.w400),
      ),
    );
  }

  CustomButton enableButton(BuildContext context) {
    return CustomButton(
      width: context.dynamicWidht(0.9),
      borderColor: AppColors.greenColor,
      color: AppColors.greenColor,
      textColor: AppColors.appBarColor,
      title: LocaleKeys.premission_location_button1.locale,
      onPressed: () {
        alertDialogCard(context);
      },
    );
  }

  AutoSizeText descriptionText() {
    return AutoSizeText(
      LocaleKeys.premission_location_text2.locale,
      style: AppTextStyles.bodyBoldTextStyle,
      maxLines: 2,
      textAlign: TextAlign.center,
    );
  }

  AutoSizeText titleText() {
    return AutoSizeText(
      LocaleKeys.premission_location_text1.locale,
      style: AppTextStyles.headlineStyle,
      maxLines: 1,
      textAlign: TextAlign.center,
    );
  }

  Container locationImage(BuildContext context) {
    return Container(
      //padding: EdgeInsets.only(top: context.dynamicHeight(1)),
      //padding: EdgeInsets.only(top: context.dynamicHeight(0.10)),
      padding: EdgeInsets.only(
          right: context.dynamicWidht(0.06), left: context.dynamicWidht(0.06)),
      child: SvgPicture.asset(ImageConstant.LOCATION_IMAGE),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: SvgPicture.asset(ImageConstant.BACK_ICON),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}

alertDialogCard(BuildContext context) {
  var alertDialog = CupertinoAlertDialog(
    title: Text(LocaleKeys.location_card_text1.locale),
    content: Text(LocaleKeys.location_card_text2.locale),
    actions: <Widget>[
      CupertinoDialogAction(
        isDefaultAction: true,
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(LocaleKeys.location_card_button1.locale),
      ),
      CupertinoDialogAction(
        isDefaultAction: true,
        onPressed: () {
          Navigator.pushNamed(context, RouteConstant.LOGIN_VIEW);
        },
        child: Text(LocaleKeys.location_card_button2.locale),
      ),
    ],
  );
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      });
}
