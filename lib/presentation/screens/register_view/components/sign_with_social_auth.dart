import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/locale_keys.g.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/text/locale_text.dart';

class SignWithSocialAuth extends StatelessWidget {
  final String? image;
  const SignWithSocialAuth({
    Key? key,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.dynamicWidht(0.32),
      height: context.dynamicHeight(0.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
        border: Border.all(width: 2.0, color: AppColors.borderAndDividerColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            image!,
          ),
          Spacer(
            flex: 1,
          ),
          LocaleText(
            text: LocaleKeys.register_social_auth,
            style: AppTextStyles.bodyTextStyle,
            maxLines: 1,
          ),
          Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}
