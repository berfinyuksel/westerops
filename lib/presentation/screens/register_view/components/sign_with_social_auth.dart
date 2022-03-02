import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/locale_keys.g.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/text/locale_text.dart';

class SignWithSocialAuth extends StatelessWidget {
  final String? image;
  final bool? isApple;
  const SignWithSocialAuth({
    Key? key,
    this.image,
    this.isApple = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.dynamicHeight(0.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
        border: Border.all(width: 2.0, color: AppColors.borderAndDividerColor),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            image!,
          ),
          LocaleText(
            text: isApple! ? LocaleKeys.register_social_auth_apple : LocaleKeys.register_social_auth,
            style: AppTextStyles.bodyTextStyle.copyWith(fontSize: 10),
          ),
          SizedBox(width: 10.w)
        ],
      ),
    );
  }
}
