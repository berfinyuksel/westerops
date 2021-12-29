import 'dart:async';
import 'dart:developer';

import 'package:dongu_mobile/data/model/order_received.dart';
import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';
import 'package:dongu_mobile/logic/cubits/iyzico_send_request_cubit.dart/iyzico_send_request_cubit.dart';
import 'package:dongu_mobile/presentation/screens/forgot_password_view/components/popup_reset_password.dart';
import 'package:dongu_mobile/presentation/widgets/button/custom_button.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/constants/image_constant.dart';
import '../../../utils/constants/route_constant.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/text/locale_text.dart';

class OrderReceivingViewWith3D extends StatefulWidget {
  @override
  _OrderReceivingViewWith3DState createState() =>
      _OrderReceivingViewWith3DState();
}

class _OrderReceivingViewWith3DState extends State<OrderReceivingViewWith3D> {
  Timer? _timer;
  bool boolForProgress = false;

  int counter = 0;
  @override
  void initState() {
    _timer = Timer.periodic(
        Duration(seconds: 5), (Timer timer) => requesForOrderResponse());
    log(SharedPrefs.getConversationId);
    print(SharedPrefs.getIpV4);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("orderreceiving init state request");
    context
        .read<SendRequestCubit>()
        .sendRequest(conversationId: SharedPrefs.getConversationId);
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
                  print("asadasda");
                  final state = context.watch<SendRequestCubit>().state;
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
                    List<OrderReceived> orderInfo = [];

                    print("completed");
                    if (state.response.isNotEmpty) {
                      boolForProgress = true;
                      print("orderinfo is not empty");
                      for (int i = 0; i < state.response.length; i++) {
                        orderInfo.add(state.response[i]);
                      }
                      print(orderInfo.length);
                      navigateToOrderReceivedView(orderInfo.first);
                      return LocaleText(
                        text: LocaleKeys.order_received_headline1,
                        style: AppTextStyles.headlineStyle,
                      );
                    } else {
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
                      print("error message");
                      print(error.message);
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
                      print("ödeme bekleniyor");
                      print(error.message);
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
    setState(() {});
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

  navigateToOrderReceivedView(OrderReceived orderInfoA) {
    print(orderInfoA);
    _timer?.cancel();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Navigator.of(context).pushNamed(RouteConstant.ORDER_RECEIVED_VIEW);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
