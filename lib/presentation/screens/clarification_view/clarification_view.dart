import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/scaffold/custom_scaffold.dart';
import '../../widgets/text/locale_text.dart';
import 'components/clarification_scrollbar_listview.dart';

class ClarificationView extends StatefulWidget {
  @override
  _ClarificationViewState createState() => _ClarificationViewState();
}

class _ClarificationViewState extends State<ClarificationView> {
  bool checkboxValue = false;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "",
      body: Padding(
        padding: EdgeInsets.only(
          top: context.dynamicHeight(0.02),
          bottom: context.dynamicHeight(0.04),
          left: context.dynamicWidht(0.06),
          right: context.dynamicWidht(0.06),
        ),
        child: Column(
          children: [
            LocaleText(
              text: "KVKK ve Aydınlatma Metni",
              style: AppTextStyles.headlineStyle.copyWith(fontSize: 20.sp),
              alignment: TextAlign.center,
            ),
            Spacer(flex: 5),
            ClarificationScrollBarListView(),
            Spacer(flex: 5),
            /* Row(
              children: [
                buildCheckBox(context),
                Spacer(flex: 1),
                AcceptAgreementText(
                  underlinedText:
                      LocaleKeys.agreement_kvkk_underlined_text.locale,
                  text: LocaleKeys.agreement_kvkk_text.locale,
                ),
                Spacer(flex: 5),
              ],
            ),
            Spacer(flex: 63),
            CustomButton(
              width: context.dynamicWidht(0.86),
              title: LocaleKeys.agreement_kvkk_confirmation_button,
              color: AppColors.greenColor,
              borderColor: AppColors.greenColor,
              textColor: Colors.white,
            ), */
          ],
        ),
      ),
    );
  }

  /*  Container buildCheckBox(BuildContext context) {
    return Container(
      height: context.dynamicWidht(0.05),
      width: context.dynamicWidht(0.05),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
          color: Color(0xFFD1D0D0),
        ),
      ),
      child: Theme(
        data: ThemeData(unselectedWidgetColor: Colors.transparent),
        child: Checkbox(
          checkColor: Colors.greenAccent,
          activeColor: Colors.transparent,
          value: checkboxValue,
          onChanged: (value) {
            setState(() {
              checkboxValue = value!;
            });
          },
        ),
      ),
    );
  } */
}
