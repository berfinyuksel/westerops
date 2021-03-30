import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DeliveryAvailableTime extends StatelessWidget {
  final double? width;
  final double? height;
  final String? time;
  const DeliveryAvailableTime({
    Key? key,
    this.width,
    this.height,
    this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: AppColors.scaffoldBackgroundColor,
      ),
      child: Row(
        children: [
          Spacer(
            flex: 8,
          ),
          SvgPicture.asset(ImageConstant.PAYMENT_DELIVERY_AVAILABLE_TIME_ICON),
          Spacer(
            flex: 8,
          ),
          Text(
            time!,
            style: AppTextStyles.bodyBoldTextStyle.copyWith(color: AppColors.yellowColor),
            textAlign: TextAlign.center,
          ),
          Spacer(
            flex: 5,
          ),
        ],
      ),
    );
  }
}
