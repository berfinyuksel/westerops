import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/theme/app_colors/app_colors.dart';

class SignWithSocialAuth extends StatelessWidget {
  final String? image;
  final String text;
  const SignWithSocialAuth({
    Key? key,
    this.image,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.h,
      width: 300.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.0),
        color: Colors.white,
        border: Border.all(width: 2.0, color: AppColors.borderAndDividerColor),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
            child: SvgPicture.asset(
              image!,
              height: 40.h,
            ),
          ),
          LocaleText(
            text: text,
            alignment: TextAlign.center,
            style: AppTextStyles.bodyTextStyle.copyWith(fontSize: 10),
          ),
        ],
      ),
    );
  }
}
