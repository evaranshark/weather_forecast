import 'package:equatable/equatable.dart';

class WeatherConditionModel extends Equatable {
  final String name;
  final String description;
  final String icon;

  const WeatherConditionModel(
      {required this.name, required this.description, required this.icon});

  factory WeatherConditionModel.fromJson(Map<String, dynamic> json) {
    return WeatherConditionModel(
        name: json['main'],
        description: json['description'],
        icon: json['icon']);
  }

  String get iconUri => "http://openweathermap.org/img/wn/$icon@2x.png";

  @override
  List<Object?> get props => [name, description];
}
