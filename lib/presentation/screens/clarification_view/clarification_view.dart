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
      isNavBar: true,
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
            SizedBox(height: 50.h),
            ClarificationScrollBarListView(),
          ],
        ),
      ),
    );
  }
}
