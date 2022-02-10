import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utils/locale_keys.g.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/text/locale_text.dart';

class AddressBodyTitle extends StatelessWidget {
  const AddressBodyTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 28.w,
      ),
      child: LocaleText(
        text: LocaleKeys.address_body_title,
        style: AppTextStyles.bodyTitleStyle,
      ),
    );
  }
}
