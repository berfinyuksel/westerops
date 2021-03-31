import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';

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
      width: context.dynamicWidht(0.16),
      height: context.dynamicHeight(0.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: AppColors.scaffoldBackgroundColor,
      ),
      child: Text(
        '${withDecimal! ? price!.toStringAsFixed(2) : price!.toStringAsFixed(0)} TL',
        style: AppTextStyles.bodyBoldTextStyle.copyWith(color: AppColors.greenColor),
      ),
    );
  }
}
