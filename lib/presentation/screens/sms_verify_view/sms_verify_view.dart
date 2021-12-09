import 'package:dongu_mobile/presentation/widgets/button/custom_button.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SmsVerify extends StatefulWidget {
  const SmsVerify({Key? key}) : super(key: key);

  @override
  _SmsVerifyState createState() => _SmsVerifyState();
}

class _SmsVerifyState extends State<SmsVerify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: context.dynamicWidht(0.4)),
            child: SvgPicture.asset(ImageConstant.COMMONS_APP_BAR_LOGO),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: context.dynamicHeight(0.02),
          bottom: context.dynamicHeight(0.04),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(flex: 10),
            buildText(context),
            Spacer(flex: 4),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(22.0),
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
            ),
            Spacer(flex: 2),
            buildButton(context),
            Spacer(flex: 5),
            buildBottomTextAndIcon(context),
            Spacer(flex: 100),
          ],
        ),
      ),
    );
  }

  textFieldOtp({required bool first, required bool last}) {
    return Container(
      height: 55,
      width: 55,
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
                width: 2,
                color: Colors.black12,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                width: 2,
                color: AppColors.greenColor,
              ),
            ),
          ),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
    );
  }

  Container buildText(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.1)),
      child: Column(
        children: [
          LocaleText(
            text: LocaleKeys.sms_verify_text_1,
            style: GoogleFonts.montserrat(
              fontSize: 18.0,
              color: AppColors.orangeColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: context.dynamicHeight(0.05)),
          LocaleText(
            text: LocaleKeys.sms_verify_text_2,
          ),
        ],
      ),
    );
  }

  Padding buildButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: context.dynamicWidht(0.06), right: context.dynamicWidht(0.06)),
      child: CustomButton(
        width: double.infinity,
        title: LocaleKeys.sms_verify_button,
        color: AppColors.greenColor,
        borderColor: AppColors.greenColor,
        textColor: Colors.white,
        onPressed: () {
          Navigator.of(context).pushNamed(RouteConstant.CUSTOM_SCAFFOLD);
        },
      ),
    );
  }

  Container buildBottomTextAndIcon(BuildContext context) {
    return Container(
      height: 50,
      width: 390,
      child: Padding(
        padding: const EdgeInsets.only(left: 130),
        child: Row(
          children: [
            SvgPicture.asset(
              ImageConstant.SMS_OTP_VERIFY_RESEND_CODE_ICON,
            ),
            SizedBox(width: 5),
            LocaleText(
              text: LocaleKeys.sms_verify_text_3,
              style: GoogleFonts.montserrat(
                fontSize: 14.0,
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
