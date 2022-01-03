import 'package:dongu_mobile/data/model/results_notification.dart';
import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';
import 'package:dongu_mobile/logic/cubits/notificaiton_cubit/get_notification_cubit.dart';
import 'package:dongu_mobile/logic/cubits/notifications_counter_cubit/notifications_counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/constants/image_constant.dart';
import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/locale_keys.g.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/text/locale_text.dart';

class SpecialForMeListTileBuilder extends StatefulWidget {
  SpecialForMeListTileBuilder({Key? key}) : super(key: key);

  @override
  _SpecialForMeListTileBuilderState createState() =>
      _SpecialForMeListTileBuilderState();
}

class _SpecialForMeListTileBuilderState
    extends State<SpecialForMeListTileBuilder> {
  var value = <String>["", "", "", ""];

  @override
  Widget build(BuildContext context) {
    return buildBuilder(
      
    );
  }
@override
void initState() {
  context.read<GetNotificationCubit>().getNotification();
  super.initState();
  
}
  Builder buildBuilder() {
    return Builder(builder: (context) {
      final GenericState state = context.watch<GetNotificationCubit>().state;

      if (state is GenericInitial) {
        return Container();
      } else if (state is GenericLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (state is GenericCompleted) {
        List<Result> notifications = [];

        for (int i = 0; i < state.response.length; i++) {
          notifications.add(state.response[i]);
           context.read<NotificationsCounterCubit>().decrement();
        }

        print("STATE RESPONSE : ${state.response}");

        return Center(child: listViewBuilder(context, notifications, state));
      } else {
        final error = state as GenericError;
        return Center(child: Text("${error.message}\n${error.statusCode}"));
      }
    });
  }
  ListView listViewBuilder(
     BuildContext context,
    List<Result> notifications,
    GenericState state,
  ) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return Container(
            height: 101,
            padding: EdgeInsets.symmetric(
              horizontal: context.dynamicWidht(0.065),
            ),
            decoration: BoxDecoration(color: Colors.white),
            child: Dismissible(
                direction: DismissDirection.endToStart,
                background: Padding(
                  padding: EdgeInsets.only(left: context.dynamicWidht(0.65)),
                  child: Container(
                    color: AppColors.redColor,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: context.dynamicHeight(0.038),
                          horizontal: context.dynamicWidht(0.058)),
                      child: LocaleText(
                        text: LocaleKeys.my_notifications_delete_text_text,
                        style: AppTextStyles.bodyTextStyle.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        alignment: TextAlign.end,
                      ),
                    ),
                  ),
                ),
                key: UniqueKey(),
                onDismissed: (direction) {
                  setState(() {
                    value.removeAt(index);
                  });
                },
                child: Container(
                  padding: EdgeInsets.only(
                    top: context.dynamicHeight(0.011),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                         buildTitle(context, index)[index],
                         // buildDateTrailing(context, index)[index]
                          // LocaleText(
                          //   text: "${notifications[index].description}",
                          // ),
                            LocaleText(
                            text: "${notifications[index].date}",
                          )
                        ],
                      ),
                      Row(
                        children: [
                          buildIconsLeading(context, index, notifications)[index],
                          Expanded(
                              child: LocaleText(
                            text: "${notifications[index].message}",
                            style: AppTextStyles.bodyTextStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textColor,
                                height: 1.5),
                            alignment: TextAlign.start,
                          ))
                        ],
                      ),
                    ],
                  ),
                )),
          );
        });
  }

  buildIconsLeading(BuildContext context, index, List<Result> notifications ) {
    List<Widget> containerIcon = [];
    List<Widget> icons = [
      SvgPicture.asset(ImageConstant.NOTIFICATIONS_DISCOUNT_50_ICON),
      SvgPicture.asset(ImageConstant.NOTIFICATIONS_DISCOUNT_70_ICON),
      Padding(
        padding: EdgeInsets.all(context.dynamicHeight(0.007)),
        child: SvgPicture.asset(ImageConstant.NOTIFICATIONS_ITSELF_ICON),
      ),
      Padding(
        padding: EdgeInsets.all(context.dynamicHeight(0.007)),
        child: SvgPicture.asset(ImageConstant.NOTIFICATIONS_LIKE_ICON),
      ),
        Padding(
        padding: EdgeInsets.all(context.dynamicHeight(0.007)),
        child: SvgPicture.asset(ImageConstant.NOTIFICATIONS_LIKE_ICON),
      ),
        Padding(
        padding: EdgeInsets.all(context.dynamicHeight(0.007)),
        child: SvgPicture.asset(ImageConstant.NOTIFICATIONS_LIKE_ICON),
      ),
        Padding(
        padding: EdgeInsets.all(context.dynamicHeight(0.007)),
        child: SvgPicture.asset(ImageConstant.NOTIFICATIONS_LIKE_ICON),
      ),
    ];

    for (int i = 0; i < notifications.length; i++) {
      containerIcon.add(
        Container(
          width: context.dynamicWidht(0.11),
          height: context.dynamicHeight(0.052),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: Colors.white,
            border: Border.all(
              width: 2.0,
              color: AppColors.borderAndDividerColor,
            ),
          ),
          child: icons[index],
        ),
      );
    }
    return containerIcon;
  }


  buildDescriptionSubtitle(BuildContext context, index) {
    List<Widget> descriptionText = [];
    List<Widget> description = [
      discountFiftyText(),
      discountSeventyText(),
      pawsAnimalsText(),
      favoriteText(),
    ];

    for (int i = 0; i <= 4; i++) {
      descriptionText.add(Padding(
        padding: EdgeInsets.all(context.dynamicHeight(0.01)),
        child: description[index],
      ));
    }
    return descriptionText;
  }

  LocaleText favoriteText() {
    return LocaleText(
      text: LocaleKeys.my_notifications_special_for_me_favorite,
      style: AppTextStyles.bodyTextStyle.copyWith(
          fontWeight: FontWeight.bold, color: AppColors.textColor, height: 1.5),
      maxLines: 2,
      alignment: TextAlign.start,
    );
  }

  LocaleText pawsAnimalsText() {
    return LocaleText(
      text: LocaleKeys.my_notifications_special_for_me_pawsAnimals,
      style: AppTextStyles.bodyTextStyle.copyWith(
          fontWeight: FontWeight.bold, color: AppColors.textColor, height: 1.5),
      maxLines: 2,
      alignment: TextAlign.start,
    );
  }

  LocaleText discountSeventyText() {
    return LocaleText(
      text: LocaleKeys.my_notifications_special_for_me_discountSeventy,
      style: AppTextStyles.bodyTextStyle.copyWith(
          fontWeight: FontWeight.bold, color: AppColors.textColor, height: 1.5),
      maxLines: 2,
      alignment: TextAlign.start,
    );
  }

  LocaleText discountFiftyText() {
    return LocaleText(
      text: LocaleKeys.my_notifications_special_for_me_discountFifty,
      style: AppTextStyles.bodyTextStyle.copyWith(
          fontWeight: FontWeight.bold, color: AppColors.textColor, height: 1.5),
      alignment: TextAlign.start,
      maxLines: 2,
    );
  }

  buildTitle(BuildContext context, index) {
    List<Widget> titleText = [];
    List<Widget> title = [
      LocaleText(
        text: LocaleKeys.my_notifications_special_for_me_title,
        style:
            AppTextStyles.subTitleStyle.copyWith(fontWeight: FontWeight.normal),
        alignment: TextAlign.start,
        maxLines: 2,
      ),
        LocaleText(
        text: LocaleKeys.my_notifications_special_for_me_title,
        style:
            AppTextStyles.subTitleStyle.copyWith(fontWeight: FontWeight.normal),
        alignment: TextAlign.start,
        maxLines: 2,
      ),
        LocaleText(
        text: LocaleKeys.my_notifications_special_for_me_title,
        style:
            AppTextStyles.subTitleStyle.copyWith(fontWeight: FontWeight.normal),
        alignment: TextAlign.start,
        maxLines: 2,
      ),
        LocaleText(
        text: LocaleKeys.my_notifications_special_for_me_title,
        style:
            AppTextStyles.subTitleStyle.copyWith(fontWeight: FontWeight.normal),
        alignment: TextAlign.start,
        maxLines: 2,
      ),
      LocaleText(
        text: LocaleKeys.my_notifications_special_for_me_title,
        style:
            AppTextStyles.subTitleStyle.copyWith(fontWeight: FontWeight.normal),
        maxLines: 2,
        alignment: TextAlign.start,
      ),
      LocaleText(
        text: LocaleKeys.my_notifications_special_for_me_title,
        style:
            AppTextStyles.subTitleStyle.copyWith(fontWeight: FontWeight.normal),
        maxLines: 2,
        alignment: TextAlign.start,
      ),
      LocaleText(
        text: LocaleKeys.my_notifications_special_for_me_title,
        style:
            AppTextStyles.subTitleStyle.copyWith(fontWeight: FontWeight.normal),
        alignment: TextAlign.start,
        maxLines: 2,
      ),
    ];

    for (int i = 0; i <= 4; i++) {
      titleText.add(title[index]);
    }
    return titleText;
  }
}
