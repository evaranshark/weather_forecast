import 'package:equatable/equatable.dart';
import 'package:weather_forecast/Domain/entities/weather.dart';

class ForecastAggregator extends Equatable {
  final String location;
  final String date;
  final List<Weather> entries;

  ForecastAggregator({
    required this.location,
    required this.date,
    required this.entries,
  });

  @override
  List<Object?> get props => [location, date];
}
