import 'package:dongu_mobile/logic/cubits/filters_cubit/clean_button_cubit.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../logic/cubits/filters_cubit/filters_cubit.dart';
import '../../widgets/scaffold/custom_scaffold.dart';
import 'components/choose_category_filter_list_tile.dart';
import 'components/clean_and_save_buttons.dart';
import 'components/package_delivery_filter_list_tile.dart';
import 'components/package_price_filter_list_tile.dart';
import 'components/sort_filter_list_tile.dart';

class FilterView extends StatefulWidget {
  const FilterView({Key? key}) : super(key: key);

  @override
  _FilterViewState createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  bool isClean = false;
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        isDrawer: false,
        title: LocaleKeys.filters_title,
        isNavBar: true,
        body: Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 700.h,
                  child: ListView(
                    children: [
                      SortFilterList(),
                      Divider(
                        height: 0.1.h,
                      ),
                      PackagePriceFilterList(),
                      Divider(
                        height: 0.1.h,
                      ),
                      PackageDeliveryFilterList(),
                      Divider(
                        height: 0.1.h,
                      ),
                      ChooseCategoryFilterList(),
                      // SizedBox(
                      //   height: context.dynamicHeight(0.34),
                      // ),
                    ],
                  ),
                ),
                Builder(builder: (context) {
                  final FiltersState state =
                      context.watch<FiltersCubit>().state;
                  return CleanAndSaveButtons(
                    onPressed: () {
                      context.read<CleanButton>().cleanButton(isClean);
                     // context.read<FilterFavorites>().filterFavorites(isClean);
                      setState(() {
                        for (int i = 0; i < 17; i++) {
                          state.checkList![i] = false;
                          print("checkboxlar temizlendi");
                        isClean = !isClean;
                        }
                        print(isClean);
                      });
                    },
                  );
                })
                // Positioned(
                //   child: CleanAndSaveButtons(),
                //   bottom: 0,
                //   top: context.dynamicHeight(0.7),
                //   left: 0,
                //   right: 0,
                // )
              ],
            ),
          ),
        ));
  }
}
