import 'package:dongu_mobile/logic/cubits/user_auth_cubit/user_email_control_cubit.dart';
import 'package:dongu_mobile/presentation/screens/forgot_password_view/components/popup_reset_password.dart';
import 'package:dongu_mobile/presentation/screens/forgot_password_view/forgot_password_view.dart';
import 'package:dongu_mobile/presentation/screens/restaurant_details_views/restaurant_detail_view/components/custom_circular_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:googleapis/drive/v2.dart';
import 'package:intl/intl.dart';
import '../../../data/services/locator.dart';
import '../../../data/shared/shared_prefs.dart';
import '../../../logic/cubits/generic_state/generic_state.dart';
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
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../login_view/components/error_dialog_for_login.dart';

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
  DateTime? _selectedDate;
  bool isReadOnly = true;
  bool isVisibilty = false;
  String phoneTR = '+90';
  late bool userSocialLogin;

  bool showLoading = false;
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  String? verificationId;
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: LocaleKeys.inform_title,
      isNavBar: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Container(
            height: 780.h,
            child: Column(
              children: [
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.only(
                    left: 28.w,
                    right: 28.w,
                  ),
                  child: buildRowTitleAndEdit(),
                ),
                SizedBox(height: 10.h),
                Container(
                  color: Colors.white,
                  height: 12.h,
                ),
                Container(
                  height: 280.h,
                  color: Colors.white,
                  child: Column(
                    children: [
                      buildTextFormField(
                          context,
                          LocaleKeys.inform_list_tile_name.locale,
                          nameController),
                      buildTextFormField(
                          context,
                          LocaleKeys.inform_list_tile_surname.locale,
                          surnameController),
                      buildTextFormFieldBirthDate(
                          context,
                          LocaleKeys.inform_list_tile_birth.locale,
                          birthController),
                      buildEmailTextFormField(
                          context,
                          LocaleKeys.inform_list_tile_mail.locale,
                          mailController,
                          sl<UserEmailControlCubit>().state != ""
                              ? true
                              : false),
                      buildTextFormField(
                          context,
                          LocaleKeys.inform_list_tile_phone.locale,
                          phoneController),
                    ],
                  ),
                ),
                SizedBox(height: 40.h),
                buildChangePassword(context),
                Spacer(),
                Visibility(visible: isVisibilty, child: buildButton(context)),
                // Spacer(),
                SizedBox(height: 32.h),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context,
                        RouteConstant.DELETE_ACCOUNT_VIEW,
                        ModalRoute.withName('/deleteAccount'));
                  },
                  child: LocaleText(
                    text: LocaleKeys.inform_delete_account,
                    style: AppTextStyles.bodyTextStyle,
                  ),
                ),
                SizedBox(height: 32.h),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                        context, RouteConstant.FREEZE_ACCOUNT_VIEW);
                  },
                  child: LocaleText(
                    text: LocaleKeys.freeze_account_title,
                    style: AppTextStyles.bodyTextStyle,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildTextFormFieldBirthDate(BuildContext context, String labelText,
      TextEditingController controller) {
    return Container(
      height: 56.h,
      color: Colors.white,
      child: TextFormField(
        keyboardType: TextInputType.none,
        inputFormatters: [
          DateInputFormatter(),
        ],
        readOnly: isReadOnly,
        style: AppTextStyles.myInformationBodyTextStyle,
        cursorColor: AppColors.cursorColor,
        onTap: () {
          if (!isReadOnly) {
            showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1950),
              lastDate: DateTime.now(),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(
                      primary: AppColors.greenColor, // header background color
                      onPrimary:
                          AppColors.borderAndDividerColor, // header text color
                      onSurface: AppColors.cursorColor, // body text color
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        primary: AppColors.greenColor, // button text color
                      ),
                    ),
                  ),
                  child: child!,
                );
              },
            ).then((pickedDate) {
              if (pickedDate == null) {
                return;
              }
              setState(() {
                _selectedDate = pickedDate;
                String datetime1 =
                    DateFormat("dd/MM/yyyy").format(_selectedDate!);
                birthController.text = datetime1;
              });
            });
          }
        },
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: context.dynamicWidht(0.06)),
          hintStyle: AppTextStyles.myInformationBodyTextStyle,
          labelStyle: AppTextStyles.bodyTextStyle,
          labelText: labelText,
          enabledBorder: buildOutlineInputBorder(),
          focusedBorder: buildOutlineInputBorder(),
          border: buildOutlineInputBorder(),
        ),
      ),
    );
  }

  Container buildTextFormField(BuildContext context, String labelText,
      TextEditingController controller) {
    return Container(
      height: 56.h,
      color: Colors.white,
      child: TextFormField(
        readOnly: isReadOnly,
        style: AppTextStyles.myInformationBodyTextStyle,
        cursorColor: AppColors.cursorColor,
        onTap: () {
          setState(() {});
        },
        inputFormatters: [
          // FilteringTextInputFormatter.deny(RegExp('[a-zA-Z0-9]'))
          FilteringTextInputFormatter.singleLineFormatter,
        ],
        controller: controller,
        decoration: InputDecoration(
          prefixText: controller == phoneController ? phoneTR : null,
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

  Container buildEmailTextFormField(BuildContext context, String labelText,
      TextEditingController controller, bool enabled) {
    return Container(
      height: 56.h,
      color: Colors.white,
      child: TextFormField(
        readOnly: enabled,
        style: AppTextStyles.myInformationBodyTextStyle,
        cursorColor: AppColors.cursorColor,
        onTap: () {
          setState(() {});
        },
        inputFormatters: [
          // FilteringTextInputFormatter.deny(RegExp('[a-zA-Z0-9]'))
          FilteringTextInputFormatter.singleLineFormatter,
        ],
        controller: controller,
        decoration: InputDecoration(
          prefixText: controller == phoneController ? phoneTR : null,
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
    userSocialLogin = SharedPrefs.getSocialLogin;
    nameController.text = SharedPrefs.getUserName;
    surnameController.text = SharedPrefs.getUserLastName;
    mailController.text = SharedPrefs.getUserEmail;
    birthController.text = SharedPrefs.getUserBirth;
    // phoneController.text = SharedPrefs.getUserPhone;
    phoneController.text = isReadOnly && SharedPrefs.getUserPhone.isNotEmpty
        ? SharedPrefs.getUserPhone.substring(3)
        : SharedPrefs.getUserPhone;
    print(phoneController.text);
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
                height: 2.0.h,
              ),
              alignment: TextAlign.right,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildChangePassword(BuildContext context) {
    return Visibility(
      visible: !userSocialLogin,
      child: ListTile(
        contentPadding: EdgeInsets.only(
          left: 28.w,
          right: 29.w,
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
      ),
    );
  }

  phoneControl() {
    if (phoneController.text != SharedPrefs.getUserPhone &&
        phoneController.text.length < 10) {
      return showDialog(
        context: context,
        builder: (_) => CustomAlertDialogResetPassword(
          description: "Lütfen telefon numarasını doğru giriniz.",
          onPressed: () => Navigator.pop(context),
        ),
      );
    } else {
      print("true number");
    }
  }

  updateUser() {
    textControllersSaveCache();
    context.read<UserAuthCubit>().updateUser(
          SharedPrefs.getUserName,
          SharedPrefs.getUserLastName,
          mailController.text,
          phoneController.text,
          SharedPrefs.getUserAddress,
          SharedPrefs.getUserBirth,
          // birthController.text,
        );
    
  }

  textControllersSaveCache() {
    SharedPrefs.setUserPhone(phoneController.text);
    SharedPrefs.setUserEmail(mailController.text);
    SharedPrefs.setUserName(nameController.text);
    SharedPrefs.setUserEmail(surnameController.text);
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
      padding: EdgeInsets.only(left: 28.w, right: 28.w),
      child: CustomButton(
        width: double.infinity,
        title: LocaleKeys.inform_button,
        color: AppColors.greenColor,
        borderColor: AppColors.greenColor,
        textColor: Colors.white,
        onPressed: () {
          print("SOCIAL LOGIN SHARED : ${SharedPrefs.getSocialLogin}");
          if (!SharedPrefs.getSocialLogin) {
            textControllersSaveCache();
            Navigator.popAndPushNamed(
                context, RouteConstant.VERIFY_INFORMATION);
          } else {
            updateUser();
            _showMyDialog();
          }
          setState(() {
            isReadOnly = true;
          });
        },
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        final GenericState state = context.watch<UserAuthCubit>().state;
        if (state is GenericInitial) {
          return Container();
        } else if (state is GenericLoading) {
          return Container();
        } else if (state is GenericCompleted) {
          return buildUpdateCompletedAlertDialog(context);
        } else {
          return buildUpdateErrorAlertDialog(context);
        }
      },
    );
  }

  AlertDialog buildUpdateErrorAlertDialog(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.04)),
        width: context.dynamicWidht(0.87),
        height: context.dynamicHeight(0.29),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.0),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Spacer(
              flex: 8,
            ),
            SvgPicture.asset(
              ImageConstant.COMMONS_WARNING_ICON,
              height: context.dynamicHeight(0.134),
            ),
            SizedBox(height: 10.h),
            Text(
              "Bu e-postaya veya telefon numarasına sahip kullanıcı var.",
              style: AppTextStyles.bodyBoldTextStyle,
              textAlign: TextAlign.center,
            ),
            Spacer(
              flex: 35,
            ),
            CustomButton(
              onPressed: () {
                Navigator.pop(context);
              },
              width: 110.w,
              color: AppColors.greenColor,
              textColor: Colors.white,
              borderColor: AppColors.greenColor,
              title: "Tamam",
            ),
            Spacer(
              flex: 20,
            ),
          ],
        ),
      ),
    );
  }

  AlertDialog buildUpdateCompletedAlertDialog(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.04)),
        width: context.dynamicWidht(0.87),
        height: context.dynamicHeight(0.29),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.0),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Spacer(
              flex: 8,
            ),
            SvgPicture.asset(
              ImageConstant.SURPRISE_PACK,
              height: context.dynamicHeight(0.134),
            ),
            SizedBox(height: 10.h),
            Text(
              "Değişiklikler başarılı bir şekilde güncellendi.",
              style: AppTextStyles.bodyBoldTextStyle,
              textAlign: TextAlign.center,
            ),
            Spacer(
              flex: 35,
            ),
            CustomButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteConstant.CUSTOM_SCAFFOLD);
              },
              width: 110.w,
              color: AppColors.greenColor,
              textColor: Colors.white,
              borderColor: AppColors.greenColor,
              title: LocaleKeys.order_received_button_2,
            ),
            Spacer(
              flex: 20,
            ),
          ],
        ),
      ),
    );
  }
}
