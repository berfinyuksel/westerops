import 'package:dongu_mobile/presentation/screens/forgot_password_view/components/popup_reset_password.dart';
import 'package:dongu_mobile/utils/extensions/string_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/services/location_service.dart';
import '../../../logic/cubits/address_cubit/address_cubit.dart';
import '../../../utils/constants/route_constant.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/scaffold/custom_scaffold.dart';
import '../../widgets/text/locale_text.dart';

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
  int adressType = 1;
  TextEditingController tcController = TextEditingController();
  TextEditingController addressNameController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  // TextEditingController daireNoController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    districtController.text = widget.district;
    addressController.text = widget.address;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: CustomScaffold(
        title: widget.title,
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
                  // buildDropDown(context, adressType),
                  // Spacer(flex: 10),
                  buildTextFormField("VKN/TCKN", tcController),
                  Spacer(flex: 10),
                  buildTextFormField(LocaleKeys.address_address_name.locale,
                      addressNameController),
                  Spacer(flex: 10),
                  buildTextFormField(
                      LocaleKeys.address_district.locale, districtController),
                  Spacer(flex: 10),
                  buildTextFormField(
                      LocaleKeys.address_addresss.locale, addressController),
                  Spacer(flex: 10),
                  buildTextFormField(
                      LocaleKeys.address_address_description.locale,
                      descriptionController),
                  Spacer(flex: 10),
                  buildTextFormField(LocaleKeys.address_phone_number.locale,
                      phoneNumberController),
                  Spacer(
                    flex: 33,
                  ),
                  CustomButton(
                    width: double.infinity,
                    title: LocaleKeys.address_save,
                    color: AppColors.greenColor,
                    borderColor: AppColors.greenColor,
                    textColor: Colors.white,
                    onPressed: () {
                      if (addressNameController.text.isNotEmpty &&
                          descriptionController.text.isNotEmpty &&
                          addressController.text.isNotEmpty &&
                          phoneNumberController.text.isNotEmpty &&
                          tcController.text.isNotEmpty &&
                          descriptionController.text.isNotEmpty) {
                        context.read<AddressCubit>().addAddress(
                            addressNameController.text,
                            adressType,
                            addressController.text,
                            descriptionController.text,
                            "Türkiye",
                            "Istanbul",
                            districtController.text,
                            phoneNumberController.text,
                            tcController.text,
                            LocationService.latitude,
                            LocationService.longitude);
                        Navigator.of(context)
                            .pushNamed(RouteConstant.ADDRESS_VIEW);
                      } else {
                        showDialog(
                          context: context,
                          builder: (_) => CustomAlertDialogResetPassword(
                              description:
                                  LocaleKeys.address_pop_up_text.locale,
                              onPressed: () => Navigator.of(context).pop()),
                        );
                      }
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

  // Container buildDropDown(BuildContext context, int dropdownValue) {
  //   return Container(
  //     height: context.dynamicHeight(0.06),
  //     width: double.infinity,
  //     padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.05)),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(4.0),
  //       border: Border.all(
  //         color: AppColors.borderAndDividerColor,
  //         width: 2,
  //       ),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Padding(
  //           padding: EdgeInsets.only(
  //             top: context.dynamicHeight(0.01),
  //           ),
  //           child: LocaleText(
  //             text: LocaleKeys.address_address_type,
  //             style: AppTextStyles.subTitleStyle,
  //           ),
  //         ),
  //         Expanded(
  //           child: DropdownButton<int>(
  //             isExpanded: true,
  //             underline: Text(""),
  //             value: dropdownValue,
  //             icon: Padding(
  //               padding: EdgeInsets.only(left: 100),
  //               child: const Icon(Icons.keyboard_arrow_down),
  //             ),
  //             iconSize: 17,
  //             style: AppTextStyles.myInformationBodyTextStyle,
  //             onChanged: (int? newValue) {
  //               setState(() {
  //                 dropdownValue = newValue!;
  //               });
  //             },
  //             items: <int>[1, 2].map<DropdownMenuItem<int>>((int value) {
  //               return DropdownMenuItem<int>(
  //                 value: value,
  //                 child: AutoSizeText(
  //                   value == 1
  //                       ? LocaleKeys.address_addresss.locale
  //                       : LocaleKeys.address_billing_address.locale,
  //                   style: AppTextStyles.myInformationBodyTextStyle,
  //                   maxLines: 1,
  //                 ),
  //               );
  //             }).toList(),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Container buildTextFormField(
      String labelText, TextEditingController controller) {
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
          controller == phoneNumberController || controller == tcController
              ? FilteringTextInputFormatter.digitsOnly
              : FilteringTextInputFormatter.singleLineFormatter,
        ],
        controller: controller,
        decoration: InputDecoration(
            // isDense: true,
            contentPadding: EdgeInsets.symmetric(
                horizontal: context.dynamicWidht(0.05), vertical: 0),
            labelText: labelText,
            labelStyle: AppTextStyles.bodyTextStyle,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            border: InputBorder.none),
      ),
    );
  }
}
