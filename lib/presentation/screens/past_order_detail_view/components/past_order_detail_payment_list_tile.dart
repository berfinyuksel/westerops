import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/text/locale_text.dart';

class PastOrderDetailPaymentListTile extends StatelessWidget {
  final String? title;
  final double? price;
  final bool oldPrice;
  final bool? lineTrough;
  final bool? withDecimal;
  final double? oldPriceValue;

  const PastOrderDetailPaymentListTile({
    Key? key,
    this.title,
    this.price,
    this.oldPrice = false,
    @required this.lineTrough,
    this.withDecimal,
    this.oldPriceValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        left: 26.w,
        right: 26.w,
      ),
      trailing: Container(
        alignment: Alignment.center,
        width: 165.w,
        height: 40.h,
        child: Row(
          children: [
            oldPrice
                ? Builder(builder: (context) {
                    return Text(
                      '${withDecimal! ? oldPriceValue?.toStringAsFixed(2) : oldPriceValue?.toStringAsFixed(0)} TL',
                      style: AppTextStyles.bodyBoldTextStyle.copyWith(
                          decoration: TextDecoration.lineThrough,
                          color: AppColors.unSelectedpackageDeliveryColor),
                    );
                  })
                : Spacer(),
            SizedBox(width: 10.w),
            Container(
              alignment: Alignment.center,
              width: 90.w,
              height: 30.h,
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
          ],
        ),
      ),
      tileColor: Colors.white,
      title: LocaleText(
        text: title!,
        style: AppTextStyles.bodyTextStyle,
      ),
    );
  }
}
