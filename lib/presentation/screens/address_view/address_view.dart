import 'package:dongu_mobile/data/model/user_address.dart';

import 'package:dongu_mobile/logic/cubits/user_address_cubit/user_address_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/cubits/generic_state/generic_state.dart';

import '../../../utils/constants/route_constant.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/scaffold/custom_scaffold.dart';
import 'components/address_view_title.dart';
import 'components/adress_list_tile.dart';
import '../../../utils/extensions/string_extension.dart';

class AddressView extends StatefulWidget {
  @override
  State<AddressView> createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  @override
  void initState() {
    super.initState();
    context.read<UserAddressCubit>().getUserAddress();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: LocaleKeys.address_title,
      body: Padding(
        padding: EdgeInsets.only(
          top: context.dynamicHeight(0.02),
          bottom: context.dynamicHeight(0.04),
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
      height: context.dynamicHeight(0.6),
      padding: EdgeInsets.only(
        top: context.dynamicHeight(0.01),
      ),
      child: Builder(builder: (context) {
        final GenericState state = context.watch<UserAddressCubit>().state;
        if (state is GenericInitial) {
          return Text("aaa");
        } else if (state is GenericLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is GenericCompleted) {
          List<Result> list = [];
          for (var i = 0; i < state.response.length; i++) {
            list.add(state.response[i]);
          }
          print(state.response.length);
          return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return AddressListTile(
                  title: list[index].name,
                  subtitleBold: "${list[index].province}",
                  address: "\n${list[index].address}",
                  phoneNumber: "\n${list[index].phoneNumber}",
                  description: "\n${list[index].description}",
                );
              });
        } else
          return Container();
      }),
    );
  }

  Padding buildButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: context.dynamicWidht(0.06), right: context.dynamicWidht(0.06)),
      child: CustomButton(
        width: double.infinity,
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
}
