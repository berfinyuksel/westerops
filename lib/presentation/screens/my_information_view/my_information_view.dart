import 'package:dongu_mobile/presentation/screens/my_information_view/components/information_list_tile.dart';
import 'package:dongu_mobile/presentation/screens/my_information_view/components/social_auth_list_tile.dart';
import 'package:dongu_mobile/presentation/widgets/button/custom_button.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dongu_mobile/presentation/widgets/scaffold/custom_scaffold.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';

class MyInformationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: LocaleKeys.inform_title,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(
            flex: 2,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: context.dynamicWidht(0.06),
              right: context.dynamicWidht(0.06),
            ),
            child: buildRowTitleAndEdit(),
          ),
          Spacer(
            flex: 1,
          ),
          InformationListTile(
            title: LocaleKeys.inform_list_tile_name,
            subtitle: "John",
          ),
          InformationListTile(
            title: LocaleKeys.inform_list_tile_surname,
            subtitle: "Doe",
          ),
          InformationListTile(
            title: LocaleKeys.inform_list_tile_birth,
            subtitle: "12.09.1992",
          ),
          InformationListTile(
            title: LocaleKeys.inform_list_tile_mail,
            subtitle: "jonh.doe@mail.com",
          ),
          InformationListTile(
            title: LocaleKeys.inform_list_tile_phone,
            subtitle: "+90 555 55 55",
          ),
          Spacer(
            flex: 4,
          ),
          buildChangePassword(context),
          Spacer(
            flex: 4,
          ),
          buildSocialAuthTitle(context),
          Spacer(flex: 1),
          SocialAuthListTile(
            title: LocaleKeys.inform_list_tile_remove_link,
            image: ImageConstant.REGISTER_LOGIN_FACEBOOK_ICON,
          ),
          Spacer(
            flex: 11,
          ),
          buildButton(context),
          Spacer(
            flex: 4,
          ),
        ],
      ),
    );
  }

  Row buildRowTitleAndEdit() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LocaleText(
          text: LocaleKeys.inform_body_title_1,
          style: AppTextStyles.bodyTitleStyle,
        ),
        LocaleText(
          text: LocaleKeys.inform_edit,
          style: GoogleFonts.montserrat(
            fontSize: 12.0,
            color: AppColors.orangeColor,
            fontWeight: FontWeight.w600,
            height: 2.0,
          ),
          alignment: TextAlign.right,
        ),
      ],
    );
  }

  ListTile buildChangePassword(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
      ),
      tileColor: Colors.white,
      title: LocaleText(
        text: LocaleKeys.inform_list_tile_change_password,
        style: AppTextStyles.myInformationBodyTextStyle,
      ),
      trailing: SvgPicture.asset(
        ImageConstant.COMMONS_FORWARD_ICON,
      ),
      onTap: () {},
    );
  }

  Padding buildSocialAuthTitle(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
      ),
      child: LocaleText(
        text: LocaleKeys.inform_body_title_2,
        style: AppTextStyles.bodyTitleStyle,
      ),
    );
  }

  Padding buildButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: context.dynamicWidht(0.06), right: context.dynamicWidht(0.06)),
      child: CustomButton(
        width: double.infinity,
        title: LocaleKeys.inform_button,
        color: AppColors.greenColor,
        borderColor: AppColors.greenColor,
        textColor: Colors.white,
      ),
    );
  }
}
