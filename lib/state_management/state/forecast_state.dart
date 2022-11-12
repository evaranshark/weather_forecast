import 'package:weather_forecast/Domain/entities/location.dart';

import '../../Domain/entities/weather.dart';

abstract class ForecastState {}

class ForecastStateEmpty extends ForecastState {}

class ForecastStateLoading extends ForecastState {}

class ForecastStateLoaded extends ForecastState {
  Location location;
  final List<Weather> data;

  ForecastStateLoaded({required this.data, required this.location});
}

class ForecastStateError extends ForecastState {}
