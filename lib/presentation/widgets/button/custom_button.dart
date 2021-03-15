import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double? width;
  final String? title;
  final Color? color;
  final Color? borderColor;
  final Color? textColor;
  final Color? backgroundColor;

  final VoidCallback? onPressed;
  const CustomButton(
      {Key? key,
      this.width,
      this.title,
      this.color,
      this.textColor,
      this.backgroundColor,
      this.onPressed, this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.green,
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
                .copyWith(color: textColor!),
          )),
    );
  }
}
