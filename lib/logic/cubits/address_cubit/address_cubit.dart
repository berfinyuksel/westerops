import 'package:dongu_mobile/data/repositories/address_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../generic_state/generic_state.dart';

class AddressCubit extends Cubit<GenericState> {
  final AdressRepository _addressRepository;
  AddressCubit(this._addressRepository) : super(GenericInitial());

  Future<void> getAddress(int id) async {
    try {
      emit(GenericLoading());
      final response = await _addressRepository.getAddress(id);
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }

  Future<void> addAddress(
      String name,
      int type,
      String address,
      String description,
      String country,
      String city,
      String province,
      String phoneNumber,
      String tcknVkn,
      double latitude,
      double longitude) async {
    try {
      emit(GenericLoading());
      final response = await _addressRepository.addAddress(
          name,
          type,
          address,
          description,
          country,
          city,
          province,
          phoneNumber,
          tcknVkn,
          latitude,
          longitude);
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }

  Future<void> updateAddress(
      int id,
      String name,
      int type,
      String address,
      String description,
      String country,
      String city,
      String province,
      String phoneNumber,
      String tcknVkn,
      double latitude,
      double longitude) async {
    try {
      emit(GenericLoading());
      final response = await _addressRepository.updateAddress(
          id,
          name,
          type,
          address,
          description,
          country,
          city,
          province,
          phoneNumber,
          tcknVkn,
          latitude,
          longitude);
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }

  Future<void> deleteAddress(int? id) async {
    try {
      emit(GenericLoading());
      final response = await _addressRepository.deleteAddress(id);
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }

  Future<void> getActiveAddress() async {
    try {
      emit(GenericLoading());
      final response = await _addressRepository.getActiveAddress();
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }
}