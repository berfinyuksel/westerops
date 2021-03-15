import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double? width;
  final String? title;
  final Color? color;
  final Color? textColor;
  final VoidCallback? onPressed;
  const CustomButton({Key? key, this.width, this.title, this.color, this.textColor, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: width,
      child: TextButton(onPressed: onPressed, child: LocaleText(
        text: title,
        style: AppTextStyles.bodyTitleStyle.copyWith(color: AppColors.appBarColor),
      )),
    );
  }
}
