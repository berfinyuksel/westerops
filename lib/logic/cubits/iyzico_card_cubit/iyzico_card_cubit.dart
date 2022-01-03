import 'package:dongu_mobile/data/repositories/iyzico_repositories/iyzico_card_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../generic_state/generic_state.dart';

class IyzicoCardCubit extends Cubit<GenericState> {
  final IyzicoCardRepository _iyzicoCardRepository;
  IyzicoCardCubit(this._iyzicoCardRepository) : super(GenericInitial());

  Future<void> getCards() async {
    try {
      emit(GenericLoading());

      final response = await _iyzicoCardRepository.getCards();
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }
}
