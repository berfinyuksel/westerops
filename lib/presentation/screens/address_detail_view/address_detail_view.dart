import 'package:dongu_mobile/presentation/screens/forgot_password_view/components/popup_reset_password.dart';
import 'package:dongu_mobile/utils/extensions/string_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/model/user_address.dart';
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
  final String? title;
  final String? district;
  final Result? list;
  final String? address;
  const AddressDetailView({
    Key? key,
    this.title,
    this.district,
    this.address,
    this.list,
  }) : super(key: key);
  @override
  _AddressDetailViewState createState() => _AddressDetailViewState();
}

class _AddressDetailViewState extends State<AddressDetailView> {
  int adressType = 1;
  TextEditingController addressNameController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  FocusNode addressNameFocusNode = FocusNode();
  FocusNode districtFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();
  FocusNode phoneNumberFocusNode = FocusNode();
  bool nextFocusTc = false;
  int counter = 0;

  @override
  void initState() {
    super.initState();

    if (widget.list != null) {
      districtController.text = widget.list!.province ?? "";
      phoneNumberController.text = "${widget.list!.phoneNumber ?? ""}";
      addressController.text = widget.list!.address ?? "";
      addressNameController.text = widget.list!.name ?? "";
      descriptionController.text = widget.list!.description ?? "";
    } else {
      districtController.text = widget.district ?? "";
      addressController.text = widget.address ?? "";
      phoneNumberController.text = '+90';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: CustomScaffold(
        resizeToAvoidBottomInset: true,
        title: widget.title,
        body: Padding(
          padding: EdgeInsets.only(
            left: 28.w,
            right: 28.w,
            top: 20.h,
            bottom: 30.h,
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    height: 500.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.address_addresss.locale,
                          style: AppTextStyles.bodyTitleStyle,
                        ),
                        Spacer(flex: 5),
                        // buildDropDown(context, adressType),
                        // Spacer(flex: 10),
                        buildTextFormField(
                          LocaleKeys.address_address_name.locale,
                          addressNameController,
                          addressNameFocusNode,
                        ),
                        addressNameController.text.isEmpty && counter > 0
                            ? buildValidatorText(addressNameController)
                            : SizedBox(),
                        Spacer(flex: 10),
                        buildTextFormField(
                          LocaleKeys.address_district.locale,
                          districtController,
                          districtFocusNode,
                        ),
                        districtController.text.isEmpty && counter > 0
                            ? buildValidatorText(districtController)
                            : SizedBox(),
                        Spacer(flex: 10),
                        buildTextFormField(
                          LocaleKeys.address_addresss.locale,
                          addressController,
                          addressFocusNode,
                        ),
                        addressController.text.isEmpty && counter > 0
                            ? buildValidatorText(addressController)
                            : SizedBox(),
                        Spacer(flex: 10),
                        buildTextFormField(
                          LocaleKeys.address_address_description.locale,
                          descriptionController,
                          descriptionFocusNode,
                        ),
                        descriptionController.text.isEmpty && counter > 0
                            ? buildValidatorText(descriptionController)
                            : SizedBox(),
                        Spacer(flex: 10),
                        buildTextFormField(
                          LocaleKeys.address_phone_number.locale,
                          phoneNumberController,
                          phoneNumberFocusNode,
                        ),
                        phoneNumberController.text.isEmpty && counter > 0
                            ? buildValidatorText(phoneNumberController)
                            : SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
              CustomButton(
                width: double.infinity,
                title: LocaleKeys.address_save,
                color: AppColors.greenColor,
                borderColor: AppColors.greenColor,
                textColor: Colors.white,
                onPressed: () {
                  counter++;
                  if (addressNameController.text.isNotEmpty &&
                      descriptionController.text.isNotEmpty &&
                      addressController.text.isNotEmpty &&
                      phoneNumberController.text.isNotEmpty &&
                      phoneNumberController.value.text.length >= 11 &&
                      descriptionController.text.isNotEmpty) {
                    if (widget.list != null) {
                      context.read<AddressCubit>().updateAddress(
                          widget.list!.id!,
                          addressNameController.text,
                          adressType,
                          addressController.text,
                          descriptionController.text,
                          widget.list!.country!,
                          districtController.text,
                          widget.list!.province!,
                          phoneNumberController.text,
                          widget.list!.tcknVkn!,
                          widget.list!.latitude!,
                          widget.list!.longitude!);
                    } else {
                      context.read<AddressCubit>().addAddress(
                          addressNameController.text,
                          adressType,
                          addressController.text,
                          descriptionController.text,
                          "Türkiye",
                          "Istanbul",
                          districtController.text,
                          phoneNumberController.text,
                          '',
                          LocationService.latitude,
                          LocationService.longitude);
                    }

                    Navigator.of(context).pushNamedAndRemoveUntil(
                        RouteConstant.CUSTOM_SCAFFOLD,
                        (Route<dynamic> route) => false);
                  } else {
                    showDialog(
                      context: context,
                      builder: (_) => CustomAlertDialogResetPassword(
                          description: phoneNumberController.text.length < 11
                              ? LocaleKeys.address_pop_up_phone.locale
                              : LocaleKeys.address_pop_up_text.locale,
                          onPressed: () => Navigator.of(context).pop()),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildValidatorText(TextEditingController textController) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: LocaleText(
        text: _errorText(textController)!,
        style: AppTextStyles.bodyTextStyle
            .copyWith(color: Colors.red, fontSize: 12),
      ),
    );
  }

  String? _errorText(TextEditingController _controller) {
    final text = _controller.value.text;

    if (text.isEmpty) {
      return 'Bu alan boş bırakılamaz';
    }
    return null;
  }

  Container buildTextFormField(
    String labelText,
    TextEditingController controller,
    FocusNode focusNode,
  ) {
    return Container(
      height:
          controller == descriptionController || controller == addressController
              ? 100.h
              : 56.h,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderAndDividerColor, width: 2),
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.white,
      ),
      child: TextFormField(
        focusNode: focusNode,
        onChanged: (value) {
          if (phoneNumberController.text.length == 13 &&
              phoneNumberFocusNode.hasFocus) {
            phoneNumberFocusNode.unfocus();
          }
          setState(() {});
        },
        inputFormatters: [
          controller == phoneNumberController
              ? LengthLimitingTextInputFormatter(13)
              : LengthLimitingTextInputFormatter(99),
        ],
        maxLines: controller == descriptionController ||
                controller == addressController
            ? context.dynamicHeight(0.11).toInt()
            : null,
        cursorColor: AppColors.cursorColor,
        style: AppTextStyles.myInformationBodyTextStyle,
        /* inputFormatters: [
          controller == phoneNumberController || controller == tcController
              ? FilteringTextInputFormatter.digitsOnly
              : FilteringTextInputFormatter.singleLineFormatter,
        ], */
        keyboardType: controller == phoneNumberController
            ? TextInputType.number
            : TextInputType.text,
        controller: controller,
        decoration: InputDecoration(
          // isDense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 10.h,
          ),
          labelText: labelText,
          labelStyle: AppTextStyles.bodyTextStyle,
          // enabledBorder: InputBorder.none,
          // focusedBorder: InputBorder.none,
          // border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: controller.text.isEmpty && counter > 0
                    ? Colors.red
                    : AppColors.borderAndDividerColor,
                width: 1),
            borderRadius: BorderRadius.circular(4.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: AppColors.borderAndDividerColor, width: 1),
            borderRadius: BorderRadius.circular(4.0),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(),
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        textInputAction: TextInputAction.next,
      ),
    );
  }

  @override
  void dispose() {
    addressNameController.dispose();
    districtController.dispose();
    addressController.dispose();
    descriptionController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }
}
