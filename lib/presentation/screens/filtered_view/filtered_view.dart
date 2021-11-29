import 'package:dongu_mobile/data/model/search_store.dart';
import 'package:dongu_mobile/logic/cubits/filters_cubit/filters_manager_cubit.dart';
import 'package:dongu_mobile/logic/cubits/filters_cubit/sort_filters_cubit.dart';
import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';
import 'package:dongu_mobile/logic/cubits/search_store_cubit/search_store_cubit.dart';
import 'package:dongu_mobile/presentation/screens/restaurant_details_views/screen_arguments/screen_arguments.dart';
import 'package:dongu_mobile/presentation/widgets/restaurant_info_list_tile/restaurant_info_list_tile.dart';
import 'package:dongu_mobile/presentation/widgets/scaffold/custom_scaffold.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class FilteredView extends StatefulWidget {
  FilteredView({Key? key}) : super(key: key);

  @override
  _FilteredViewState createState() => _FilteredViewState();
}

class _FilteredViewState extends State<FilteredView> {
  @override
  void initState() {
    context.read<SearchStoreCubit>().getSearchStore();
    context.read<SortFilterCubit>();
    context.read<FiltersManagerCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildBuilder();
  }

  Builder buildBuilder() {
    return Builder(builder: (context) {
      final GenericState state = context.watch<FiltersManagerCubit>().state;

      //final FiltersState filterState = context.watch<FiltersCubit>().state;

      if (state is GenericInitial) {
        return Container(color: Colors.white);
      } else if (state is GenericLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (state is GenericCompleted) {
        List<SearchStore> restaurants = [];
        //List<double> distances = [];

        for (int i = 0; i < state.response.length; i++) {
          restaurants.add(state.response[i]);
        }

        return CustomScaffold(
            isDrawer: false,
            title: "Filtrelenmis",
            body: buildListViewRestaurantInfo(state, restaurants));
      } else {
        final error = state as GenericError;
        return Center(child: Text("${error.message}\n${error.statusCode}"));
      }
    });
  }

  ListView buildListViewRestaurantInfo(
    GenericState state,
    List<SearchStore> restaurants,
  ) {
    return ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          return RestaurantInfoListTile(
            deliveryType: 1,
            icon: restaurants[index].photo,
            restaurantName: restaurants[index].name,
            distance: "m",
            packetNumber: 0 == 0 ? 'tükendi' : '4 paket',
            availableTime: '1',
            border: Border.all(
              width: 1.0,
              color: AppColors.borderAndDividerColor,
            ),
            minDiscountedOrderPrice: null,
            minOrderPrice: null,
            onPressed: () {
              Navigator.pushNamed(context, RouteConstant.RESTAURANT_DETAIL,
                  arguments: ScreenArgumentsRestaurantDetail(
                      restaurant: restaurants[index]));
            },
          );
        });
  }
}
