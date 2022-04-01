import 'package:flutter_bloc/flutter_bloc.dart';

class ScaffoldBasketCounterCubit extends Cubit<int> {
  ScaffoldBasketCounterCubit() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);

  void setCounter(int count) {
    emit(count);
  }
}
