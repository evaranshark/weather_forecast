import 'package:equatable/equatable.dart';
import 'package:weather_forecast/Data/models/weather_condition_model.dart';

class WeatherModel extends Equatable {
  final String location;
  final double temperature;
  final double pressure;
  final double wind;
  final int windDegree;
  final double humidity;
  final DateTime date;
  final WeatherConditionModel weather;
  final double? minTemp;
  final double? maxTemp;

  const WeatherModel(
      {required this.location,
      required this.date,
      required this.temperature,
      this.minTemp,
      this.maxTemp,
      required this.pressure,
      required this.wind,
      required this.windDegree,
      required this.humidity,
      required this.weather});

  factory WeatherModel.fromJson(Map<String, dynamic> json, {String? location}) {
    Map<String, dynamic> mainData = json['main'];

    return WeatherModel(
        location: json['name'] ?? location ?? "",
        temperature: (mainData['temp'] as num).toDouble(),
        minTemp: (mainData['temp_min'] as num).toDouble(),
        maxTemp: (mainData['temp_max'] as num).toDouble(),
        pressure: (mainData['pressure'] as num).toDouble(),
        wind: (json['wind']['speed'] as num).toDouble(),
        windDegree: (json['wind']['deg']),
        humidity: (mainData['humidity'] as num).toDouble(),
        date: DateTime.fromMillisecondsSinceEpoch((json['dt'] as int) * 1000),
        weather: WeatherConditionModel.fromJson(json['weather'][0]));
  }

  static List<WeatherModel> arrayFromJson(Map<String, dynamic> jsonString) {
    return (jsonString['list'] as List)
        .map((json) =>
            WeatherModel.fromJson(json, location: jsonString['city']['name']))
        .toList();
  }

  @override
  List<Object?> get props => throw [temperature, weather, date];
}
