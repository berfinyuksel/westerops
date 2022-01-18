

import 'package:dongu_mobile/data/model/iyzico_card_model/iyzico_order_model.dart';
import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';
import 'package:dongu_mobile/logic/cubits/order_cubit/order_received_cubit.dart';

import 'package:dongu_mobile/presentation/screens/order_receiving_view/components/payment_inquiry_starter.dart';
import 'package:dongu_mobile/presentation/widgets/button/custom_button.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/constants/image_constant.dart';
import '../../../utils/constants/route_constant.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/text/locale_text.dart';

class OrderReceivingViewWithout3D extends StatefulWidget {
  @override
  _OrderReceivingViewWithout3DState createState() =>
      _OrderReceivingViewWithout3DState();
}

class _OrderReceivingViewWithout3DState
    extends State<OrderReceivingViewWithout3D> {
  @override
  void initState() {
    super.initState();
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
                    print("initial");
                    return Container();
                  } else if (state is GenericLoading) {
                    print("loading");
                    return Center(
                        child: CircularProgressIndicator(
                      color: AppColors.greenColor,
                    ));
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
                    if (error.statusCode == "400") {
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
