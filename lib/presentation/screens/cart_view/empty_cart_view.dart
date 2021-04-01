import 'package:dongu_mobile/presentation/widgets/button/custom_button.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyCartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(flex: 76),
        buildBackground(context),
        Spacer(flex: 47),
        buildOrangeText(context),
        Spacer(flex: 29),
        buildButton(context),
      ],
    );
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
      height: context.dynamicHeight(0.46),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              ImageConstant.EMPTY_CART_BACKGROUND,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: context.dynamicHeight(0.12),
            child: LocaleText(
              text: LocaleKeys.cart_empty_cart,
              style: GoogleFonts.montserrat(
                fontSize: 18.0,
                color: AppColors.textColor,
                fontWeight: FontWeight.w600,
              ),
              alignment: TextAlign.center,
            ),
          ),
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
