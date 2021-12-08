import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../utils/constants/image_constant.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/text/locale_text.dart';

class PasswordRules extends StatelessWidget {
  const PasswordRules({
    Key? key,
    required this.passwordController,
  }) : super(key: key);

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            passwordController.text.contains(RegExp(r'[0-9]'))
                ? SvgPicture.asset(ImageConstant.REGISTER_LOGIN_PASSWORD_TICK)
                : SvgPicture.asset(
                    ImageConstant.REGISTER_LOGIN_PASSWORD_ELIPSE),
            LocaleText(
              text: LocaleKeys.register_password_rules_number,
              style: AppTextStyles.subTitleStyle
                  .copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Row(
          children: [
            passwordController.text.contains(RegExp(r'[A-Z]'))
                ? SvgPicture.asset(ImageConstant.REGISTER_LOGIN_PASSWORD_TICK)
                : SvgPicture.asset(
                    ImageConstant.REGISTER_LOGIN_PASSWORD_ELIPSE),
            LocaleText(
              text: LocaleKeys.register_password_rules_letter,
              style: AppTextStyles.subTitleStyle
                  .copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Row(
          children: [
            passwordController.text.length > 7
                ? SvgPicture.asset(ImageConstant.REGISTER_LOGIN_PASSWORD_TICK)
                : SvgPicture.asset(
                    ImageConstant.REGISTER_LOGIN_PASSWORD_ELIPSE),
            LocaleText(
              text: LocaleKeys.register_password_rules_character,
              style: AppTextStyles.subTitleStyle
                  .copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        )
      ],
    );
  }
}
