import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class PacketNumber extends StatelessWidget {
  final String? text;
  final double? width;
  final double? height;
  const PacketNumber({
    Key? key,
    this.text,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width,
      height: height,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: text == "tükendi" ? AppColors.yellowColor : AppColors.orangeColor),
      child: LocaleText(
        text: text!,
        style: AppTextStyles.subTitleBoldStyle,
        alignment: TextAlign.center,
      ),
    );
  }
}
