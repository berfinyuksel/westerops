import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddressText extends StatelessWidget {
  const AddressText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: AppTextStyles.bodyTextStyle,
        children: [
          TextSpan(
            text: 'Ev:',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
            text: ' Kuruçeşme, Muallim Cad., Beşiktaş',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
