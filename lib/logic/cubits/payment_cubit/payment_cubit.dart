import 'package:bloc/bloc.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentState(isOnline: true, isGetIt: true));

  void setIsOnline(bool isOnline) => emit(PaymentState(isOnline: state.isOnline = isOnline, isGetIt: state.isGetIt));
  void setIsGetIt(bool isGetIt) => emit(PaymentState(isGetIt: state.isGetIt = isGetIt, isOnline: state.isOnline));
}
