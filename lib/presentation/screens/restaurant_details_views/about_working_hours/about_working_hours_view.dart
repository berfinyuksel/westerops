import 'package:dongu_mobile/data/model/search_store.dart';
import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';
import 'package:dongu_mobile/logic/cubits/time_interval_cubit/time_interval_cubit.dart';
import 'package:flutter/material.dart';

import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/scaffold/custom_scaffold.dart';
import '../../../widgets/text/locale_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.dynamicWidht(0.06),
            ),
            decoration: BoxDecoration(color: Colors.white),
            child: ListTile(
              title: LocaleText(
                text: buildDateFormatOfTheDay(
                    widget.restaurant!.calendar![index].startDate!),
                style: AppTextStyles.subTitleStyle
                    .copyWith(fontWeight: FontWeight.normal),
                alignment: TextAlign.start,
              ),
              subtitle: LocaleText(
                text: buildWeekdayOftheDate(
                    widget.restaurant!.calendar![index].startDate!),
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
                    text: buildHourForTheDate(
                        widget.restaurant!.calendar![index].startDate!,
                        widget.restaurant!.calendar![index].endDate!),
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
        return 'Ocak';
      case 2:
        return 'Subat';
      case 3:
        return 'Mart';
      case 4:
        return 'Nisan';
      case 5:
        return 'Mayis';
      case 6:
        return 'Haziran';
      case 7:
        return 'Temmuz';
      case 8:
        return 'Agustos';
      case 9:
        return 'Eylul';
      case 10:
        return 'Ekim';
      case 11:
        return 'Kasim';
      case 12:
        return 'Aralik';
      default:
        return '';
    }
  }

  String buildWeekdayOftheDate(DateTime dateTime) {
    int weekdayOfTheDate = dateTime.weekday;

    switch (weekdayOfTheDate) {
      case 1:
        return 'Pazartesi';
      case 2:
        return 'Sali';
      case 3:
        return 'Carsamba';
      case 4:
        return 'Persembe';
      case 5:
        return 'Cuma';
      case 6:
        return 'Cumartesi';
      case 7:
        return 'Pazar';
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
