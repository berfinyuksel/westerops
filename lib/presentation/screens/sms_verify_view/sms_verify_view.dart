import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/presentation/screens/forgot_password_view/forgot_password_view.dart';
import 'package:dongu_mobile/presentation/screens/register_view/components/error_popup.dart';
import 'package:dongu_mobile/presentation/widgets/button/custom_button.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:dongu_mobile/utils/extensions/string_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SmsVerify extends StatefulWidget {
  const SmsVerify({Key? key}) : super(key: key);

  @override
  _SmsVerifyState createState() => _SmsVerifyState();
}

class _SmsVerifyState extends State<SmsVerify> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool showLoading = false;
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  String? verificationId;
  String? userPhoneNumber;
  @override
  void initState() {
    print(SharedPrefs.getUserPhone);
    userPhoneNumber = SharedPrefs.getUserPhone;
    print(userPhoneNumber);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(ImageConstant.BACK_ICON),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 170.w),
            child: SvgPicture.asset(ImageConstant.COMMONS_APP_BAR_LOGO),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.w),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(flex: 5),
            buildText(context),
            Spacer(flex: 4),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textFieldOtp(first: true, last: false),
                  textFieldOtp(first: false, last: false),
                  textFieldOtp(first: false, last: false),
                  textFieldOtp(first: false, last: false),
                  textFieldOtp(first: false, last: false),
                  textFieldOtp(first: false, last: true),
                ],
              ),
            ),
            Spacer(flex: 2),
            buildButton(context),
            Spacer(flex: 3),
            Center(child: buildBottomTextAndIcon(context)),
            Spacer(flex: 40),
          ],
        ),
      ),
    );
  }

  textFieldOtp({required bool first, required bool last}) {
    return Container(
      height: 70.h,
      width: 55.w,
      child: AspectRatio(
        aspectRatio: 0.5,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                width: 2.w,
                color: Colors.black12,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                width: 2.w,
                color: AppColors.greenColor,
              ),
            ),
          ),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.sp,
          ),
        ),
      ),
    );
  }

  Container buildText(BuildContext context) {
    String? phoneNumber = userPhoneNumber!;
    List<String> phoneNumberList = phoneNumber.split("").toList();
    List<String> lastTwoDigitList = [];
    int phoneLength = phoneNumberList.length;
    lastTwoDigitList.add(phoneNumberList[phoneLength - 2]);
    lastTwoDigitList.add(phoneNumberList[phoneLength - 1]);
    String lastTwoDigits = lastTwoDigitList.join("");
    print(lastTwoDigits);
    return Container(
      child: Column(
        children: [
          Center(
            child: LocaleText(
              text: LocaleKeys.sms_verify_text_1,
              style: GoogleFonts.montserrat(
                fontSize: 18.0.sp,
                color: AppColors.orangeColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 37.h),
          Text.rich(
            TextSpan(children: [
              TextSpan(text: "***" + lastTwoDigits),
              TextSpan(
                text: LocaleKeys.sms_verify_text_2.locale,
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Padding buildButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 28.w, right: 28.w),
      child: CustomButton(
        width: 372.w,
        title: LocaleKeys.sms_verify_button,
        color: AppColors.greenColor,
        borderColor: AppColors.greenColor,
        textColor: Colors.white,
        onPressed: () {
          if (verificationId == null) {
            showDialog(
              context: context,
              builder: (_) => CustomErrorPopup(
                textMessage:
                    "Telefon numarası veya SMS kodu hatalı. \nLütfen tekrar deneyiniz",
                buttonOneTitle: "Tamam",
                buttonTwoTittle: LocaleKeys.address_address_approval,
                imagePath: ImageConstant.COMMONS_WARNING_ICON,
                onPressedOne: () {
                  Navigator.popAndPushNamed(
                      context, RouteConstant.REGISTER_VIEW);
                },
              ),
            );
          }
          Navigator.of(context).pushNamed(RouteConstant.CUSTOM_SCAFFOLD);
        },
      ),
    );
  }

  GestureDetector buildBottomTextAndIcon(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _auth.verifyPhoneNumber(
            phoneNumber: userPhoneNumber ?? SharedPrefs.getUserPhone,
            verificationCompleted: (phoneAuthCredential) async {
              // print(
              //     "SMS CODE : ${phoneAuthCredential.smsCode}");
              setState(() {
                showLoading = false;
              });
              //signInWithPhoneAuthCredential(phoneAuthCredential);
            },
            verificationFailed: (verificationFailed) async {
              setState(() {
                showLoading = false;
              });
              // ignore: deprecated_member_use
            },
            codeSent: (verificationId, resendingToken) async {
              setState(() {
                showLoading = false;
                currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
                this.verificationId = verificationId;
              });
            },
            codeAutoRetrievalTimeout: (verificationId) async {});
      },
      child: Container(
        height: 25.h,
        width: 180.w,
        child: Row(
          children: [
            SvgPicture.asset(
              ImageConstant.SMS_OTP_VERIFY_RESEND_CODE_ICON,
            ),
            SizedBox(width: 8.w),
            LocaleText(
              text: LocaleKeys.sms_verify_text_3,
              style: GoogleFonts.montserrat(
                fontSize: 14.0.sp,
                color: AppColors.textColor,
              ),
              alignment: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
