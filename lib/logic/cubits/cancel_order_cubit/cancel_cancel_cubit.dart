import 'package:flutter_bloc/flutter_bloc.dart';

class CancelCancelCubit extends Cubit<bool> {
  CancelCancelCubit() : super(true);

  void cancelCancel(bool cancelCancel) {
    emit(cancelCancel);
  }
}
