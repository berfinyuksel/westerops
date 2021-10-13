import 'package:flutter/material.dart';

import '../../../../../utils/extensions/context_extension.dart';
import '../../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../../widgets/text/locale_text.dart';

class GetItAddressListTile extends StatelessWidget {
  final String? restaurantName;
  final String? address;

  const GetItAddressListTile({
    Key? key,
    this.restaurantName,
    this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
      ),
      tileColor: Colors.white,
      title: LocaleText(
        text: restaurantName,
        style: AppTextStyles.myInformationBodyTextStyle,
      ),
      subtitle: Text(
        address!,
        style: AppTextStyles.subTitleStyle,
      ),
    );
  }
}
