import 'package:auto_size_text/auto_size_text.dart';
import 'package:dongu_mobile/data/model/order_received.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';

import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderNamesWidget extends StatelessWidget {
  final Box box;
  OrderNamesWidget({
    Key? key,
    required this.box,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.dynamicHeight(0.1),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildFirstRow(context, box),
          Spacer(
            flex: 18,
          ),
          buildSecondRow(context, box),
        ],
      ),
    );
  }

  Padding buildFirstRow(BuildContext context, Box box) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.05)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AutoSizeText(
            'Surprise Box 1',
            style: AppTextStyles.myInformationBodyTextStyle,
          ),
          SvgPicture.asset(ImageConstant.SURPRISE_PACK_FORWARD_ICON),
          AutoSizeText(
            box.textName.toString(),
            style: AppTextStyles.myInformationBodyTextStyle,
          ),
        ],
      ),
    );
  }

  Padding buildSecondRow(BuildContext context, Box box) {
    List<String> meals = [];
    String mealNames = "";
    if (box.meals!.isNotEmpty) {
      for (var i = 0; i < box.meals!.length; i++) {
        meals.add(box.meals![i].name!);
      }
      mealNames = meals.join('\n');
    }
    return Padding(
      padding: EdgeInsets.only(right: context.dynamicWidht(0.01)),
      child: Row(
        children: [
          Spacer(),
          AutoSizeText(
            box.meals!.isEmpty ? "" : mealNames,
            style: AppTextStyles.subTitleStyle,
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
