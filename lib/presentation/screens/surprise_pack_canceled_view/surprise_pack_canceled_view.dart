import 'package:auto_size_text/auto_size_text.dart';
import 'package:dongu_mobile/data/repositories/update_order_repository.dart';
import 'package:dongu_mobile/data/services/locator.dart';
import 'package:dongu_mobile/presentation/screens/surprise_pack_canceled_view/components/order_names_widget.dart';
import 'package:flutter/services.dart';
import '../../../data/model/order_received.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/constants/image_constant.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/extensions/string_extension.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/text/locale_text.dart';
import '../../widgets/warning_container/warning_container.dart';
import 'components/buy_button.dart';

class SurprisePackCanceled extends StatefulWidget {
  final List<OrderReceived> orderInfo;
  SurprisePackCanceled({Key? key, required this.orderInfo});
  @override
  _SurprisePackCanceledState createState() => _SurprisePackCanceledState();
}

class _SurprisePackCanceledState extends State<SurprisePackCanceled> {
  int selectedIndex = 0;
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: Color(0xFFFEEFEF),
      body: Column(
        children: [
          Spacer(
            flex: 32,
          ),
          LocaleText(
            text: LocaleKeys.surprise_pack_canceled_canceled_your_pack,
            style: AppTextStyles.appBarTitleStyle.copyWith(
                fontWeight: FontWeight.w400, color: AppColors.orangeColor),
            alignment: TextAlign.center,
          ),
          Spacer(
            flex: 8,
          ),
          buildOrderNumber(widget.orderInfo),
          Spacer(
            flex: 32,
          ),
          buildSurprisePackContainer(context, widget.orderInfo),
          Spacer(
            flex: 17,
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.06)),
            child: WarningContainer(
              text:
                  "Sürpriz Paketin iptal edildi.\nŞimdi tekrar satışta. Fikrini değiştirirsen\nacele etmelisin.",
            ),
          ),
          Spacer(
            flex: 20,
          ),
          buildBottomCard(context, widget.orderInfo)
        ],
      ),
    );
  }

  Container buildBottomCard(
      BuildContext context, List<OrderReceived> orderInfo) {
    return Container(
      width: double.infinity,
      height: context.dynamicHeight(0.52),
      padding: EdgeInsets.symmetric(
        horizontal: context.dynamicWidht(0.06),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(18.0),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          SizedBox(height: 20),
          Container(
            alignment: Alignment.center,
            height: context.dynamicHeight(0.37),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: orderInfo.first.boxes!.length,
              itemBuilder: (context, index) {
                return OrderNamesWidget(
                  box: orderInfo.first.boxes![index],
                );
              },
            ),
          ),

          /*      Divider(
            color: AppColors.borderAndDividerColor,
            thickness: 2,
            height: 0,
          ),
          Spacer(
            flex: 22,
          ), */
          /*   Column(
            children: buildRadioButtons(context),
          ), */
          /*   Spacer(
            flex: 5,
          ),
          buildTextFormField(
              'Siparisi iptal etme nedeninizi yaziniz.', textController),
          Spacer(
            flex: 20,
          ),
          buildCustomButton(orderInfo), */

          Divider(
            color: AppColors.borderAndDividerColor,
            thickness: 2,
            height: 0,
          ),
          SizedBox(
            height: context.dynamicHeight(0.03),
          ),
          LocaleText(
            text: "Tanımlanmış Paketin İptal Edildi.",
            style: GoogleFonts.montserrat(
              fontSize: 18.0,
              color: AppColors.redColor,
              fontWeight: FontWeight.w400,
            ),
            alignment: TextAlign.center,
          ),
        ],
      ),
    );
  }

  CustomButton buildCustomButton(List<OrderReceived> orderInfo) {
    return CustomButton(
      width: double.infinity,
      title: LocaleKeys.surprise_pack_canceled_button_send,
      color: Colors.transparent,
      borderColor: AppColors.greenColor,
      textColor: AppColors.greenColor,
      onPressed: () async {
        await sl<UpdateOrderRepository>()
            .cancelOrder(orderInfo.last.id!, textController.text);
      },
    );
  }

  Container buildSurprisePackContainer(
      BuildContext context, List<OrderReceived> orderInfo) {
    List<String> meals = [];
    String mealNames = "";
    if (orderInfo.last.boxes!.last.meals!.isNotEmpty) {
      for (var i = 0; i < orderInfo.last.boxes!.last.meals!.length; i++) {
        meals.add(orderInfo.last.boxes!.last.meals![i].name!);
      }
      mealNames = meals.join('\n');
    }
    return Container(
      height: context.dynamicHeight(0.1),
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.dynamicWidht(0.06),
            vertical: context.dynamicHeight(0.01)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: orderInfo.first.boxes!.length,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      orderInfo.last.boxes![index].textName.toString(),
                      style: AppTextStyles.myInformationBodyTextStyle,
                    ),
                    Spacer(),
                    BuyButton(id: orderInfo.last.boxes![index].store!.id!),
                  ],
                );
              },
            ),
            AutoSizeText(
              orderInfo.last.boxes!.last.meals!.isEmpty ? "" : mealNames,
              style: AppTextStyles.subTitleStyle,
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }

  AutoSizeText buildOrderNumber(List<OrderReceived> orderInfo) {
    return AutoSizeText.rich(
      TextSpan(
        style: AppTextStyles.bodyTextStyle,
        children: [
          TextSpan(
            text: LocaleKeys.order_received_order_number.locale,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: orderInfo.last.refCode.toString(),
            style: GoogleFonts.montserrat(
              color: AppColors.greenColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  Container buildTextFormField(
      String hintText, TextEditingController controller) {
    return Container(
      height: context.dynamicHeight(0.052),
      color: Colors.white,
      child: TextFormField(
        inputFormatters: [
          //  FilteringTextInputFormatter.deny(RegExp('[a-zA-Z0-9]'))
          FilteringTextInputFormatter.singleLineFormatter,
        ],
        cursorColor: AppColors.cursorColor,
        style: AppTextStyles.bodyTextStyle,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyles.subTitleStyle,
          enabledBorder: buildOutlineInputBorder(),
          focusedBorder: buildOutlineInputBorder(),
          border: buildOutlineInputBorder(),
        ),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.borderAndDividerColor, width: 2),
      borderRadius: BorderRadius.circular(4.0),
    );
  }

  buildRadioButtons(BuildContext context) {
    List<Widget> buttons = [];

    for (int i = 0; i < 3; i++) {
      buttons.add(
        GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = i;
            });
          },
          child: Container(
            margin: EdgeInsets.only(
              bottom: context.dynamicHeight(0.02),
            ),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    right: context.dynamicWidht(0.02),
                  ),
                  height: context.dynamicWidht(0.05),
                  width: context.dynamicWidht(0.05),
                  padding: EdgeInsets.all(
                    context.dynamicWidht(0.005),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: Colors.white,
                    border: Border.all(
                      color: Color(0xFFD1D0D0),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: selectedIndex == i
                            ? AppColors.greenColor
                            : Colors.transparent),
                  ),
                ),
                LocaleText(
                  text: "Açıklama ${i + 1}",
                  style: AppTextStyles.bodyTextStyle,
                ),
              ],
            ),
          ),
        ),
      );
    }
    return buttons;
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      shadowColor: Colors.transparent,
      leading: IconButton(
        icon: SvgPicture.asset(ImageConstant.COMMONS_CLOSE_ICON),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: SvgPicture.asset(ImageConstant.COMMONS_APP_BAR_LOGO),
      centerTitle: true,
    );
  }
}
