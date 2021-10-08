import 'package:flutter_bloc/flutter_bloc.dart';

class BuyButtonCubit extends Cubit<List<bool>> {
  BuyButtonCubit() : super([]);

  void addToStateList(bool value) {
    state.add(value);
    emit(state);
  }

  void changeStatus(List<bool> list) {
    for (var i = 0; i < state.length; i++) {
      state[i] = list[i];
    }
    emit(state);
  }
}
