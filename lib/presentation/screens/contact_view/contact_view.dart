import 'package:dongu_mobile/presentation/screens/contact_view/components/contact_body_title.dart';
import 'package:dongu_mobile/presentation/screens/contact_view/components/contact_list_tile.dart';
import 'package:dongu_mobile/presentation/widgets/scaffold/custom_scaffold.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        top: context.dynamicHeight(0.02),
        bottom: context.dynamicHeight(0.04),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ContactBodyTitle(
            text: LocaleKeys.contact_view_body_title,
          ),
          SizedBox(
            height: context.dynamicHeight(0.01),
          ),
          ContactListTile(
            text: LocaleKeys.contact_view_list_tile_1,
            trailingText: "+90 850 123 123 23 23",
          ),
          Spacer(),
          Center(child: SvgPicture.asset(ImageConstant.DONGU_LOGO)),
          SizedBox(
            height: context.dynamicHeight(0.026),
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
