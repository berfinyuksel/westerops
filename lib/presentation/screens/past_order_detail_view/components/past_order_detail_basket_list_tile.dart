import 'package:flutter/material.dart';

import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/text/locale_text.dart';

class PastOrderDetailBasketListTile extends StatelessWidget {
  final String? title;
  final double? price;
  final String? subTitle;
  final bool? withDecimal;
  final bool? withMinOrderPrice;
  final double? leftPadding;
  final double? rightPadding;

  const PastOrderDetailBasketListTile({
    Key? key,
    this.title,
    this.price,
    this.subTitle,
    this.withDecimal,
    this.withMinOrderPrice = false,
    this.leftPadding,
    this.rightPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
      ),
      trailing: Container(
        alignment: Alignment.center,
        width: context.dynamicWidht(0.16),
        height: context.dynamicHeight(0.04),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: AppColors.scaffoldBackgroundColor,
        ),
        child: Text(
          '${withDecimal! ? price!.toStringAsFixed(2) : price!.toStringAsFixed(0)} TL',
          style: AppTextStyles.bodyBoldTextStyle
              .copyWith(color: AppColors.greenColor),
        ),
      ),
      tileColor: Colors.white,
      title: LocaleText(
        text: title!,
        style: AppTextStyles.myInformationBodyTextStyle,
      ),
      subtitle: Text(
        subTitle!,
        style: AppTextStyles.subTitleStyle,
      ),
    );
  }
}
