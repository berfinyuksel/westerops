import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';

class OldAndNewPrices extends StatelessWidget {
  final TextStyle? textStyle;
  final double? width;
  final double? height;
  const OldAndNewPrices({
    Key? key,
    this.textStyle,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '75 TL',
          style: textStyle!.copyWith(color: Color(0xFFBCBCBC), decoration: TextDecoration.lineThrough),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: context.dynamicWidht(0.01)),
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: AppColors.scaffoldBackgroundColor,
          ),
          child: Text(
            '35 TL',
            style: AppTextStyles.bodyBoldTextStyle.copyWith(color: AppColors.greenColor),
          ),
        ),
      ],
    );
  }
}
