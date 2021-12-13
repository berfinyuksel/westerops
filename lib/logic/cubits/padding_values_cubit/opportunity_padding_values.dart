import 'package:flutter_bloc/flutter_bloc.dart';

class OpportunityPaddingCubit extends Cubit<double> {
  OpportunityPaddingCubit() : super(0);

  void setPadding(double sumOfWidth) => emit(sumOfWidth);
}
