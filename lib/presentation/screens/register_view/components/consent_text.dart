import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/extensions/string_extension.dart';
import '../../../../utils/locale_keys.g.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';

class ConsentText extends StatelessWidget {
  const ConsentText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.dynamicWidht(0.08),
      width: context.dynamicWidht(0.69),
      child: AutoSizeText.rich(
        TextSpan(
          style: AppTextStyles.subTitleStyle,
          children: [
            TextSpan(
              text: LocaleKeys.register_consent_text1.locale,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w300,
              ),
            ),
            TextSpan(
              text: LocaleKeys.register_consent_text2.locale,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: LocaleKeys.register_consent_text3.locale,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
