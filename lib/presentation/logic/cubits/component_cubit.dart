import 'package:bloc/bloc.dart';

part 'component_state.dart';

class ComponentCubit extends Cubit<ComponentState> {
  ComponentCubit() : super(ComponentState(index: 0, guestCount: 0));
  void changeIndex(int newIndex) =>
      emit(ComponentState(index: state.index = newIndex));
  void incrementGuestCount() =>
      emit(ComponentState(guestCount: state.guestCount = state.guestCount! + 1));
  void decrementGuestCount() =>
      emit(ComponentState(guestCount: state.guestCount = state.guestCount! - 1));
}
