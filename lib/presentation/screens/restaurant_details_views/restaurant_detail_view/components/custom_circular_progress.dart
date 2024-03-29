import '../../../../../utils/extensions/context_extension.dart';
import '../../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../../utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomCircularProgress extends StatelessWidget {
  final Color valueColor;
  final String? ratingText;
  final double? value;
  const CustomCircularProgress(
      {Key? key,
      required this.valueColor,
      required this.ratingText,
      required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(0.034),
      width: context.dynamicWidht(0.072),
      child: Stack(
        children: [
          CircularProgressIndicator(
            value: value ?? 0.0,
            backgroundColor: AppColors.unSelectedpackageDeliveryColor,
            valueColor: AlwaysStoppedAnimation<Color>(valueColor),
          ),
          Center(
            child: Text(
              ratingText ?? "0.0",
              style: AppTextStyles.subTitleStyle
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}
