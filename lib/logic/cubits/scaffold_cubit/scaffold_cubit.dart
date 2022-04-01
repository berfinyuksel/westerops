import 'package:dongu_mobile/logic/cubits/order_cubit/order_cubit.dart';
import 'package:dongu_mobile/logic/cubits/scaffold_cubit/scaffold_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/services/locator.dart';

class ScaffoldCubit extends Cubit<ScaffoldState> {
  ScaffoldCubit() : super(ScaffoldInitial());

  init() async {
    emit(ScaffoldLoading());
    await sl<OrderCubit>().getBasket();
  }

  int setBasketCounter(int countState) {
    countState + 1;
    
    print("COUNTER BASKET : $countState");
    return countState;
  }

/*   void increment() => emit(state + 1);
  void decrement() => emit(state - 1);


  setNotificationCounter(int countNotification) {
    emit(countNotification);
  } */
}
