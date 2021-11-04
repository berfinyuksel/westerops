import 'package:flutter/material.dart';

import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/scaffold/custom_scaffold.dart';
import '../../../widgets/text/locale_text.dart';

class StoreInfoView extends StatefulWidget {
  const StoreInfoView({Key? key}) : super(key: key);

  @override
  _StoreInfoViewState createState() => _StoreInfoViewState();
}

class _StoreInfoViewState extends State<StoreInfoView> {
  @override
  Widget build(BuildContext context) {
    var days = <String>[
      "İşletme Adı",
      "Adres",
      "Web Sitesi",
      "E-mail",
      "Telefon",
      "Telefon2",
    ];
    var date = <String>[
      "Canım Büfe",
      "Örnek Mahalle, Örnek Caddesi, Örnek Sokak\nNo:123  Beşiktaş, 340000 İstanbul",
      "ornek.com.tr",
      "ornek@ornek.com",
      "+90 212 111 11 11",
      "+90 555 555 55 55",
    ];

    return CustomScaffold(
      title: "Mağaza Bilgileri",
      body: Padding(
        padding: EdgeInsets.only(top: context.dynamicHeight(0.02)),
        child: Column(
          children: [
            Expanded(
              child: aboutWorkingHoursListViewBuilder(date, days),
            )
          ],
        ),
      ),
    );
  }

  ListView aboutWorkingHoursListViewBuilder(
      List<String> items, List<String> date) {
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
                text: "${date[index]}",
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
