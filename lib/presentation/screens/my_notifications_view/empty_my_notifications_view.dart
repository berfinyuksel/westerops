import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/constants/image_constant.dart';
import '../../../utils/constants/route_constant.dart';
import '../../../utils/locale_keys.g.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/text/locale_text.dart';

class EmptyMyNotificationsView extends StatelessWidget {
  const EmptyMyNotificationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildBackground(context);
  }

  Stack buildBackground(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          ImageConstant.ORDER_RECEIVING_BACKGROUND,
          fit: BoxFit.fitWidth,
          width: double.infinity,
        ),
        Center(
          child: Column(
            children: [
              Spacer(flex: 3),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 26.w),
                child: LocaleText(
                  text: LocaleKeys.my_notifications_empty_my_notifications,
                  style: GoogleFonts.montserrat(
                    fontSize: 18.0.sp,
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w600,
                  ),
                  alignment: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 30,
                child: SvgPicture.asset(
                  ImageConstant.MY_NOTIFICATIONS_IMAGE,
                  fit: BoxFit.fitHeight,
                ),
              ),
              buildButtons(context),
              Spacer(flex: 3),
            ],
          ),
        )
      ],
    );
  }

  Padding buildButtons(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 28.w,
        right: 28.w,
        // bottom: 30.h,
      ),
      child: Column(
        children: [
          CustomButton(
            width: double.infinity,
            title: LocaleKeys.login_text_login,
            color: AppColors.greenColor,
            borderColor: AppColors.greenColor,
            textColor: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, RouteConstant.LOGIN_VIEW);
            },
          ),
          SizedBox(height: 35.h),
          CustomButton(
            width: double.infinity,
            title: LocaleKeys.register_text_register,
            color: AppColors.scaffoldBackgroundColor,
            borderColor: AppColors.greenColor,
            textColor: AppColors.greenColor,
            onPressed: () {
              Navigator.pushNamed(context, RouteConstant.REGISTER_VIEW);
            },
          ),
        ],
      ),
    );
  }
}
