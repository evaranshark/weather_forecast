import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast/Domain/use_cases/get_forecast.dart';

import '../event/forecast_event.dart';
import '../state/forecast_state.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  final GetForecast useCase;

  ForecastBloc({required this.useCase}) : super(ForecastStateEmpty()) {
    on<ForecastEventStartLoad>(_onLoad);
  }

  Future<void> _onLoad(
      ForecastEventStartLoad event, Emitter<ForecastState> emit) async {
    emit(ForecastStateLoading());

    await useCase
        .execute(GetForecastParams(event.location.name))
        .then(((value) =>
            emit(ForecastStateLoaded(data: value, location: event.location))))
        .onError(((error, stackTrace) => emit(ForecastStateError())));
  }
}
