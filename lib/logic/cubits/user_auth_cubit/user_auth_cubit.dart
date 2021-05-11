import '../../../data/repositories/user_authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../generic_state/generic_state.dart';

class UserAuthCubit extends Cubit<GenericState> {
  final UserAuthenticationRepository _userAuthenticationRepository;
  UserAuthCubit(this._userAuthenticationRepository) : super(GenericInitial());

  Future<void> registerUser(String firstName, String lastName, String email, String phone, String password) async {
    try {
      emit(GenericLoading());
      final response = await _userAuthenticationRepository.registerUser(firstName, lastName, email, phone, password);
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }

  Future<void> updateUser(String firstName, String lastName, String email, String phone, String address, String birthday) async {
    try {
      emit(GenericLoading());
      final response = await _userAuthenticationRepository.updateUser(firstName, lastName, email, phone, address, birthday);
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }

  Future<void> loginUser(String phone, String password) async {
    try {
      emit(GenericLoading());
      final response = await _userAuthenticationRepository.loginUser(phone, password);
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }
}
