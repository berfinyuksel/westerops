import '../../widgets/button/custom_button.dart';
import '../../widgets/text/locale_text.dart';
import '../../../utils/constants/image_constant.dart';
import '../../../utils/constants/route_constant.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyCartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildBackground(context);
  }

  Padding buildOrangeText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
      ),
      child: LocaleText(
        text: LocaleKeys.cart_choose_restaurant,
        style: AppTextStyles.headlineStyle,
        alignment: TextAlign.center,
        maxLines: 3,
      ),
    );
  }

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
                  text: LocaleKeys.cart_empty_cart,
                  style: GoogleFonts.montserrat(
                    fontSize: 18.0,
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
                buildOrangeText(context),
                Spacer(flex: 1),
                buildButton(context),
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
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
        bottom: context.dynamicHeight(0.03),
      ),
      child: CustomButton(
        width: double.infinity,
        title: LocaleKeys.cart_button_empty,
        color: AppColors.greenColor,
        borderColor: AppColors.greenColor,
        textColor: Colors.white,
        onPressed: () {
          Navigator.pushNamed(context, RouteConstant.CART_VIEW);
        },
      ),
    );
  }
}
