import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/constants/image_constant.dart';
import '../../../utils/constants/route_constant.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/text/locale_text.dart';

class NotLoggedInEmptyCartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildBackground(context);
  }

  // Padding buildOrangeText(BuildContext context) {
  //   return Padding(
  //     padding: EdgeInsets.only(
  //       left: context.dynamicWidht(0.06),
  //       right: context.dynamicWidht(0.06),
  //     ),
  //     child: LocaleText(
  //       text: "Hala Döngü'de değil misin? Üye ol. \nZaten üye misin? Oturum aç.",
  //       style: AppTextStyles.headlineStyle.copyWith(fontSize: 18.0),
  //       alignment: TextAlign.center,
  //       maxLines: 4,
  //     ),
  //   );
  // }

  Container buildBackground(BuildContext context) {
    return Container(
      child: Stack(
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
                LocaleText(
                  text: LocaleKeys.cart_not_logged_in,
                  style: GoogleFonts.montserrat(
                    fontSize: 24.0.sp,
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w600,
                  ),
                  alignment: TextAlign.center,
                ),
                SvgPicture.asset(
                  ImageConstant.ORDER_DELIVERED_ICON,
                  fit: BoxFit.fitHeight,
                ),
                Spacer(flex: 3),
                //buildOrangeText(context),
                //Spacer(flex: 1),
                buildButton(context),
                Spacer(flex: 1)
              ],
            ),
          )
        ],
      ),
    );
  }

  Padding buildButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 28.w,
        right: 28.w,
        bottom: 30.h,
      ),
      child: CustomButton(
        width: double.infinity,
        title: LocaleKeys.login_text_login,
        color: AppColors.greenColor,
        borderColor: AppColors.greenColor,
        textColor: Colors.white,
        onPressed: () {
          Navigator.pushNamed(context, RouteConstant.LOGIN_VIEW);
        },
      ),
    );
  }
}
