import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../utils/constants/image_constant.dart';
import '../../../../utils/extensions/context_extension.dart';

class SocailAuthErrorPopup extends StatelessWidget {
  const SocailAuthErrorPopup({Key? key, required this.title, required this.description}) : super(key: key);
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(
          horizontal: context.dynamicWidht(0.047),
          vertical: context.dynamicHeight(0.03)),
      content: Container(
        alignment: Alignment.center,
        height: context.dynamicHeight(0.15),
        width: context.dynamicWidht(0.8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(ImageConstant.COMMONS_WARNING_ICON),
            SizedBox(
              width: context.dynamicWidht(0.03),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: AppTextStyles.bodyTitleStyle),
                Spacer(),
                Text(
                  description,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
