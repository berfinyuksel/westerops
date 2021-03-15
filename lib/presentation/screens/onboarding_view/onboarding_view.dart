import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Image.asset(
            "assets/images/onboarding_background.png",
            fit: BoxFit.cover,
          ),
        ),
        Container(
          alignment: Alignment(0.5, -0.2),
          padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.1)),
          child: LocaleText(
            alignment: TextAlign.center,
            text: "Gıda israfıyla savaşmak, gezegenimizi korumak için çıktığımız yolculukta aramıza hoş geldin!",
            maxLines: 4,
            style: GoogleFonts.montserrat(
              decoration: TextDecoration.none,
              color: AppColors.textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
