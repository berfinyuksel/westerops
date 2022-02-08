import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';

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
                padding: EdgeInsets.only(left: 35, right: 35),
                child: titleText(),
              ),
              Spacer(
                flex: 1,
              ),
              SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.dynamicWidht(0.06),
                    ),
                    child: descriptionText()),
              ),
              Spacer(
                flex: 4,
              ),
              enableButton(context),
              SizedBox(
                height: 16.h,
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
      onTap: () {
        Navigator.pushNamed(context, RouteConstant.FOOD_WASTE_VIEW);
      },
      child: AutoSizeText(
        LocaleKeys.premission_notification_button2.locale,
        style:
            AppTextStyles.bodyTextStyle.copyWith(fontWeight: FontWeight.w400),
      ),
    );
  }

  CustomButton enableButton(BuildContext context) {
    return CustomButton(
      width: 372.w,
      borderColor: AppColors.greenColor,
      color: AppColors.greenColor,
      textColor: AppColors.appBarColor,
      title: LocaleKeys.premission_location_button1,
      onPressed: () {
        Geolocator.requestPermission();
        Navigator.pushNamed(context, RouteConstant.FOOD_WASTE_VIEW);
      },
    );
  }

  AutoSizeText descriptionText() {
    return AutoSizeText(
      LocaleKeys.premission_location_text2.locale,
      style: AppTextStyles.bodyBoldTextStyle.copyWith(height: 1.5),
      maxLines: 3,
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

  Padding locationImage(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 28, right: 27),
      child: Container(
        height: 424.h,
        child: SvgPicture.asset(
          ImageConstant.LOCATION_IMAGE,
        ),
      ),
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
