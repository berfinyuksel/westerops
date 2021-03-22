import 'package:auto_size_text/auto_size_text.dart';
import 'package:dongu_mobile/presentation/widgets/button/custom_button.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/extensions/string_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar(),
        backgroundColor: AppColors.scaffoldBackgroundColor,
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: notificationImage(context),
              ),
              Expanded(
                child: Column(
                  children: [
                    Spacer(
                      flex: 275,
                    ),
                    titleText(),
                    Spacer(
                      flex: 10,
                    ),
                    descriptionText(),
                    Spacer(
                      flex: 75,
                    ),
                    allowButton(context),
                    Spacer(
                      flex: 10,
                    ),
                    lateForNowButton(),
                    Spacer(
                      flex: 155,
                    ),
                  ],
                ),
              ),
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
        style: AppTextStyles.bodyTextStyle.copyWith(fontWeight: FontWeight.w400),
      ),
    );
  }

  CustomButton allowButton(BuildContext context) {
    return CustomButton(
      width: context.dynamicWidht(0.9),
      borderColor: AppColors.greenColor,
      color: AppColors.greenColor,
      textColor: AppColors.appBarColor,
      title: LocaleKeys.premission_notification_button1.locale,
      onPressed: () {
        Navigator.pushNamed(context, RouteConstant.LOCATION_VIEW);
      },
    );
  }

  AutoSizeText descriptionText() {
    return AutoSizeText(
      LocaleKeys.premission_notification_text2.locale,
      style: AppTextStyles.bodyBoldTextStyle,
      maxLines: 4,
      textAlign: TextAlign.center,
    );
  }

  AutoSizeText titleText() {
    return AutoSizeText(
      LocaleKeys.premission_notification_text1.locale,
      style: AppTextStyles.headlineStyle,
      maxLines: 2,
      textAlign: TextAlign.center,
    );
  }

  Container notificationImage(BuildContext context) {
    return Container(padding: EdgeInsets.only(top: context.dynamicHeight(0.12)), child: SvgPicture.asset(ImageConstant.NOTIFICATION_IMAGE));
  }

  AppBar appBar() {
    return AppBar(
      leading: IconButton(
        icon: SvgPicture.asset(ImageConstant.BACK_ICON),
        onPressed: () {},
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
