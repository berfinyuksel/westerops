import 'package:dongu_mobile/presentation/screens/my_information_view/components/social_auth_list_tile.dart';
import 'package:dongu_mobile/presentation/widgets/button/custom_button.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dongu_mobile/presentation/widgets/scaffold/custom_scaffold.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/extensions/string_extension.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';

class MyInformationView extends StatefulWidget {
  @override
  _MyInformationViewState createState() => _MyInformationViewState();
}

class _MyInformationViewState extends State<MyInformationView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController birthController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool isReadOnly = true;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: LocaleKeys.inform_title,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(
            flex: 4,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: context.dynamicWidht(0.06),
              right: context.dynamicWidht(0.06),
            ),
            child: buildRowTitleAndEdit(),
          ),
          Spacer(
            flex: 2,
          ),
          Container(
            color: Colors.white,
            height: context.dynamicHeight(0.01),
          ),
          buildTextFormField(context, LocaleKeys.inform_list_tile_name.locale, nameController),
          buildTextFormField(context, LocaleKeys.inform_list_tile_surname.locale, surnameController),
          buildTextFormField(context, LocaleKeys.inform_list_tile_birth.locale, birthController),
          buildTextFormField(context, LocaleKeys.inform_list_tile_mail.locale, mailController),
          buildTextFormField(context, LocaleKeys.inform_list_tile_phone.locale, phoneController),
          Spacer(
            flex: 8,
          ),
          buildChangePassword(context),
          Spacer(
            flex: 8,
          ),
          buildSocialAuthTitle(context),
          Spacer(flex: 2),
          SocialAuthListTile(
            title: LocaleKeys.inform_list_tile_remove_link,
            image: ImageConstant.REGISTER_LOGIN_FACEBOOK_ICON,
          ),
          Spacer(
            flex: 15,
          ),
          buildButton(context),
          Spacer(
            flex: 3,
          ),
          Center(
            child: LocaleText(
              text: LocaleKeys.inform_delete_account,
              style: AppTextStyles.bodyTextStyle,
            ),
          ),
          Spacer(
            flex: 8,
          ),
        ],
      ),
    );
  }

  Container buildTextFormField(BuildContext context, String labelText, TextEditingController controller) {
    return Container(
      height: context.dynamicHeight(0.06),
      color: Colors.white,
      child: TextFormField(
        readOnly: isReadOnly,
        style: AppTextStyles.myInformationBodyTextStyle,
        cursorColor: AppColors.cursorColor,
        onTap: () {
          setState(() {});
        },
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: context.dynamicWidht(0.06)),
          labelText: labelText,
          hintStyle: AppTextStyles.myInformationBodyTextStyle,
          labelStyle: AppTextStyles.bodyTextStyle,
          enabledBorder: buildOutlineInputBorder(),
          focusedBorder: buildOutlineInputBorder(),
          border: buildOutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    nameController.text = "John";
    surnameController.text = "Doe";
    mailController.text = "jonh.doe@mail.com";
    birthController.text = "12.09.1992";
    phoneController.text = "+90 555 55 55";
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
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
        Visibility(
          visible: isReadOnly,
          child: GestureDetector(
            onTap: () {
              setState(() {
                isReadOnly = false;
              });
            },
            child: LocaleText(
              text: LocaleKeys.inform_edit,
              style: GoogleFonts.montserrat(
                fontSize: 12.0,
                color: AppColors.orangeColor,
                fontWeight: FontWeight.w600,
                height: 2.0,
              ),
              alignment: TextAlign.right,
            ),
          ),
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
      onTap: () {
        Navigator.pushNamed(context, RouteConstant.CHANGE_PASSWORD_VIEW);
      },
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
        onPressed: () {
          setState(() {
            isReadOnly = true;
          });
        },
      ),
    );
  }
}
