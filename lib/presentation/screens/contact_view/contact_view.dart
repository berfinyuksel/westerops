import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/constants/image_constant.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/scaffold/custom_scaffold.dart';
import '../../widgets/text/locale_text.dart';
import 'components/contact_list_tile.dart';

class ContactView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: LocaleKeys.contact_view_title,
      body: buildBody(context),
    );
  }

  Padding buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 20.h,
        bottom: 40.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /* ContactBodyTitle(
            text: LocaleKeys.contact_view_body_title,
          ), */
          SizedBox(
            height: 10.h,
          ),
          /* ContactListTile(
            text: LocaleKeys.contact_view_list_tile_1,
            trailingText: "+90 850 123 123 23 23",
          ), */
          ContactListTile(
            text: "Bize Ulaşın",
            // trailingText: "dongu@support.com",
          ),
          Spacer(),
          Center(child: SvgPicture.asset(ImageConstant.DONGU_LOGO)),
          SizedBox(
            height: 25.1.h,
          ),
          Center(
            child: LocaleText(
              text: LocaleKeys.about_app_version,
              style: AppTextStyles.subTitleStyle,
              alignment: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
