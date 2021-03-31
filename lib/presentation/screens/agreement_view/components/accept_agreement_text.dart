import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AcceptAgreementText extends StatelessWidget {
  final String? underlinedText;
  final String? text;
  final TextStyle? style;

  const AcceptAgreementText({
    Key? key,
    this.underlinedText,
    this.text,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText.rich(
      TextSpan(
        style: style,
        children: [
          TextSpan(
            text: underlinedText,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
            ),
          ),
          TextSpan(
            text: text,
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
