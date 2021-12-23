import 'package:flutter/material.dart';
import '../../../utils/constants/image_constant.dart';
import '../../../utils/constants/route_constant.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/scaffold/custom_scaffold.dart';
import '../../widgets/text/locale_text.dart';
import '../surprise_pack_view/components/custom_alert_dialog.dart';
import 'components/my_registered_cards_list_tile.dart';

class MyRegisteredCardsView extends StatefulWidget {
  @override
  State<MyRegisteredCardsView> createState() => _MyRegisteredCardsViewState();
}

class _MyRegisteredCardsViewState extends State<MyRegisteredCardsView> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: LocaleKeys.registered_cards_title,
      body: Padding(
        padding: EdgeInsets.only(
          top: context.dynamicHeight(0.02),
          bottom: context.dynamicHeight(0.04),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildList(context),
            Spacer(),
            buildButton(context),
          ],
        ),
      ),
    );
  }

  Container buildList(BuildContext context) {
    return Container(
      height: context.dynamicHeight(0.6),
      // padding: EdgeInsets.only(
      //   top: context.dynamicHeight(0.01),
      // ),
      child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            return Dismissible(
              direction: DismissDirection.endToStart,
              key: UniqueKey(),
              child: MyRegisteredCardsListTile(
                onTap: () {
                  setState(() {});
                },
                title: "İş Bankası Kartım",
                subtitleBold: "492134******3434",
              ),
              background: Padding(
                padding: EdgeInsets.only(left: context.dynamicWidht(0.65)),
                child: Container(
                  color: AppColors.redColor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: context.dynamicHeight(0.038),
                        horizontal: context.dynamicWidht(0.058)),
                    child: LocaleText(
                      text: LocaleKeys.my_notifications_delete_text_text,
                      style: AppTextStyles.bodyTextStyle.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      alignment: TextAlign.end,
                    ),
                  ),
                ),
              ),
              confirmDismiss: (DismissDirection direction) {
                return showDialog(
                  context: context,
                  builder: (_) => CustomAlertDialog(
                      textMessage:
                          LocaleKeys.registered_cards_delete_alert_dialog_text,
                      buttonOneTitle: LocaleKeys.payment_payment_cancel,
                      buttonTwoTittle: LocaleKeys.address_address_approval,
                      imagePath: ImageConstant.COMMONS_APP_BAR_LOGO,
                      onPressedOne: () {
                        Navigator.of(context).pop();
                      },
                      onPressedTwo: () {}),
                );
              },
            );
          }),
    );
  }

  Padding buildButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: context.dynamicWidht(0.06), right: context.dynamicWidht(0.06)),
      child: CustomButton(
        width: double.infinity,
        title: LocaleKeys.registered_cards_button,
        color: AppColors.greenColor,
        borderColor: AppColors.greenColor,
        textColor: Colors.white,
        onPressed: () async {
          Navigator.pushNamed(
              context, RouteConstant.MY_REGISTERED_CARD_UPDATE_VIEW);
        },
      ),
    );
  }
}
