import 'package:dongu_mobile/data/model/iyzico_card_model/iyzico_order_model.dart';

import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';

import 'package:dongu_mobile/presentation/screens/order_receiving_view/components/payment_inquiry_starter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dongu_mobile/logic/cubits/order_cubit/order_received_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/constants/image_constant.dart';

import '../../../utils/theme/app_colors/app_colors.dart';

class OrderReceivingViewWithRegisteredCard extends StatefulWidget {
  @override
  _OrderReceivingViewWithRegisteredCardState createState() =>
      _OrderReceivingViewWithRegisteredCardState();
}

class _OrderReceivingViewWithRegisteredCardState
    extends State<OrderReceivingViewWithRegisteredCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("received page builded");
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
                    print("initial");
                    return Container();
                  } else if (state is GenericLoading) {
                    print("loading");
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
}
