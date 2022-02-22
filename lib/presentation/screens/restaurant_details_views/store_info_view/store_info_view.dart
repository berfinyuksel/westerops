import 'package:dongu_mobile/utils/extensions/string_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';

import '../../../../data/model/search_store.dart';
import 'package:flutter/material.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/scaffold/custom_scaffold.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StoreInfoView extends StatefulWidget {
  final SearchStore? restaurant;
  const StoreInfoView({Key? key, this.restaurant}) : super(key: key);

  @override
  _StoreInfoViewState createState() => _StoreInfoViewState();
}

class _StoreInfoViewState extends State<StoreInfoView> {
  @override
  Widget build(BuildContext context) {
    var title = <String>[
      LocaleKeys.restaurant_detail_store_info_restaurant_name.locale,
      LocaleKeys.restaurant_detail_store_info_restaurant_address.locale,
      LocaleKeys.restaurant_detail_store_info_website_address.locale,
      LocaleKeys.restaurant_detail_store_info_email.locale,
      LocaleKeys.restaurant_detail_store_info_restaurant_phone_number.locale,
      LocaleKeys.restaurant_detail_store_info_restaurant_phone_number2.locale,
    ];
    var info = <String>[
      widget.restaurant!.name.toString(),
      widget.restaurant!.address.toString() +
          ", " +
          widget.restaurant!.address.toString(),
      widget.restaurant!.websiteLink.toString(),
      widget.restaurant!.email.toString(),
      widget.restaurant!.phoneNumber.toString(),
      widget.restaurant!.phoneNumber2.toString(),
    ];

    return CustomScaffold(
      title: LocaleKeys.restaurant_detail_store_info_title,
      body: Padding(
        padding: EdgeInsets.only(top: 20.h),
        child: Column(
          children: [
            Expanded(
              child: aboutWorkingHoursListViewBuilder(info, title),
            )
          ],
        ),
      ),
    );
  }

  ListView aboutWorkingHoursListViewBuilder(
      List<String> items, List<String> title) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: 26.w,
            ),
            decoration: BoxDecoration(color: Colors.white),
            child: ListTile(
              title: Text(
                "${title[index]}",
                style: AppTextStyles.subTitleStyle
                    .copyWith(fontWeight: FontWeight.normal),
                textAlign: TextAlign.start,
              ),
              subtitle: Text(
                "${items[index]}",
                style: AppTextStyles.bodyTextStyle
                    .copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
          );
        });
  }
}
