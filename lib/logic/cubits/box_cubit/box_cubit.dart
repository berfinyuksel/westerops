import 'package:dongu_mobile/utils/network_error.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/box.dart';
import '../../../data/repositories/box_repository.dart';
import 'box_state.dart';

class BoxCubit extends Cubit<BoxState> {
  final SampleBoxRepository _boxRepository;
  List<Box> packetNumber = [];
  BoxCubit(this._boxRepository) : super(BoxInitial());

  Future<void> getBoxes(int id) async {
    try {
      emit(BoxLoading());
      final response = await _boxRepository.getBoxes(id);
      packetNumber = response;
      print("PACKET NUMBER: $packetNumber");
      print("PACKET NUMBER LENGTH: ${packetNumber.length}");
      emit(BoxCompleted(packetNumber));
    } on NetworkError catch (e) {
      debugPrint(e.toString());
      // emit(GenericError(e.message, e.statusCode));
    }
  }
}
