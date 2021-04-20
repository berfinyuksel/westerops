import 'components/agreement_scrollbar_listview.dart';
import '../agreement_view/components/accept_agreement_text.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/scaffold/custom_scaffold.dart';
import '../../widgets/text/locale_text.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class AgreementKvkkView extends StatefulWidget {
  @override
  _AgreementKvkkViewState createState() => _AgreementKvkkViewState();
}

class _AgreementKvkkViewState extends State<AgreementKvkkView> {
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
              text: "Kullanıcı Sözleşmesi",
              style: AppTextStyles.headlineStyle.copyWith(fontSize: 20),
              alignment: TextAlign.center,
            ),
            Spacer(flex: 40),
            AgreementScrollBarListView(),
            Spacer(flex: 40),
            Row(
              children: [
                buildCheckBox(context),
                Spacer(flex: 1),
                AcceptAgreementText(
                  underlinedText: "Sözleşme",
                  text: "yi okudum, onaylıyorum",
                ),
                Spacer(flex: 5),
              ],
            ),
            Spacer(flex: 63),
            CustomButton(
              width: context.dynamicWidht(0.86),
              title: "Onaylıyorum",
              color: AppColors.greenColor,
              borderColor: AppColors.greenColor,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Container buildCheckBox(BuildContext context) {
    return Container(
      height: context.dynamicWidht(0.04),
      width: context.dynamicWidht(0.04),
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
  }
}
