import 'package:dongu_mobile/data/model/iyzico_card_model/iyzico_registered_card.dart';
import 'package:dongu_mobile/data/repositories/iyzico_repositories/iyzico_card_repository.dart';
import 'package:dongu_mobile/data/services/locator.dart';
import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';
import 'package:dongu_mobile/logic/cubits/iyzico_card_cubit/iyzico_card_cubit.dart';
import 'package:dongu_mobile/presentation/screens/forgot_password_view/components/popup_reset_password.dart';
import 'package:dongu_mobile/presentation/widgets/circular_progress_indicator/custom_circular_progress_indicator.dart';
import 'package:dongu_mobile/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';

class MyRegisteredCardsView extends StatefulWidget {
  @override
  State<MyRegisteredCardsView> createState() => _MyRegisteredCardsViewState();
}

class _MyRegisteredCardsViewState extends State<MyRegisteredCardsView> {
  @override
  void initState() {
    context.read<IyzicoCardCubit>().getCards();
    super.initState();
  }

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
      child: Builder(builder: (context) {
        final GenericState state = context.watch<IyzicoCardCubit>().state;

        if (state is GenericInitial) {
          return Container();
        } else if (state is GenericLoading) {
          return Center(child: CustomCircularProgressIndicator());
        } else if (state is GenericCompleted) {
          List<IyzcoRegisteredCard> cards = [];

          for (int i = 0; i < state.response.length; i++) {
            cards.add(state.response[i]);
          }

          return cards.isEmpty
              ? buildNoCardWidget()
              : buildRegisteredCards(cards.first.cardDetails!);
        } else {
          final error = state as GenericError;
          if (error.statusCode == "502") {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  SvgPicture.asset(ImageConstant.SURPRISE_PACK_ALERT),
                  SizedBox(
                    height: 20,
                  ),
                  LocaleText(
                    alignment: TextAlign.center,
                    text: "Üzgünüz. Kart bilgilerine ulaşamıyoruz.",
                    style: AppTextStyles.myInformationBodyTextStyle,
                  ),
                ],
              ),
            );
          }
          return Center(child: Text("${error.message}\n${error.statusCode}"));
        }
      }),
    );
  }

  Widget buildRegisteredCards(List<CardDetail> cards) {
    return cards.isNotEmpty
        ? ListView.builder(
            itemCount: cards.length,
            itemBuilder: (context, index) {
              return Dismissible(
                direction: DismissDirection.endToStart,
                key: UniqueKey(),
                child: MyRegisteredCardsListTile(
                  onTap: () {
                    setState(() {});
                  },
                  title: cards[index].cardAlias,
                  subtitleBold:
                      "${cards[index].binNumber!.replaceRange(4, 6, "*")}****${cards[index].lastFourDigits!.replaceRange(0, 2, "*")}",
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
                        textMessage: LocaleKeys
                            .registered_cards_delete_alert_dialog_text,
                        buttonOneTitle: LocaleKeys.payment_payment_cancel,
                        buttonTwoTittle: LocaleKeys.address_address_approval,
                        imagePath: ImageConstant.COMMONS_APP_BAR_LOGO,
                        onPressedOne: () {
                          Navigator.of(context).pop();
                        },
                        onPressedTwo: () async {
                          Navigator.of(context).pop();
                          StatusCode statusCode =
                              await sl<IyzicoCardRepository>().deleteCard(
                                  cards[index].cardToken.toString());
                          switch (statusCode) {
                            case StatusCode.success:
                              showDialog(
                                  context: context,
                                  builder: (_) =>
                                      CustomAlertDialogResetPassword(
                                        description: LocaleKeys
                                            .registered_cards_delete_alert_dialog
                                            .locale,
                                        onPressed: () =>
                                            Navigator.popAndPushNamed(
                                                context,
                                                RouteConstant
                                                    .MY_REGISTERED_CARD_VIEW),
                                      ));
                              break;
                            case StatusCode.error:
                              showDialog(
                                  context: context,
                                  builder: (_) =>
                                      CustomAlertDialogResetPassword(
                                        description: LocaleKeys
                                            .registered_cards_error_alert_dialog
                                            .locale,
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                      ));
                              break;
                            case StatusCode.unauthecticated:
                              showDialog(
                                  context: context,
                                  builder: (_) =>
                                      CustomAlertDialogResetPassword(
                                        description: LocaleKeys
                                            .registered_cards_unauthorized_alert_dialog
                                            .locale,
                                        onPressed: () =>
                                            Navigator.popAndPushNamed(context,
                                                RouteConstant.LOGIN_VIEW),
                                      ));
                              break;
                            default:
                          }
                        }),
                  );
                },
              );
            })
        : Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                ),
                SvgPicture.asset(ImageConstant.SURPRISE_PACK_ALERT),
                SizedBox(
                  height: 20,
                ),
                LocaleText(
                  alignment: TextAlign.center,
                  text: "Kayıtlı kartınız bulunmamaktadır.",
                  style: AppTextStyles.myInformationBodyTextStyle,
                ),
              ],
            ),
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

  Widget buildNoCardWidget() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
          ),
          SvgPicture.asset(ImageConstant.SURPRISE_PACK_ALERT),
          SizedBox(
            height: 20,
          ),
          LocaleText(
            alignment: TextAlign.center,
            text:
                "Üzgünüz kayıtlı kartlarınızı görüntüleyemiyoruz. Tekrar deneyiniz.",
            style: AppTextStyles.myInformationBodyTextStyle,
          ),
        ],
      ),
    );
  }
}
