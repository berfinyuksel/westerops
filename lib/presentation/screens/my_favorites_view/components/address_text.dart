import 'package:dongu_mobile/data/services/location_service.dart';
import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../logic/cubits/address_cubit/address_cubit.dart';
import '../../../../logic/cubits/generic_state/generic_state.dart';
import '../../../widgets/text/locale_text.dart';
import '../../../../utils/constants/image_constant.dart';
import '../../../../utils/constants/route_constant.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
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
        return Container(color: Colors.white);
      } else if (stateOfAddress is GenericLoading) {
        return SizedBox(height: 0, width: 0);
      } else if (stateOfAddress is GenericCompleted) {
        if (stateOfAddress.response.isNotEmpty) {
          final idOfAddress = stateOfAddress.response.first.id;
          SharedPrefs.setActiveAddressId(idOfAddress);
        }

        return stateOfAddress.response.isNotEmpty
            ? Container(
                child: Text.rich(
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
                ),
              )
            : GestureDetector(
                onTap: () {
                  if (LocationService.latitude != 0 && !SharedPrefs.getIsLogined) {
                    Navigator.of(context).pushNamed(RouteConstant.LOGIN_VIEW);
                  } else {
                    if (stateOfAddress.response.isEmpty) {
                      Navigator.of(context).pushNamed(RouteConstant.ADDRESS_VIEW);
                    } else {
                      print("state address not empty");
                      Navigator.pushNamed(context, RouteConstant.LOCATION_VIEW);
                    }
                  }
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
                      child: Container(
                        child: LocaleText(
                          text: !SharedPrefs.getIsLogined
                              ? LocaleKeys.login_text_login2
                              : stateOfAddress.response.isEmpty
                                  ? LocaleKeys.address_no_address
                                  : LocaleKeys.my_favorites_permission_for_location,
                          style: GoogleFonts.montserrat(
                            color: AppColors.yellowColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 13.sp,
                            decoration: TextDecoration.underline,
                            decorationThickness: 2,
                            height: 3.0.h,
                          ),
                        ),
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
                    text: LocaleKeys.my_favorites_permission_for_location,
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
        } else if (error.statusCode == "401") {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RouteConstant.LOGIN_VIEW);
            },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: LocaleText(
                    text: LocaleKeys.login_text_login2,
                    style: GoogleFonts.montserrat(
                      color: AppColors.yellowColor,
                      fontWeight: FontWeight.w500,
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
