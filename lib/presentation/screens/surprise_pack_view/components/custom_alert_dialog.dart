import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/logic/cubits/basket_counter_cubit/basket_counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/src/provider.dart';

import '../../../../utils/constants/image_constant.dart';
import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/locale_keys.g.dart';
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
        height: context.dynamicHeight(0.29),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.0),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Spacer(
              flex: 8,
            ),
            SvgPicture.asset(
              imagePath!,
              height: context.dynamicHeight(0.134),
            ),
            SizedBox(height: 10),
            LocaleText(
              text: textMessage,
              style: AppTextStyles.bodyBoldTextStyle,
              alignment: TextAlign.center,
            ),
            Spacer(
              flex: 35,
            ),
            buildButtons(context),
            Spacer(
              flex: 20,
            ),
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
