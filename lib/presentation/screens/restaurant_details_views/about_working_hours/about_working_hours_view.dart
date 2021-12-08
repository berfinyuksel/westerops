import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/search_store.dart';
import '../../../../logic/cubits/time_interval_cubit/time_interval_cubit.dart';
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
  void initState() {
    super.initState();
    context.read<TimeIntervalCubit>().getTimeInterval(widget.restaurant!.id!);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Çalışma Saatleri",
      body: Padding(
        padding: EdgeInsets.only(top: context.dynamicHeight(0.02)),
        child: Column(
          children: [
            Expanded(
              child: aboutWorkingHoursListViewBuilder(),
            )
          ],
        ),
      ),
    );
  }

  ListView aboutWorkingHoursListViewBuilder() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.restaurant!.calendar!.length,
        itemBuilder: (context, index) {
          print('aaaaaaaaaaa');

          DateTime startOfRes =
              DateTime.parse(widget.restaurant!.calendar![index].startDate!);
          print(startOfRes);

          DateTime endOfRes =
              DateTime.parse(widget.restaurant!.calendar![index].endDate!)
                  .toLocal();

          print(widget.restaurant!.calendar![index].endDate!);
          print(endOfRes);

          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.dynamicWidht(0.06),
            ),
            decoration: BoxDecoration(color: Colors.white),
            child: ListTile(
              title: LocaleText(
                text: buildDateFormatOfTheDay(startOfRes),
                style: AppTextStyles.subTitleStyle
                    .copyWith(fontWeight: FontWeight.normal),
                alignment: TextAlign.start,
              ),
              subtitle: LocaleText(
                text: buildWeekdayOftheDate(startOfRes),
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
                    text: buildHourForTheDate(startOfRes, startOfRes),
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

  String buildDateFormatOfTheDay(DateTime dateData) {
    int yearOfDate = dateData.year;
    int monthOfDate = dateData.month;
    int dayOfTheDate = dateData.day;
    String stringMonthOfTheDate = buildStringOfMonth(monthOfDate);
    return '$dayOfTheDate $stringMonthOfTheDate $yearOfDate';
  }

  String buildStringOfMonth(int monthOfDate) {
    switch (monthOfDate) {
      case 1:
        return LocaleKeys.restaurant_detail_working_hours_month1;
      case 2:
        return LocaleKeys.restaurant_detail_working_hours_month2;
      case 3:
        return LocaleKeys.restaurant_detail_working_hours_month3;
      case 4:
        return LocaleKeys.restaurant_detail_working_hours_month4;
      case 5:
        return LocaleKeys.restaurant_detail_working_hours_month5;
      case 6:
        return LocaleKeys.restaurant_detail_working_hours_month6;
      case 7:
        return LocaleKeys.restaurant_detail_working_hours_month7;
      case 8:
        return LocaleKeys.restaurant_detail_working_hours_month8;
      case 9:
        return LocaleKeys.restaurant_detail_working_hours_month9;
      case 10:
        return LocaleKeys.restaurant_detail_working_hours_month10;
      case 11:
        return LocaleKeys.restaurant_detail_working_hours_month11;
      case 12:
        return LocaleKeys.restaurant_detail_working_hours_month12;
      default:
        return '';
    }
  }

  String buildWeekdayOftheDate(DateTime dateTime) {
    int weekdayOfTheDate = dateTime.weekday;

    switch (weekdayOfTheDate) {
      case 1:
        return LocaleKeys.restaurant_detail_working_hours_day1;
      case 2:
        return LocaleKeys.restaurant_detail_working_hours_day2;
      case 3:
        return LocaleKeys.restaurant_detail_working_hours_day3;
      case 4:
        return LocaleKeys.restaurant_detail_working_hours_day4;
      case 5:
        return LocaleKeys.restaurant_detail_working_hours_day5;
      case 6:
        return LocaleKeys.restaurant_detail_working_hours_day6;
      case 7:
        return LocaleKeys.restaurant_detail_working_hours_day7;
      default:
        return '';
    }
  }

  String buildHourForTheDate(DateTime dateTimeOpen, DateTime dateTimeClose) {
    int hourOfOpen = dateTimeOpen.hour;
    int minuteOfOpen = dateTimeOpen.minute;
    int hourOfClose = dateTimeClose.hour;
    int minuteOfClose = dateTimeClose.minute;
    return '${hourOfOpen < 10 ? "0$hourOfOpen" : "$hourOfOpen"}:${minuteOfOpen < 10 ? "0$minuteOfOpen" : "$minuteOfOpen"} - ${hourOfClose < 10 ? "0$hourOfClose" : "$hourOfClose"}:${minuteOfClose < 10 ? "0$minuteOfClose" : "$minuteOfClose"}';
  }
}
