import 'package:dongu_mobile/presentation/widgets/button/custom_button.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../utils/extensions/context_extension.dart';

class CustomAlertDialogResetPassword extends StatelessWidget {
  const CustomAlertDialogResetPassword({
    Key? key,
    required this.description, required this.onPressed,
  }) : super(key: key);
  final String description;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.04)),
        width: context.dynamicWidht(0.86),
        height: context.dynamicHeight(0.23),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Spacer(
              flex: 8,
            ),
            SvgPicture.asset(
              ImageConstant.DONGU_LOGO,
              height: context.dynamicHeight(0.047),
            ),
            Spacer(
              flex: 5,
            ),
            LocaleText(
              text: description,
              style: AppTextStyles.bodyBoldTextStyle,
              alignment: TextAlign.center,
            ),
            Spacer(
              flex: 5,
            ),
            buildButtons(context),
            Spacer(
              flex: 5,
            ),
          ],
        ),
      ),
    );
  }

  CustomButton buildButtons(BuildContext context) {
    return CustomButton(
      width: context.dynamicWidht(0.78),
      color: AppColors.greenColor,
      textColor: Colors.white,
      borderColor: AppColors.greenColor,
      title: LocaleKeys.forgot_password_ok,
      onPressed: onPressed,
    );
  }
}
