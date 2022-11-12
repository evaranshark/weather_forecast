import 'package:equatable/equatable.dart';
import 'package:weather_forecast/Domain/entities/weather_condition.dart';

// API:
// weatherState, time, min, max, current,
class Weather extends Equatable {
  final WeatherCondition condition;
  final DateTime date;
  final String location;
  final int temperature;
  final int? minTemp;
  final int? maxTemp;
  final int pressure;
  final int humidity;
  final int wind;
  final int windDegree;

  const Weather(
      {required this.condition,
      required this.date,
      required this.location,
      required this.temperature,
      this.minTemp,
      this.maxTemp,
      required this.pressure,
      required this.humidity,
      required this.wind,
      required this.windDegree});

  Weather copyWith({
    condition,
    date,
    location,
    temperature,
    minTemp,
    maxTemp,
    pressure,
    humidity,
    wind,
    windDegree,
  }) =>
      Weather(
          condition: condition ?? this.condition,
          date: date ?? this.date,
          location: location ?? this.location,
          temperature: temperature ?? this.temperature,
          minTemp: minTemp ?? this.minTemp,
          maxTemp: maxTemp ?? this.maxTemp,
          pressure: pressure ?? this.pressure,
          humidity: humidity ?? this.humidity,
          wind: wind ?? this.wind,
          windDegree: windDegree ?? this.windDegree);

  @override
  List<Object> get props =>
      [condition, date, location, temperature, pressure, humidity, wind];
}
