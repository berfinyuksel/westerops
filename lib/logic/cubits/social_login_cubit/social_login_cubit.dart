import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLoginCubit extends Cubit<bool> {
  SocialLoginCubit() : super(false);

  void loggedIn(bool stateOfLoggedIn) => emit(stateOfLoggedIn);
}
