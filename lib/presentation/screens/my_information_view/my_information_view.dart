import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/shared/shared_prefs.dart';
import '../../../logic/cubits/user_auth_cubit/user_auth_cubit.dart';
import '../../../utils/constants/image_constant.dart';
import '../../../utils/constants/route_constant.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/extensions/string_extension.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/scaffold/custom_scaffold.dart';
import '../../widgets/text/locale_text.dart';
import 'components/update_popup.dart';

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
  bool isVisibilty = false;
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: LocaleKeys.inform_title,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Container(
            height: context.dynamicHeight(0.8),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
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
                buildTextFormField(context,
                    LocaleKeys.inform_list_tile_name.locale, nameController),
                buildTextFormField(
                    context,
                    LocaleKeys.inform_list_tile_surname.locale,
                    surnameController),
                buildTextFormField(context,
                    LocaleKeys.inform_list_tile_birth.locale, birthController),
                buildTextFormField(context,
                    LocaleKeys.inform_list_tile_mail.locale, mailController),
                buildTextFormField(context,
                    LocaleKeys.inform_list_tile_phone.locale, phoneController),
                Spacer(
                  flex: 8,
                ),
                buildChangePassword(context),
                // Spacer(
                //   flex: 8,
                // ),
                // buildSocialAuthTitle(context),
                // Spacer(flex: 2),
                // SocialAuthListTile(
                //   title: LocaleKeys.inform_list_tile_remove_link,
                //   image: ImageConstant.REGISTER_LOGIN_FACEBOOK_ICON,
                // ),
                Spacer(
                  flex: 15,
                ),
                Visibility(visible: isVisibilty, child: buildButton(context)),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, RouteConstant.DELETE_ACCOUNT_VIEW);
                    },
                    child: LocaleText(
                      text: LocaleKeys.inform_delete_account,
                      style: AppTextStyles.bodyTextStyle,
                    ),
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, RouteConstant.FREEZE_ACCOUNT_VIEW);
                    },
                    child: LocaleText(
                      text: LocaleKeys.freeze_account_title,
                      style: AppTextStyles.bodyTextStyle,
                    ),
                  ),
                ),
                Spacer(
                  flex: 8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildTextFormField(BuildContext context, String labelText,
      TextEditingController controller) {
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
             inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp('[a-zA-Z0-9]'))
        ],
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
  Container buildTextFormFieldPhoneNumber(BuildContext context,
      TextEditingController controller) {
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
             inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp('[a-zA-Z0-9]'))
        ],
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: context.dynamicWidht(0.06)),
          labelText: "Telefon numarası",
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
    nameController.text = SharedPrefs.getUserName;
    surnameController.text = SharedPrefs.getUserLastName;
    mailController.text = SharedPrefs.getUserEmail;
    birthController.text = SharedPrefs.getUserBirth;
    phoneController.text = SharedPrefs.getUserPhone;
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
                isVisibilty = !isVisibilty;
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
      padding: EdgeInsets.only(
          left: context.dynamicWidht(0.06), right: context.dynamicWidht(0.06)),
      child: CustomButton(
        width: double.infinity,
        title: LocaleKeys.inform_button,
        color: AppColors.greenColor,
        borderColor: AppColors.greenColor,
        textColor: Colors.white,
        onPressed: () {
          context.read<UserAuthCubit>().updateUser(
                nameController.text,
                surnameController.text,
                mailController.text,
                phoneController.text,
                SharedPrefs.getUserAddress,
                birthController.text,
              );
          setState(() {
            isReadOnly = true;
          });
          showDialog(
              context: context,
              builder: (_) => CustomAlertDialogUpdateInform());
        },
      ),
    );
  }
}
