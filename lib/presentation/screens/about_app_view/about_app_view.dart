import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/constants/image_constant.dart';
import '../../../utils/constants/route_constant.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/scaffold/custom_scaffold.dart';
import '../../widgets/text/locale_text.dart';
import 'components/about_app_list_tile.dart';

class AboutAppView extends StatelessWidget {
  openUrl() {
    String url = 'https://www.dongu.com/';
    launch(url);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: LocaleKeys.about_app_title,
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
          AboutAppListTile(
            text: LocaleKeys.about_app_website,
            trailingText: LocaleKeys.about_app_website_trailing_text,
            onTap: () {
              openUrl();
            },
          ),
          AboutAppListTile(
            text: LocaleKeys.about_app_contract,
            onTap: () {
              Navigator.pushNamed(context, RouteConstant.AGREEMENT_KVKK_VIEW);
            },
          ),
          AboutAppListTile(
            text: LocaleKeys.about_app_clarification,
            onTap: () {
              Navigator.pushNamed(context, RouteConstant.CLARIFICATION_VIEW);
            },
          ),
          AboutAppListTile(
            text: LocaleKeys.about_app_help_center,
            onTap: () {
              Navigator.pushNamed(context, RouteConstant.HELP_CENTER_VIEW);
            },
          ),
          AboutAppListTile(
            text: LocaleKeys.about_app_contact,
            onTap: () {
              Navigator.pushNamed(context, RouteConstant.CONTACT_VIEW);
            },
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
