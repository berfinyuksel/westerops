import 'package:dongu_mobile/logic/cubits/address_cubit/address_cubit.dart';
import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/theme/app_text_styles/app_text_styles.dart';

class AddressText extends StatefulWidget {
  const AddressText({
    Key? key,
  }) : super(key: key);

  @override
  State<AddressText> createState() => _AddressTextState();
}

class _AddressTextState extends State<AddressText> {
  @override
  void initState() {
    super.initState();
    context.read<AddressCubit>().getActiveAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final stateOfAddress = context.watch<AddressCubit>().state;
      if (stateOfAddress is GenericInitial) {
        return Container();
      } else if (stateOfAddress is GenericLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (stateOfAddress is GenericCompleted) {
        return Text.rich(
          TextSpan(
            style: AppTextStyles.bodyTextStyle,
            children: [
              TextSpan(
                text: stateOfAddress.response[0].name + " :",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: " " + stateOfAddress.response[0].address,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        );
      } else {
        final error = stateOfAddress as GenericError;
        if (error.statusCode == "204") {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RouteConstant.LOCATION_VIEW);
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  ImageConstant.COMMONS_ALLOW_LOCATION_ICON,
                  width: 16,
                  height: 16,
                ),
                SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: LocaleText(
                    text: "Konuma izin ver",
                    style: GoogleFonts.montserrat(
                      color: AppColors.yellowColor,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      decorationThickness: 2,
                      height: 2.0,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Center(child: Text("${error.message}\n${error.statusCode}"));
      }
    });
  }
}
