import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast/state_management/event/app_event.dart';
import 'package:weather_forecast/state_management/state/app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppState()) {
    on<AppEventUpdateLocation>(_onUpdate);
  }

  void _onUpdate(AppEventUpdateLocation event, Emitter<AppState> emit) {
    emit(state.copyWith(location: event.location));
  }
}
