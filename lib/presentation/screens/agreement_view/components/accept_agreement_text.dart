import 'package:auto_size_text/auto_size_text.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AcceptAgreementText extends StatelessWidget {
  const AcceptAgreementText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText.rich(
      TextSpan(
        style: AppTextStyles.bodyTextStyle,
        children: [
          TextSpan(
            text: 'Sözleşmeyi ',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
            ),
          ),
          TextSpan(
            text: 'okudum, onaylıyorum',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
