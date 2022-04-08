import 'package:flutter_bloc/flutter_bloc.dart';

class UserEmailControlCubit extends Cubit<String> {
  UserEmailControlCubit() : super("");


   setStateEmail(String state) {
    emit(state);
  }
}
