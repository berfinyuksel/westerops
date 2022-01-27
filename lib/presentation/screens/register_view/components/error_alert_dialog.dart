import 'package:dongu_mobile/utils/constants/image_constant.dart';

import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/constants/image_constant.dart';

import '../../../../utils/extensions/context_extension.dart';

class ErrorAlertDialog extends StatelessWidget {
  final VoidCallback onTap;
  const ErrorAlertDialog({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(
          horizontal: context.dynamicWidht(0.047),
          vertical: context.dynamicHeight(0.03)),
      content: Container(
        alignment: Alignment.center,
        height: context.dynamicHeight(0.18),
        width: context.dynamicWidht(0.8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(
              flex: 2,
            ),
            SvgPicture.asset(ImageConstant.COMMONS_WARNING_ICON),
            Spacer(
              flex: 2,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    'Bu e-posta adresine ait bir \nhesabınızın olduğunu \nfarkettik.',
                    style: AppTextStyles.bodyTitleStyle),
                Text.rich(
                  TextSpan(
                    style: GoogleFonts.montserrat(
                      fontSize: 14.0,
                      color: AppColors.textColor,
                    ),
                    children: [
                      TextSpan(
                        text: 'Hesabınıza ',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      TextSpan(
                        text: 'giriş yapabilir',
                        style: GoogleFonts.montserrat(
                          color: AppColors.orangeColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: ' ',
                        style: GoogleFonts.montserrat(
                          color: AppColors.orangeColor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      TextSpan(
                        text: 'veya \nhatırlamıyorsanız ',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      TextSpan(
                        text: 'şifrenizi \nyenileyebilirsiniz.',
                        style: GoogleFonts.montserrat(
                          color: AppColors.orangeColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.dynamicHeight(0.01))
              ],
            ),
            Spacer(
              flex: 5,
            ),
          ],
        ),
      ),
    );
  }
}
