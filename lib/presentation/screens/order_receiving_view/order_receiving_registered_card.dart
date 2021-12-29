import 'dart:async';
import 'dart:developer';
import 'package:dongu_mobile/data/model/iyzico_card_model/iyzico_order_model.dart';
import 'package:dongu_mobile/data/model/order_received.dart';
import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';
import 'package:dongu_mobile/logic/cubits/iyzico_card_cubit/iyzico_card_cubit.dart';
import 'package:dongu_mobile/logic/cubits/iyzico_send_request_cubit.dart/iyzico_send_request_cubit.dart';
import 'package:dongu_mobile/presentation/screens/forgot_password_view/components/popup_reset_password.dart';
import 'package:dongu_mobile/presentation/screens/order_receiving_view/components/payment_inquiry_starter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dongu_mobile/logic/cubits/order_cubit/order_received_cubit.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/constants/image_constant.dart';
import '../../../utils/constants/route_constant.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/text/locale_text.dart';

class OrderReceivingViewWithRegisteredCard extends StatefulWidget {
  @override
  _OrderReceivingViewWithRegisteredCardState createState() =>
      _OrderReceivingViewWithRegisteredCardState();
}

class _OrderReceivingViewWithRegisteredCardState
    extends State<OrderReceivingViewWithRegisteredCard> {
  Timer? _timer;
  int counter = 0;
  bool boolForProgress = false;

  @override
  void initState() {
    context.read<OrderReceivedCubit>().getOrder();
    _timer = Timer.periodic(
        Duration(seconds: 5), (Timer timer) => requesForOrderResponse());
    super.initState();
  }

  Future<void> sleep() async {
    await Future.delayed(Duration(seconds: 5));
    Navigator.pushReplacementNamed(context, RouteConstant.ORDER_RECEIVED_VIEW);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: AppColors.scaffoldBackgroundColor,
            child: SvgPicture.asset(ImageConstant.ORDER_RECEIVING_BACKGROUND),
          ),
          Center(
            child: Column(
              children: [
                Spacer(
                  flex: 201,
                ),
                SvgPicture.asset(ImageConstant.ORDER_RECEIVING_DONGU_LOGO),
                Spacer(
                  flex: 129,
                ),
                SvgPicture.asset(ImageConstant.ORDER_RECEIVING_PACKAGE_ICON),
                Spacer(
                  flex: 183,
                ),
                Builder(builder: (context) {
                  final state = context.watch<OrderReceivedCubit>().state;
                  if (state is GenericInitial) {
                    log("initial");
                    return Container();
                  } else if (state is GenericLoading) {
                    log("loading");
                    return Center(child: CircularProgressIndicator());
                  } else if (state is GenericCompleted) {
                    List<IyzcoOrderCreate> orderInfo = [];
                    for (int i = 0; i < state.response.length; i++) {
                      orderInfo.add(state.response[i]);
                    }
                    return PaymentInquiryStarter(
                        conversationId:
                            state.response.first.refCode.toString());
                  } else {
                    final error = state as GenericError;
                    if (error.statusCode == "500") {
                      print(error.message);
                      String errorMessage = error.message;
                      return Center(
                        child: CustomAlertDialogResetPassword(
                          description:
                              "${errorMessage == "{\"error\"\:\"Ãdeme AlÄ±namadÄ±\"}" ? "Ödeme Alınamadı" : ""}",
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(RouteConstant.CUSTOM_SCAFFOLD);
                          },
                        ),
                      );
                    }
                    return Center(
                        child: Text("${error.message}\n${error.statusCode}"));
                  }
                }),
                Spacer(
                  flex: 197,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  requesForOrderResponse() {
    if (counter == 11) {
      _timer?.cancel();
      return showDialog(
        context: context,
        builder: (_) => Center(
          child: CustomAlertDialogResetPassword(
            description: "Üzgünüz bir şeyler ters gitti.",
            onPressed: () {
              Navigator.of(context).pushNamed(RouteConstant.CUSTOM_SCAFFOLD);
            },
          ),
        ),
      );
    } else if (boolForProgress) {
      _timer?.cancel();
    }
    log(counter.toString());
    counter++;
  }

  navigateToOrderReceivedView(List<OrderReceived> orderInfoA) {
    Navigator.pushReplacementNamed(context, RouteConstant.ORDER_RECEIVED_VIEW,
        arguments: orderInfoA);
  }
}
