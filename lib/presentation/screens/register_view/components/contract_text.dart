import 'package:auto_size_text/auto_size_text.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/extensions/string_extension.dart';

class ContractText extends StatelessWidget {
  const ContractText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.06)),
      child: AutoSizeText.rich(
        TextSpan(
          style: AppTextStyles.subTitleStyle,
          children: [
            TextSpan(
              text: LocaleKeys.register_contract_text1.locale,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w300,
              ),
            ),
            TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, RouteConstant.AGREEMENT_VIEW);
                },
              text: LocaleKeys.register_contract_text2.locale,
              style: GoogleFonts.montserrat(
                color: AppColors.orangeColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: LocaleKeys.register_contract_text3.locale,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w300,
              ),
            ),
            TextSpan(
              text: LocaleKeys.register_contract_text4.locale,
              style: GoogleFonts.montserrat(
                color: AppColors.orangeColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: LocaleKeys.register_contract_text5.locale,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        maxLines: 2,
        textAlign: TextAlign.center,
      ),
    );
  }
}
