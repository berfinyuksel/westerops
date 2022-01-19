import 'package:dongu_mobile/presentation/screens/filtered_view/not_filtered_view.dart';
import 'package:flutter/material.dart';

import '../../../../data/shared/shared_prefs.dart';
import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/locale_keys.g.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../widgets/button/custom_button.dart';
import '../../filtered_view/filtered_view.dart';

class CleanAndSaveButtons extends StatefulWidget {
  final VoidCallback? onPressed;
  CleanAndSaveButtons({Key? key, this.onPressed}) : super(key: key);

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
            onPressed: widget.onPressed,
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
              if (SharedPrefs.getIsLogined ==false) {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NotFilteredView()));
              } 
              else {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FilteredView()));
              }
            
              //   Navigator.pushNamed(context, RouteConstant.REGISTER_VIEW);
            },
          ),
        ],
      ),
    );
  }
}
