import 'package:dongu_mobile/presentation/widgets/scaffold/custom_scaffold.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:dongu_mobile/utils/extensions/string_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class NotFilteredView extends StatelessWidget {
  const NotFilteredView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isDrawer: false,
      title: LocaleKeys.filters_done_title.locale,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 40.h,
            ),
            SvgPicture.asset(ImageConstant.SURPRISE_PACK_ALERT),
            SizedBox(
              height: 20.h,
            ),
            LocaleText(
              alignment: TextAlign.center,
              text: LocaleKeys.filters_no_restaurant_text,
              style: AppTextStyles.myInformationBodyTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
