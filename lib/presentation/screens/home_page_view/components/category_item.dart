import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';

import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryItem extends StatelessWidget {
  final String? imagePath;
  final String? categoryName;

  const CategoryItem({
    Key? key,
    required this.imagePath,
    required this.categoryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(imagePath!),
        SizedBox(
          height: context.dynamicHeight(0.01),
        ),
        LocaleText(
          text: categoryName,
          style: AppTextStyles.subTitleStyle,
        )
      ],
    );
  }
}
