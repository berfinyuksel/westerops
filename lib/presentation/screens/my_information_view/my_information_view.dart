import 'package:dongu_mobile/presentation/screens/my_information_view/components/information_list_tile.dart';
import 'package:dongu_mobile/presentation/screens/my_information_view/components/social_auth_list_tile.dart';
import 'package:dongu_mobile/presentation/widgets/button/custom_button.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
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
      title: "Bilgilerim",
      body: Padding(
        padding: EdgeInsets.zero,
        child: Column(
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
              title: "Ad",
              subtitle: "John",
            ),
            InformationListTile(
              title: "Soyad",
              subtitle: "Doe",
            ),
            InformationListTile(
              title: "Doğum Tarihi",
              subtitle: "12.09.1992",
            ),
            InformationListTile(
              title: "E-posta",
              subtitle: "jonh.doe@mail.com",
            ),
            InformationListTile(
              title: "Telefon numarası",
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
              title: "Bağlantıyı Kaldır",
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
      ),
    );
  }

  Row buildRowTitleAndEdit() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LocaleText(
          text: "Kişisel Bilgilerim",
          style: AppTextStyles.bodyTitleStyle,
        ),
        LocaleText(
          text: 'Düzenle',
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
        text: "Şifre Değişikliği",
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
        text: "Bağlı Hesaplar",
        style: AppTextStyles.bodyTitleStyle,
      ),
    );
  }

  Padding buildButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: context.dynamicWidht(0.06), right: context.dynamicWidht(0.06)),
      child: CustomButton(
        width: double.infinity,
        title: "Güncelle",
        color: AppColors.greenColor,
        borderColor: AppColors.greenColor,
        textColor: Colors.white,
      ),
    );
  }
}
