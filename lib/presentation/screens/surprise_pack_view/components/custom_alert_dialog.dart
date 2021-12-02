import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/button/custom_button.dart';
import '../../../widgets/text/locale_text.dart';

class CustomAlertDialog extends StatelessWidget {
  final String? textMessage;
  final String? buttonOneTitle;
  final String? buttonTwoTittle;
  final String? imagePath;
  final VoidCallback? onPressedOne;
  final VoidCallback? onPressedTwo;

  CustomAlertDialog({
    required this.textMessage,
    required this.buttonOneTitle,
    required this.buttonTwoTittle,
    required this.imagePath,
    required this.onPressedOne,
    required this.onPressedTwo,
  });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.04)),
        width: context.dynamicWidht(0.87),
        height: context.dynamicHeight(0.32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.0),
          color: Colors.white,
        ),
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              height: 45,
              width: 90,
              child: SvgPicture.asset(
                imagePath!,
              ),
            ),
            SizedBox(height: 30),
            LocaleText(
              text: textMessage,
              style: AppTextStyles.bodyBoldTextStyle,
              alignment: TextAlign.center,
            ),
            SizedBox(height: 30),
            buildButtons(context),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Builder buildButtons(BuildContext context) {
    return Builder(builder: (context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomButton(
            onPressed: onPressedOne,
            width: context.dynamicWidht(0.35),
            color: Colors.transparent,
            textColor: AppColors.greenColor,
            borderColor: AppColors.greenColor,
            title: buttonOneTitle,
          ),
          CustomButton(
            onPressed: onPressedTwo,
            width: context.dynamicWidht(0.35),
            color: AppColors.greenColor,
            textColor: Colors.white,
            borderColor: AppColors.greenColor,
            title: this.buttonTwoTittle,
          ),
        ],
      );
    });
  }
}
