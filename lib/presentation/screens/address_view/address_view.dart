import 'package:dongu_mobile/presentation/widgets/circular_progress_indicator/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../data/model/user_address.dart';
import '../../../data/repositories/change_active_address_repository.dart';
import '../../../data/services/locator.dart';
import '../../../logic/cubits/address_cubit/address_cubit.dart';
import '../../../logic/cubits/generic_state/generic_state.dart';
import '../../../logic/cubits/user_address_cubit/user_address_cubit.dart';
import '../../../utils/constants/image_constant.dart';
import '../../../utils/constants/route_constant.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/scaffold/custom_scaffold.dart';
import '../../widgets/text/locale_text.dart';
import '../address_detail_view/string_arguments/string_arguments.dart';
import '../surprise_pack_view/components/custom_alert_dialog.dart';
import 'components/address_view_title.dart';
import 'components/adress_list_tile.dart';

class AddressView extends StatefulWidget {
  @override
  State<AddressView> createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  List<int> boolList = [];
  @override
  void initState() {
    context.read<UserAddressCubit>().getUserAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<UserAddressCubit>().getUserAddress();
    return CustomScaffold(
      title: LocaleKeys.address_title,
      body: Padding(
        padding: EdgeInsets.only(
          top: 20.h,
          bottom: 40.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AddressBodyTitle(),
            buildList(context),
            Spacer(),
            buildButton(context),
          ],
        ),
      ),
    );
  }

  Container buildList(BuildContext context) {
    return Container(
      height: 550.h,
      padding: EdgeInsets.only(
        top: 10.h,
      ),
      child: Builder(builder: (context) {
        final GenericState state = context.watch<UserAddressCubit>().state;
        if (state is GenericInitial) {
          return Text(LocaleKeys.address_preparing);
        } else if (state is GenericLoading) {
          return Center(child: CustomCircularProgressIndicator());
        } else if (state is GenericCompleted) {
          List<Result> list = [];
          for (var i = 0; i < state.response.length; i++) {
            list.add(state.response[i]);
          }
          return list.length != 0
              ? ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    // print(index);
                    return Dismissible(
                      direction: DismissDirection.endToStart,
                      key: UniqueKey(),
                      child: AddressListTile(
                        trailing: Container(
                          height: double.infinity,
                          width: 12.w,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RouteConstant.ADDRESS_UPDATE_VIEW,
                                  arguments:
                                      ScreenArguments(list: list[index]));
                            },
                            child: boolList.length != 0
                                ? boolList[index] == 1
                                    ? SvgPicture.asset(
                                        ImageConstant.COMMONS_CHECK_ICON,
                                        fit: BoxFit.fitWidth,
                                      )
                                    : SvgPicture.asset(
                                        ImageConstant.COMMONS_FORWARD_ICON,
                                        fit: BoxFit.fitWidth,
                                      )
                                : SvgPicture.asset(
                                    ImageConstant.COMMONS_FORWARD_ICON,
                                    fit: BoxFit.fitWidth,
                                  ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            changeAddressActivation(
                                list[index].id!, index, list.length);
                          });
                        },
                        title: list[index].name,
                        subtitleBold: "${list[index].province}",
                        address: "\n${list[index].address}",
                        phoneNumber: "\n${list[index].phoneNumber}",
                        description: "\n${list[index].description}",
                      ),
                      background: Container(
                        color: AppColors.redColor,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: context.dynamicHeight(0.038),
                              horizontal: context.dynamicWidht(0.058)),
                          child: LocaleText(
                            text: LocaleKeys.my_notifications_delete_text_text,
                            style: AppTextStyles.bodyTextStyle.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            alignment: TextAlign.end,
                          ),
                        ),
                      ),
                      confirmDismiss: (DismissDirection direction) {
                        return showDialog(
                          context: context,
                          builder: (_) => CustomAlertDialog(
                              textMessage:
                                  LocaleKeys.address_delete_alert_dialog_text,
                              buttonOneTitle: LocaleKeys.payment_payment_cancel,
                              buttonTwoTittle:
                                  LocaleKeys.address_address_approval,
                              imagePath: ImageConstant.SURPRISE_PACK_ALERT,
                              onPressedOne: () {
                                Navigator.of(context).pop();
                              },
                              onPressedTwo: () {
                                setState(() {
                                  context
                                      .read<AddressCubit>()
                                      .deleteAddress(list[index].id);
                                  Navigator.of(context)
                                      .pushNamed(RouteConstant.ADDRESS_VIEW);
                                  // Navigator.of(context).pop();
                                });
                              }),
                        );
                      },
                    );
                  })
              : Container(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.w, top: 10.h),
                    child: LocaleText(
                      text: LocaleKeys.address_no_address,
                      style: AppTextStyles.bodyTextStyle,
                    ),
                  ),
                );
        } else
          return Container(color: Colors.white);
      }),
    );
  }

  Widget buildButton(BuildContext context) {
    return Center(
      child: CustomButton(
        width: 372.w,
        title: LocaleKeys.address_button,
        color: AppColors.greenColor,
        borderColor: AppColors.greenColor,
        textColor: Colors.white,
        onPressed: () {
          Navigator.pushNamed(context, RouteConstant.ADDRESS_FROM_MAP_VIEW);
        },
      ),
    );
  }

  changeAddressActivation(int id, int index, int length) async {
    StatusCode statusCode =
        await sl<ChangeActiveAddressRepository>().changeActiveAddress(id);

    for (var i = 0; i < length; i++) {
      boolList.add(0);
    }
    if (statusCode == StatusCode.success) {
      for (int i = 0; i < boolList.length; i++) {
        setState(() {
          if (i == index) {
            boolList[i] = 1;
          } else {
            boolList[i] = 0;
          }
        });
      }

      context.read<AddressCubit>().getActiveAddress();
    }
  }
}
