import '../../../data/repositories/user_address_repository.dart';
import '../generic_state/generic_state.dart';
import 'package:dongu_mobile/utils/network_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserAddressCubit extends Cubit<GenericState> {
  final UserAdressRepository _userAdressRepository;
  UserAddressCubit(this._userAdressRepository) : super(GenericInitial());

  Future<void> getUserAddress() async {
    try {
      emit(GenericLoading());
      final response = await _userAdressRepository.getUserAddress();
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }
}
