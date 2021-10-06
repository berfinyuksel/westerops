import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../utils/extensions/context_extension.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../text/locale_text.dart';

class CustomButton extends StatelessWidget {
  final double? width;
  final String? title;
  final Color? color;
  final Color? borderColor;
  final Color? textColor;
  final VoidCallback? onPressed;
  final bool isActive;
  CustomButton({
    Key? key,
    this.width,
    this.title,
    this.color,
    this.isActive = true,
    this.textColor,
    this.onPressed,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.dynamicHeight(0.052),
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: isActive ? color : Colors.transparent,
        border: Border.all(
          width: 2.0,
          color: borderColor!,
        ),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: LocaleText(
          text: title,
          style: AppTextStyles.bodyTitleStyle
              .copyWith(color: isActive ? textColor! : AppColors.greenColor),
        ),
      ),
    );
  }
}
