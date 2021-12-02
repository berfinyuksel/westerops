import '../../../../data/model/search_store.dart';
import 'package:flutter/material.dart';

import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/scaffold/custom_scaffold.dart';
import '../../../widgets/text/locale_text.dart';

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
      "İşletme Adı",
      "Adres",
      "Web Sitesi",
      "E-mail",
      "Telefon",
      "Telefon 2",
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
      title: "Mağaza Bilgileri",
      body: Padding(
        padding: EdgeInsets.only(top: context.dynamicHeight(0.02)),
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
              horizontal: context.dynamicWidht(0.06),
            ),
            decoration: BoxDecoration(color: Colors.white),
            child: ListTile(
              title: LocaleText(
                text: "${title[index]}",
                style: AppTextStyles.subTitleStyle
                    .copyWith(fontWeight: FontWeight.normal),
                alignment: TextAlign.start,
              ),
              subtitle: LocaleText(
                text: "${items[index]}",
                style: AppTextStyles.bodyTextStyle
                    .copyWith(fontWeight: FontWeight.bold),
                alignment: TextAlign.start,
              ),
            ),
          );
        });
  }
}
