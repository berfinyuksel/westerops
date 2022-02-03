import 'package:flutter/material.dart';

import '../../../../../utils/extensions/context_extension.dart';
import '../../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../../widgets/text/locale_text.dart';

class DeliveryCustomButton extends StatelessWidget {
  final double? width;
  final String? title;
  final Color? color;

  final VoidCallback? onPressed;
  const DeliveryCustomButton({
    Key? key,
    this.width,
    this.title,
    this.color,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.dynamicHeight(0.052),
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: color,
        border: Border.all(
          width: 1.0,
          color: Color(0xFFD1D0D0),
        ),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          title!,
          style: AppTextStyles.bodyTextStyle,
        ),
      ),
    );
  }
}
