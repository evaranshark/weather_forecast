import '../../Domain/entities/location.dart';

abstract class ForecastEvent {}

class ForecastEventStartLoad extends ForecastEvent {
  final Location location;

  ForecastEventStartLoad(this.location);
}
