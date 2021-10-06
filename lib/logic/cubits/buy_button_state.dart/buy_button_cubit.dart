import 'package:flutter_bloc/flutter_bloc.dart';
part 'buy_button_state.dart';

class BuyButtonCubit extends Cubit<List<bool>> {
  BuyButtonCubit() : super([]);

  void setButtonActiveList(List<bool> list) {
    emit(list);
  }
}
