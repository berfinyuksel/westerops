import 'package:flutter_bloc/flutter_bloc.dart';

class LoginStatusCubit extends Cubit<int> {
  LoginStatusCubit() : super(200);

  void loginStatus(int status) {
    emit(status);
  }
}
