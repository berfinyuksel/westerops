import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBarCubit extends Cubit<bool> {
  OrderBarCubit() : super(false);

  void stateOfBar(bool stateOfBar) {
    emit(stateOfBar);
  }
}
