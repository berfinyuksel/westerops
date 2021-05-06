import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/user_operatios_repository.dart';
import '../generic_state/generic_state.dart';

class UserOperationsCubit extends Cubit<GenericState> {
  final UserOperationsRepository _userOperationsRepository;
  UserOperationsCubit(this._userOperationsRepository) : super(GenericInitial());

  Future<void> addToFavorite(int storeId) async {
    try {
      emit(GenericLoading());
      final response = await _userOperationsRepository.addToFavorites(storeId);
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }
}
