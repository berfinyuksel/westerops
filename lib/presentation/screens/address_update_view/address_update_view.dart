import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/user_address.dart';
import '../../../data/services/location_service.dart';
import '../../../logic/cubits/address_cubit/address_cubit.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/scaffold/custom_scaffold.dart';
import '../../widgets/text/locale_text.dart';

class AddressUpdateView extends StatefulWidget {
  final Result addressList;

  const AddressUpdateView({
    Key? key,
    required this.addressList,
  }) : super(key: key);
  @override
  _AddressUpdateViewState createState() => _AddressUpdateViewState();
}

class _AddressUpdateViewState extends State<AddressUpdateView> {
  Result? addressList;
  int adressType = 1;
  TextEditingController tcController = TextEditingController();
  TextEditingController addressNameController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController daireNoController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  @override
  void initState() {
    super.initState();

    addressList = widget.addressList;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: CustomScaffold(
        title: "Adresini Düzenle",
        body: Padding(
          padding: EdgeInsets.only(
              left: context.dynamicWidht(0.06),
              right: context.dynamicWidht(0.06),
              top: context.dynamicHeight(0.02),
              bottom: context.dynamicHeight(0.03)),
          child: SingleChildScrollView(
            child: Container(
              height: context.dynamicHeight(0.75),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LocaleText(
                    text: "Adres",
                    style: AppTextStyles.bodyTitleStyle,
                  ),
                  Spacer(flex: 5),
                  buildDropDown(context, adressType),
                  Spacer(flex: 10),
                  buildTextFormField(
                      addressList!.tcknVkn!, "VKN/TCKN", tcController),
                  Spacer(flex: 10),
                  buildTextFormField(
                      addressList!.name!, "Adres İsmi", addressNameController),
                  Spacer(flex: 10),
                  buildTextFormField(
                      addressList!.province!, "İlçe", districtController),
                  Spacer(flex: 10),
                  buildTextFormField(
                      addressList!.address!, "Adres", addressController),
                  Spacer(flex: 10),
                  buildTextFormField(addressList!.description!,
                      "Adres Açıklaması", descriptionController),
                  Spacer(flex: 10),
                  buildTextFormField(addressList!.phoneNumber!,
                      "Telefon Numarası", phoneNumberController),
                  Spacer(
                    flex: 33,
                  ),
                  CustomButton(
                    width: double.infinity,
                    title: "Düzenle",
                    color: AppColors.greenColor,
                    borderColor: AppColors.greenColor,
                    textColor: Colors.white,
                    onPressed: () {
                      context.read<AddressCubit>().updateAddress(
                          addressList!.id!,
                          addressNameController.text,
                          adressType,
                          addressController.text,
                          descriptionController.text,
                          "Turkiye",
                          "Istanbul",
                          districtController.text,
                          phoneNumberController.text,
                          tcController.text,
                          LocationService.latitude,
                          LocationService.longitude);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buildDropDown(BuildContext context, int dropdownValue) {
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
            child: DropdownButton<int>(
              isExpanded: true,
              underline: Text(""),
              value: dropdownValue,
              icon: Padding(
                padding: EdgeInsets.only(left: 100),
                child: const Icon(Icons.keyboard_arrow_down),
              ),
              iconSize: 17,
              style: AppTextStyles.myInformationBodyTextStyle,
              onChanged: (int? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <int>[1, 2].map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: AutoSizeText(
                    value == 1 ? "Adres" : "Fatura Adresi",
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

  Container buildTextFormField(
      String helperText, String labelText, TextEditingController controller) {
    return Container(
      height:
          controller == descriptionController || controller == addressController
              ? context.dynamicHeight(0.11)
              : context.dynamicHeight(0.06),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderAndDividerColor, width: 2),
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.white,
      ),
      child: TextFormField(
        maxLines: controller == descriptionController ||
                controller == addressController
            ? context.dynamicHeight(0.11).toInt()
            : null,
        cursorColor: AppColors.cursorColor,
        style: AppTextStyles.myInformationBodyTextStyle,
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp('[a-zA-Z0-9]'))
        ],
        controller: controller,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                horizontal: context.dynamicWidht(0.05), vertical: 0),
            labelText: labelText,
            labelStyle: AppTextStyles.bodyTextStyle,
            hintText: helperText,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            border: InputBorder.none),
      ),
    );
  }
}
