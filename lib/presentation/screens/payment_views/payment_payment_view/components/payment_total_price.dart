import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/extensions/context_extension.dart';
import '../../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../../utils/theme/app_text_styles/app_text_styles.dart';

class PaymentTotalPrice extends StatelessWidget {
  final bool? withDecimal;
  final double? price;
  const PaymentTotalPrice({
    Key? key,
    this.withDecimal,
    this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.02)),
      width: context.dynamicWidht(0.18),
      height: context.dynamicHeight(0.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: AppColors.scaffoldBackgroundColor,
      ),
      child: AutoSizeText(
        '${withDecimal! ? price!.toStringAsFixed(2) : price!.toStringAsFixed(0)} TL',
        style: AppTextStyles.bodyBoldTextStyle.copyWith(color: AppColors.greenColor),
        maxLines: 1,
      ),
    );
  }
}
