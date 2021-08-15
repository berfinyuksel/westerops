import 'package:dongu_mobile/data/repositories/box_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../generic_state/generic_state.dart';

class BoxCubit extends Cubit<GenericState> {
  final BoxRepository _boxRepository;
  BoxCubit(this._boxRepository) : super(GenericInitial());


  Future<void> getBoxes(int id) async {
    try {
      emit(GenericLoading());
      final response = await _boxRepository.getBoxes(id);
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }
}
