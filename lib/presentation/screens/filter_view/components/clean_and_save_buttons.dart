import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/presentation/screens/filtered_view/filtered_view.dart';
import 'package:flutter/material.dart';

import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/locale_keys.g.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../widgets/button/custom_button.dart';

class CleanAndSaveButtons extends StatefulWidget {
  CleanAndSaveButtons({Key? key}) : super(key: key);

  @override
  _CleanAndSaveButtonsState createState() => _CleanAndSaveButtonsState();
}

class _CleanAndSaveButtonsState extends State<CleanAndSaveButtons> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: context.dynamicWidht(0.06), right: context.dynamicWidht(0.06)),
      child: Row(
        children: [
          CustomButton(
            width: context.dynamicWidht(0.4),
            title: LocaleKeys.filters_button_item1,
            textColor: AppColors.greenColor,
            color: Colors.transparent,
            borderColor: AppColors.greenColor,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FilteredView()));
              //   Navigator.pushNamed(context, RouteConstant.LOGIN_VIEW);
            },
          ),
          Spacer(flex: 1),
          CustomButton(
            width: context.dynamicWidht(0.4),
            title: LocaleKeys.filters_button_item2,
            textColor: Colors.white,
            color: AppColors.greenColor,
            borderColor: AppColors.greenColor,
            onPressed: () {
              SharedPrefs.getSortByDistance;
              
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FilteredView()));
              //   Navigator.pushNamed(context, RouteConstant.REGISTER_VIEW);
            },
          ),
        ],
      ),
    );
  }
}
