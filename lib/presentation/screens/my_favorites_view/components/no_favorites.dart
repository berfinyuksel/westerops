import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/constants/image_constant.dart';
import '../../../../utils/locale_keys.g.dart';
import '../../../widgets/text/locale_text.dart';

class NoFavorites extends StatelessWidget {
  const NoFavorites({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 40.h,
            ),
            SvgPicture.asset(ImageConstant.SURPRISE_PACK_ALERT),
            SizedBox(
              height: 20.h,
            ),
            LocaleText(
              alignment: TextAlign.center,
              text: LocaleKeys.my_favorites_no_favorites,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}