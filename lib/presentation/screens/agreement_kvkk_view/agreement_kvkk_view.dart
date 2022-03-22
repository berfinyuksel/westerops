import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/scaffold/custom_scaffold.dart';
import '../../widgets/text/locale_text.dart';
import 'components/agreement_scrollbar_listview.dart';

class AgreementKvkkView extends StatefulWidget {
  @override
  _AgreementKvkkViewState createState() => _AgreementKvkkViewState();
}

class _AgreementKvkkViewState extends State<AgreementKvkkView> {
  bool checkboxValue = false;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isNavBar: true,
      title: "Kullanıcı Sözleşmesi ve KVKK",
      body: Padding(
        padding: EdgeInsets.only(
          top: 25.h,
          bottom: 25.h,
          left: 28.w,
          right: 16.w,
        ),
        child: Column(
          children: [
            LocaleText(
              text: "Kullanıcı Sözleşmesi",
              style: AppTextStyles.headlineStyle.copyWith(fontSize: 20.sp),
              alignment: TextAlign.center,
            ),
            SizedBox(height: 50.h),
            AgreementScrollBarListView(),
          ],
        ),
      ),
    );
  }
}
