import 'package:weather_forecast/Domain/entities/location.dart';

import '../entities/weather.dart';

abstract class BaseWeatherRepository {
  Future<Weather> getWeatherByCityName(String location);
  Future<Weather> getWeatherByCoords(Location location);

  Future<List<Weather>> getForecastByCityName(String location);
  Future<List<Weather>> getForecastByCoords(Location location);
}
