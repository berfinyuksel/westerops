import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:dongu_mobile/presentation/widgets/button/custom_button.dart';
import 'package:dongu_mobile/presentation/widgets/scaffold/custom_scaffold.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';

class AddressDetailView extends StatefulWidget {
  final String title;
  final String district;
  final String address;
  const AddressDetailView({
    Key? key,
    required this.title,
    required this.district,
    required this.address,
  }) : super(key: key);
  @override
  _AddressDetailViewState createState() => _AddressDetailViewState();
}

class _AddressDetailViewState extends State<AddressDetailView> {
  String dropdownValue = "Adres";
  TextEditingController tcController = TextEditingController();
  TextEditingController addressNameController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController daireNoController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    districtController.text = widget.district;
    addressController.text = widget.address;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: widget.title,
      body: Padding(
        padding: EdgeInsets.only(
            left: context.dynamicWidht(0.06),
            right: context.dynamicWidht(0.06),
            top: context.dynamicHeight(0.02),
            bottom: context.dynamicHeight(0.03)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LocaleText(
              text: "Adres",
              style: AppTextStyles.bodyTitleStyle,
            ),
            Spacer(flex: 10),
            buildDropDown(context),
            Spacer(flex: 20),
            buildTextFormField("VKN/TCKN", tcController),
            Spacer(flex: 20),
            buildTextFormField("Adres İsmi", addressNameController),
            Spacer(flex: 20),
            buildTextFormField("İlçe", districtController),
            Spacer(flex: 20),
            buildTextFormField("Adres", addressController),
            Spacer(flex: 20),
            buildTextFormField("No., Daire", daireNoController),
            Spacer(flex: 20),
            buildTextFormField("Adres Açıklaması", descriptionController),
            Spacer(
              flex: 66,
            ),
            CustomButton(
              width: double.infinity,
              title: "Kaydet",
              color: AppColors.greenColor,
              borderColor: AppColors.greenColor,
              textColor: Colors.white,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Container buildDropDown(BuildContext context) {
    return Container(
      height: context.dynamicHeight(0.06),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.05)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
          color: AppColors.borderAndDividerColor,
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: context.dynamicHeight(0.01),
            ),
            child: LocaleText(
              text: "Adres Tipi",
              style: AppTextStyles.subTitleStyle,
            ),
          ),
          Expanded(
            child: DropdownButton<String>(
              isExpanded: true,
              underline: Text(""),
              value: dropdownValue,
              icon: Padding(
                padding: EdgeInsets.only(left: 100),
                child: const Icon(Icons.keyboard_arrow_down),
              ),
              iconSize: 17,
              style: AppTextStyles.myInformationBodyTextStyle,
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>['Adres', 'Fatura Adresi'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: AutoSizeText(
                    value,
                    style: AppTextStyles.myInformationBodyTextStyle,
                    maxLines: 1,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Container buildTextFormField(String labelText, TextEditingController controller) {
    return Container(
      height: controller == descriptionController ? context.dynamicHeight(0.11) : context.dynamicHeight(0.06),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderAndDividerColor, width: 2),
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.white,
      ),
      child: TextFormField(
        maxLines: controller == descriptionController ? context.dynamicHeight(0.11).toInt() : null,
        cursorColor: AppColors.cursorColor,
        style: AppTextStyles.myInformationBodyTextStyle,
        controller: controller,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.05), vertical: 0),
            labelText: labelText,
            labelStyle: AppTextStyles.bodyTextStyle,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            border: InputBorder.none),
      ),
    );
  }
}
