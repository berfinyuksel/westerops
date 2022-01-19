import 'dart:async';
import 'dart:developer';

import 'package:dongu_mobile/data/model/order_received.dart';
import 'package:dongu_mobile/data/services/local_notifications/local_notifications_service/local_notifications_service.dart';
import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';
import 'package:dongu_mobile/logic/cubits/iyzico_send_request_cubit.dart/iyzico_send_request_cubit.dart';
import 'package:dongu_mobile/presentation/screens/forgot_password_view/components/popup_reset_password.dart';
import 'package:dongu_mobile/presentation/widgets/button/custom_button.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
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
  Timer? _timer;
  int counter = 0;

  @override
  void initState() {
    _timer = Timer.periodic(
        Duration(seconds: 5), (Timer timer) => requesForOrderResponse());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (boolForProgress) {
      _timer?.cancel();
    }
    print("text widget builded");
    context
        .read<SendRequestCubit>()
        .sendRequest(conversationId: widget.conversationId!);
    return Builder(builder: (context) {
      final state = context.watch<SendRequestCubit>().state;
      print("builder activated");

      if (state is GenericInitial) {
        print("initial");
        return Container();
      } else if (state is GenericLoading) {
        print("loading");
        return Center(
          child: Column(
            children: [
              LocaleText(
                text: "Ödeme Bekleniyor",
                style: AppTextStyles.headlineStyle,
              ),
              SizedBox(height: context.dynamicHeight(0.05)),
              CircularProgressIndicator(
                color: AppColors.greenColor,
              ),
            ],
          ),
        );

      } else if (state is GenericCompleted) {
        _timer!.cancel();

        print("completed");
        List<OrderReceived> orderInfo = [];

        if (state.response.isNotEmpty) {
          boolForProgress = true;
          print("orderinfo is not empty");
          for (int i = 0; i < state.response.length; i++) {
            orderInfo.add(state.response[i]);
          }
          navigateToOrderReceivedView(orderInfo.first);
          return LocaleText(
            text: LocaleKeys.order_received_headline1,
            style: AppTextStyles.headlineStyle,
          );
        } else {
          boolForProgress = true;

          print("no change status");
          return LocaleText(
            text: LocaleKeys.order_received_headline1,
            style: AppTextStyles.headlineStyle,
          );
        }
      } else {
        final error = state as GenericError;
        if (error.statusCode == "500") {
          _timer!.cancel();
          boolForProgress = true;

          return Column(
            children: [
              LocaleText(
                text: "Ödeme Alınamadı",
                style: AppTextStyles.headlineStyle,
              ),
              SizedBox(height: context.dynamicHeight(0.05)),
              CustomButton(
                title: "Ana Sayfa",
                color: AppColors.greenColor,
                textColor: AppColors.appBarColor,
                width: context.dynamicWidht(0.28),
                borderColor: AppColors.greenColor,
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(RouteConstant.CUSTOM_SCAFFOLD);
                },
              ),
            ],
          );
        } else if (error.statusCode == "404") {
          return Column(
            children: [
              LocaleText(
                text: "Ödeme Bekleniyor",
                style: AppTextStyles.headlineStyle,
              ),
              SizedBox(height: context.dynamicHeight(0.05)),
              CircularProgressIndicator(
                color: AppColors.greenColor,
              ),
            ],
          );
        } else if (error.statusCode == "400") {
          _timer!.cancel();
          boolForProgress = true;

          return Column(
            children: [
              LocaleText(
                text: "Ödeme Alınamadı",
                style: AppTextStyles.headlineStyle,
              ),
              SizedBox(height: context.dynamicHeight(0.05)),
              CustomButton(
                title: "Ana Sayfa",
                color: AppColors.greenColor,
                textColor: AppColors.appBarColor,
                width: context.dynamicWidht(0.28),
                borderColor: AppColors.greenColor,
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(RouteConstant.CUSTOM_SCAFFOLD);
                },
              ),
            ],
          );
        }
        return Center(child: Text("${error.message}\n${error.statusCode}"));
      }
    });
  }

  navigateToOrderReceivedView(OrderReceived orderInfoA) {
    boolForProgress = true;
    _timer?.cancel();
    NotificationService().gotOrder();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Navigator.of(context).pushNamed(RouteConstant.ORDER_RECEIVED_VIEW);
    });
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
}
