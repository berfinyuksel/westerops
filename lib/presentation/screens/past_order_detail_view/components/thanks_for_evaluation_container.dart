import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/constants/image_constant.dart';
import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/locale_keys.g.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../widgets/text/locale_text.dart';

class ThanksForEvaluationContainer extends StatelessWidget {
  const ThanksForEvaluationContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.dynamicHeight(0.19),
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: context.dynamicWidht(0.06),
              right: context.dynamicWidht(0.06),
            ),
            child: Divider(
              height: 0,
              thickness: 2,
              color: AppColors.borderAndDividerColor,
            ),
          ),
          Spacer(
            flex: 2,
          ),
          SvgPicture.asset(ImageConstant.PAST_ORDER_DETAIL_BIG_STAR),
          Spacer(flex: 1),
          LocaleText(
            text: LocaleKeys.past_order_detail_thanks,
            style: GoogleFonts.montserrat(
              fontSize: 18.0,
              color: AppColors.orangeColor,
              fontWeight: FontWeight.w500,
            ),
            alignment: TextAlign.center,
          ),
          Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}
