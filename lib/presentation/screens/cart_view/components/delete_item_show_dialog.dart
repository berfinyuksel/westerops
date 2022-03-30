import 'package:flutter/material.dart';

import '../../../../utils/constants/image_constant.dart';
import '../../../../utils/locale_keys.g.dart';
import '../../surprise_pack_view/components/custom_alert_dialog.dart';



  Future<bool?> deleteItemShowDialog(BuildContext context, void Function()? onPressedDelete) async {
    return showDialog(
      context: context,
      builder: (_) => CustomAlertDialog(
          textMessage: LocaleKeys.cart_box_delete_alert_dialog,
          buttonOneTitle: LocaleKeys.payment_payment_cancel,
          buttonTwoTittle: LocaleKeys.address_address_approval,
          imagePath: ImageConstant.SURPRISE_PACK_ALERT,
          onPressedOne: () {
            Navigator.of(context).pop();
          },
          onPressedTwo: onPressedDelete)
    );
  }


  
