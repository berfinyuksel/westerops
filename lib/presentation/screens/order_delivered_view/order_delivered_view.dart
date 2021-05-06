import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/constants/image_constant.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/extensions/string_extension.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/text/locale_text.dart';

class OrderDeliveredView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          color: AppColors.scaffoldBackgroundColor,
          child: SvgPicture.asset(
            ImageConstant.ORDER_RECEIVING_BACKGROUND,
            fit: BoxFit.fitWidth,
          ),
        ),
        Scaffold(
          appBar: buildAppBar(context),
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              children: [
                Spacer(flex: 72),
                LocaleText(
                  text: LocaleKeys.order_received_headline,
                  style: AppTextStyles.appBarTitleStyle.copyWith(fontWeight: FontWeight.w400, color: AppColors.orangeColor),
                  alignment: TextAlign.center,
                ),
                buildOrderNumber(),
                SvgPicture.asset(
                  ImageConstant.ORDER_DELIVERED_ICON,
                  height: context.dynamicHeight(0.34),
                ),
                Spacer(flex: 105),
                LocaleText(
                  text: LocaleKeys.order_delivered_headline_text,
                  style: AppTextStyles.headlineStyle,
                  alignment: TextAlign.center,
                ),
                Spacer(flex: 21),
                LocaleText(
                  text: LocaleKeys.order_delivered_body_text,
                  style: AppTextStyles.bodyBoldTextStyle,
                  alignment: TextAlign.center,
                ),
                Spacer(flex: 29),
                Padding(
                  padding: EdgeInsets.only(left: context.dynamicWidht(0.06), right: context.dynamicWidht(0.06), bottom: context.dynamicHeight(0.04)),
                  child: CustomButton(
                    width: double.infinity,
                    title: LocaleKeys.order_delivered_button,
                    color: AppColors.greenColor,
                    borderColor: AppColors.greenColor,
                    textColor: Colors.white,
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  AutoSizeText buildOrderNumber() {
    return AutoSizeText.rich(
      TextSpan(
        style: AppTextStyles.bodyTextStyle,
        children: [
          TextSpan(
            text: LocaleKeys.order_received_order_number.locale,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: '86123345',
            style: GoogleFonts.montserrat(
              color: AppColors.greenColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      shadowColor: Colors.transparent,
      leading: IconButton(
        icon: SvgPicture.asset(ImageConstant.COMMONS_CLOSE_ICON),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: SvgPicture.asset(ImageConstant.COMMONS_APP_BAR_LOGO),
      centerTitle: true,
    );
  }
}
