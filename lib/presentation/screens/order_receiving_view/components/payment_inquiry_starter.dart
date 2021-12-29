import 'dart:developer';

import 'package:dongu_mobile/data/model/order_received.dart';
import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';
import 'package:dongu_mobile/logic/cubits/iyzico_send_request_cubit.dart/iyzico_send_request_cubit.dart';
import 'package:dongu_mobile/presentation/screens/forgot_password_view/components/popup_reset_password.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentInquiryStarter extends StatefulWidget {
  final String? conversationId;
  const PaymentInquiryStarter({Key? key, required this.conversationId})
      : super(key: key);

  @override
  State<PaymentInquiryStarter> createState() => _PaymentInquiryStarterState();
}

class _PaymentInquiryStarterState extends State<PaymentInquiryStarter> {
  bool boolForProgress = false;

  @override
  void initState() {
    context
        .read<SendRequestCubit>()
        .sendRequest(conversationId: widget.conversationId!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final state = context.watch<SendRequestCubit>().state;
      print("asadasda");

      if (state is GenericInitial) {
        log("initial");
        return Container();
      } else if (state is GenericLoading) {
        log("loading");
        return Center(child: CircularProgressIndicator());
      } else if (state is GenericCompleted) {
        log("completed");
        List<OrderReceived> orderInfo = [];

        if (state.response.isNotEmpty) {
          boolForProgress = true;
          log("orderinfo is not empty");
          for (int i = 0; i < state.response.length; i++) {
            orderInfo.add(state.response[i]);
          }
          return navigateToOrderReceivedView(orderInfo);
        } else {
          log("no change status");
          return LocaleText(
            text: LocaleKeys.order_received_headline1,
            style: AppTextStyles.headlineStyle,
          );
        }
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
                Navigator.of(context).pushNamed(RouteConstant.CUSTOM_SCAFFOLD);
              },
            ),
          );
        }
        return Center(child: Text("${error.message}\n${error.statusCode}"));
      }
    });
  }

  navigateToOrderReceivedView(List<OrderReceived> orderInfoA) {
    Navigator.pushReplacementNamed(context, RouteConstant.ORDER_RECEIVED_VIEW,
        arguments: orderInfoA);
  }
}
