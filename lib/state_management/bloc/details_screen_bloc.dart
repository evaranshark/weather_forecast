import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast/Domain/use_cases/get_weather_by_city.dart';
import 'package:weather_forecast/state_management/event/details_event.dart';
import 'package:weather_forecast/state_management/state/details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  GetWeatherByCity useCase;
  DetailsBloc({required this.useCase}) : super(DetailsEmptyState()) {
    on<DetailsLoadEvent>(_onLoad);
  }

  FutureOr<void> _onLoad(
      DetailsLoadEvent event, Emitter<DetailsState> emit) async {
    emit(DetailsDataLoadingState());

    await useCase
        .execute(GetWeatherByCityParams(location: event.location))
        .then((value) => emit(DetailsLoadedState(data: value)))
        .onError((error, stackTrace) => emit(DetailsErrorState()));
  }
}
