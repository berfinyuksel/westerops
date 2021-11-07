import 'package:dongu_mobile/data/model/search_store.dart';
import 'package:flutter/material.dart';

import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/scaffold/custom_scaffold.dart';
import '../../../widgets/text/locale_text.dart';

class AboutWorkingHourView extends StatefulWidget {
  final SearchStore? restaurant;

  const AboutWorkingHourView({Key? key, this.restaurant}) : super(key: key);

  @override
  _AboutWorkingHourViewState createState() => _AboutWorkingHourViewState();
}

class _AboutWorkingHourViewState extends State<AboutWorkingHourView> {
  @override
  Widget build(BuildContext context) {
    List<String> dateOfNow =
        DateTime.now().toIso8601String().split("T").toList();
    String? dateOfNowStringCalendar;
    print(dateOfNow);
    for (var i = 0; i < widget.restaurant!.calendar!.length; i++) {
      List<String> listOfStoreCalendar =
          widget.restaurant!.calendar![i].startDate!.split("T").toList();
      if (listOfStoreCalendar[0] == dateOfNow[0]) {
        dateOfNowStringCalendar = listOfStoreCalendar[0];
      }
    }

    var days = <String>[
      "Pazartesi",
      "Salı",
      "Çarşamba",
      "Perşembe",
      "Cuma",
      "Cumartesi",
      "Pazar"
    ];
    var date = <String>[
      "15 Mart 2021",
      "16 Mart 2021",
      "17 Mart 2021",
      "18 Mart 2021",
      "19 Mart 2021",
      "20 Mart 2021",
      "21 Mart 2021"
    ];
    var clocks = <String>[
      "12.00 - 03.00",
      "12.00 - 03.00",
      "12.00 - 03.00",
      "12.00 - 03.00",
      "Kapalı",
      "12.00 - 03.00",
      "12.00 - 03.00",
    ];

    return CustomScaffold(
      title: "Çalışma Saatleri",
      body: Padding(
        padding: EdgeInsets.only(top: context.dynamicHeight(0.02)),
        child: Column(
          children: [
            Expanded(
              child: aboutWorkingHoursListViewBuilder(
                  days, date, clocks, dateOfNowStringCalendar),
            )
          ],
        ),
      ),
    );
  }

  ListView aboutWorkingHoursListViewBuilder(List<String> items,
      List<String> date, List<String> clock, String? dateOfNowStringCalendar) {
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
                text: dateOfNowStringCalendar,
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
              trailing: Column(
                children: [
                  SizedBox(
                    height: context.dynamicHeight(0.03),
                  ),
                  LocaleText(
                    text: "${clock[index]}",
                    style: AppTextStyles.bodyTextStyle
                        .copyWith(fontWeight: FontWeight.bold),
                    alignment: TextAlign.start,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
