import 'package:equatable/equatable.dart';

class WeatherCondition extends Equatable {
  final String name;
  final String description;
  final String iconUri;

  const WeatherCondition(
      {required this.name, required this.description, required this.iconUri});

  @override
  List<Object?> get props => [name, description];
}
