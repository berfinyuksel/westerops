// import 'package:dongu_mobile/logic/cubits/box_cubit/box_cubit.dart';
// import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';
// import 'package:dongu_mobile/logic/cubits/order_cubit/order_cubit.dart';
// import 'package:dongu_mobile/presentation/widgets/button/custom_button.dart';
// import 'package:dongu_mobile/utils/extensions/context_extension.dart';
// import 'package:dongu_mobile/utils/locale_keys.g.dart';
// import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class addToBasketButton extends StatelessWidget {
//   const addToBasketButton({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Builder(
//       builder: (BuildContext context) {
//             final GenericState state = context.watch<OrderCubit>().state;
//  if (state is GenericInitial) {
//           return CustomButton(
//             title: LocaleKeys.restaurant_detail_button_text,
//             color: AppColors.greenColor,
//             textColor: AppColors.appBarColor,
//             width: context.dynamicWidht(0.28),
//             borderColor: AppColors.greenColor,
//             onPressed: () {
//               context.read<OrderCubit>().addToBasket("76312");
//             },
//           );
//         } else if (state is GenericLoading) {
//           return CustomButton(
//             title: LocaleKeys.restaurant_detail_button_text,
//             color: AppColors.greenColor,
//             textColor: AppColors.appBarColor,
//             width: context.dynamicWidht(0.28),
//             borderColor: AppColors.greenColor,
//             onPressed: () {
//               context.read<OrderCubit>().addToBasket("76312");
//             },
//           );
//         } else if (state is GenericCompleted) {
//           print(state.response);
//           print(state.response.length);
//           //print(state.response[0].description);
//           return CustomButton(
//             title: LocaleKeys.restaurant_detail_button_text,
//             color: AppColors.greenColor,
//             textColor: AppColors.appBarColor,
//             width: context.dynamicWidht(0.28),
//             borderColor: AppColors.greenColor,
//             onPressed: () {
//               print("RESPONE: ${state.response[0].id}");
//               context.read<OrderCubit>().addToBasket("76312");
//             },
//           );
//         } else {
//           final error = state as GenericError;
//           return Center(child: Text("${error.message}\n${error.statusCode}"));
//         }
      
//       },
//     );
//   }
// }
