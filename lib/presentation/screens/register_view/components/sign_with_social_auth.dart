import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';

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
        children: [
          SvgPicture.asset(image!),
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
