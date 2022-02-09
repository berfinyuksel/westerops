import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utils/locale_keys.g.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/text/locale_text.dart';

class ContactConfirmationListTile extends StatelessWidget {
  const ContactConfirmationListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        left: 28.w,
        right: 28.h,
        top: 4.h,
      ),
      tileColor: Colors.white,
      title: LocaleText(
        text: LocaleKeys.general_settings_contact_confirmation,
        style: AppTextStyles.subTitleStyle,
      ),
    );
  }
}
