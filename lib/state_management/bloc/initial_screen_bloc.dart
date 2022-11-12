import 'package:weather_forecast/state_management/event/initial_screen_event.dart';
import 'package:weather_forecast/state_management/state/initial_state.dart';
import 'package:bloc/bloc.dart';

class InitialScreenBloc extends Bloc<InitialScreenEvent, InitialScreenState> {
  InitialScreenBloc() : super(const InitialScreenState("")) {
    on<InitialScreenFieldValueChangedEvent>(_onFieldValueChanged);
  }

  void _onFieldValueChanged(InitialScreenFieldValueChangedEvent event,
      Emitter<InitialScreenState> emit) {
    emit(state.copyWith(textFieldValue: event.value ?? ""));
  }
}
