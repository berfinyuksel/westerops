import '../../../../utils/constants/image_constant.dart';
import 'package:flutter/material.dart';
import '../../../../utils/extensions/context_extension.dart';

class RestrauntIcon extends StatelessWidget {
  const RestrauntIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0.03, 0.09),
      width: context.dynamicWidht(0.17),
      height: context.dynamicHeight(0.05),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.white,
        border: Border.all(
          width: 2.0,
          color: const Color(0xFFF2F2FB),
        ),
      ),
      child: Image.asset(ImageConstant.COMMONS_RESTAURANT_ICON),
    );
  }
}
