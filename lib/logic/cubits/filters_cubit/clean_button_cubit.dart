import 'package:flutter_bloc/flutter_bloc.dart';

class CleanButton extends Cubit<bool> {
  CleanButton() : super(true);

  void cleanButton(bool isClean) {
    emit(isClean);
  }
}
