import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/locale_keys.g.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/button/custom_button.dart';
import '../../../widgets/text/locale_text.dart';
import '../../address_view/components/adress_list_tile.dart';
import 'components/get_it_address_list_tile.dart';

class PaymentAddressView extends StatefulWidget {
  final bool? isGetIt;

  const PaymentAddressView({Key? key, this.isGetIt}) : super(key: key);

  @override
  _PaymentAddressViewState createState() => _PaymentAddressViewState();
}

class _PaymentAddressViewState extends State<PaymentAddressView> {
  bool checkboxValue = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.dynamicHeight(0.57),
      child: ListView(
        children: [
          SizedBox(
            height: context.dynamicHeight(0.04),
          ),
          buildRowTitleLeftRight(
              context,
              widget.isGetIt!
                  ? LocaleKeys.payment_address_from_address
                  : LocaleKeys.payment_address_to_address,
              widget.isGetIt!
                  ? LocaleKeys.payment_address_show_on_map
                  : LocaleKeys.payment_address_change),
          SizedBox(
            height: context.dynamicHeight(0.01),
          ),
          Visibility(
            visible: widget.isGetIt!,
            child: GetItAddressListTile(
              restaurantName: "Canım Büfe",
              address: "Kuruçeşme, Muallim Cad., No:18 Beşiktaş/İstanbul",
            ),
          ),
          Visibility(
            visible: !widget.isGetIt!,
            child: Column(children: [
              AddressListTile(
                title: "Ev",
                subtitleBold: "Beşiktaş (Kuruçeşme, Muallim Cad.)",
                subtitle:
                    "\njonh.doe@mail.com\nLorem Ipsum Dolor sit amet No:5 D:5\n+90 555 555 55 55\nSüpermarketin üstü\n",
              ),
              SizedBox(
                height: context.dynamicHeight(0.02),
              ),
              buildButtonDeliveryAndBillingAddress(
                  context, LocaleKeys.payment_address_button_add_address),
              SizedBox(
                height: context.dynamicHeight(0.02),
              ),
              buildRowCheckBox(context),
            ]),
          ),
/*           SizedBox(
            height: context.dynamicHeight(0.04),
          ),
          buildRowTitleLeftRight(context, LocaleKeys.payment_address_billing_info, LocaleKeys.payment_address_change),
          SizedBox(
            height: context.dynamicHeight(0.01),
          ),
          AddressListTile(
            title: "Ev\t\t",
            subtitleBold: "Beşiktaş (Kuruçeşme, Muallim Cad.)\t\t",
            subtitle: "\njonh.doe@mail.com\t\t\nLorem Ipsum Dolor sit amet No:5 D:5\t\t\n+90 555 555 55 55\t\t\nSüpermarketin üstü\t\t", 
          ),
          SizedBox(
            height: context.dynamicHeight(0.02),
          ),
          buildButtonDeliveryAndBillingAddress(context, LocaleKeys.payment_address_button_add_bill),
             SizedBox(
            height: context.dynamicHeight(0.02),
          ), */
        ],
      ),
    );
  }

  Padding buildRowCheckBox(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: context.dynamicWidht(0.06)),
      child: Row(
        children: [
          buildCheckBox(context),
          SizedBox(width: context.dynamicWidht(0.02)),
          LocaleText(
            text: LocaleKeys.payment_address_use_as_billing,
            style: AppTextStyles.subTitleStyle,
          ),
        ],
      ),
    );
  }

  Padding buildRowTitleLeftRight(
      BuildContext context, String titleLeft, String titleRight) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LocaleText(
            text: titleLeft,
            style: AppTextStyles.bodyTitleStyle,
          ),
          GestureDetector(
            onTap: () {},
            child: LocaleText(
              text: titleRight,
              style: GoogleFonts.montserrat(
                fontSize: 12.0,
                color: AppColors.orangeColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildButtonDeliveryAndBillingAddress(
      BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
      ),
      child: CustomButton(
        width: double.infinity,
        title: title,
        color: Colors.transparent,
        borderColor: AppColors.greenColor,
        textColor: AppColors.greenColor,
        onPressed: () {},
      ),
    );
  }

  Container buildCheckBox(BuildContext context) {
    return Container(
      height: context.dynamicWidht(0.04),
      width: context.dynamicWidht(0.04),
      decoration: BoxDecoration(
        color: Colors.white,
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
