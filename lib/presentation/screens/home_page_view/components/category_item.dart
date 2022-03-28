import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';

class CategoryItem extends StatelessWidget {
  final String? imagePath;
  final String? categoryName;
  final int? color;
  final int? radius;
  const CategoryItem({
    Key? key,
    required this.imagePath,
    required this.categoryName,
    required this.color,
    required this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
            radius: 38,
            backgroundColor: Color(color!),
            child: SvgPicture.network(imagePath!, width: 30.w,height: 30.h,)),
        SizedBox(
          height: context.dynamicHeight(0.01),
        ),
        Text(
          categoryName!,
          style: AppTextStyles.subTitleStyle,
          overflow: TextOverflow.ellipsis,
        ),
        // LocaleText(
        //   textOverFlow: TextOverflow.ellipsis,
        //   text: categoryName,
        //   style: AppTextStyles.subTitleStyle,
        // ),
      ],
    );
  }
}
