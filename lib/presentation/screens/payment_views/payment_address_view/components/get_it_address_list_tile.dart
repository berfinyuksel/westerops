import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/logic/cubits/payment_cubit/payment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../utils/extensions/context_extension.dart';
import '../../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../../widgets/text/locale_text.dart';

class GetItAddressListTile extends StatelessWidget {
  final String? restaurantName;
  final String? address;
  final String? userAddressName;
  final String? userAddress;
  const GetItAddressListTile({
    Key? key,
    this.restaurantName,
    this.address,
    this.userAddressName,
    this.userAddress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final PaymentState state = context.watch<PaymentCubit>().state;

      return ListTile(
        contentPadding: EdgeInsets.only(
          left: context.dynamicWidht(0.06),
          right: context.dynamicWidht(0.06),
        ),
        tileColor: Colors.white,
        title: LocaleText(
          text: SharedPrefs.getDeliveryType == 2
              ? userAddressName
              : restaurantName,
          style: AppTextStyles.myInformationBodyTextStyle,
        ),
        subtitle: Text(
          SharedPrefs.getDeliveryType == 2 ? userAddress! : address!,
          style: AppTextStyles.subTitleStyle,
        ),
      );
    });
  }
}
