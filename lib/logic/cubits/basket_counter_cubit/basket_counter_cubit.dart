import 'package:flutter_bloc/flutter_bloc.dart';
part 'basket_counter_state.dart';

class BasketCounterCubit extends Cubit<int> {
  BasketCounterCubit() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);

  void setCounter(int count) {
    emit(count);
  }
}
