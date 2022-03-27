import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/text/locale_text.dart';

class PastOrderDetailTotalPaymentListTile extends StatelessWidget {
  final String? title;
  final double? price;
  final bool? withDecimal;

  const PastOrderDetailTotalPaymentListTile({
    Key? key,
    this.title,
    this.price,
    this.withDecimal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        left: 26.w,
        right: 32.w,
      ),
      trailing: Container(
        alignment: Alignment.center,
        width: 80.w,
        height: 40.h,
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
    );
  }
}
