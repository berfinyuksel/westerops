import 'package:flutter_bloc/flutter_bloc.dart';

class NearMePaddingCubit extends Cubit<double> {
  NearMePaddingCubit() : super(0);

  void setPadding(double sumOfWidth) => emit(sumOfWidth);
}
