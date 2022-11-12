import 'package:weather_forecast/Data/models/location_model.dart';

import '../models/weather_model.dart';

abstract class WeatherDataSource {
  Future<WeatherModel> getWeatherByCityName(String location);
  Future<List<WeatherModel>> getForecastByCityName(String location);

  Future<WeatherModel> getWeatherByCoords(double lat, double lon);
  Future<List<WeatherModel>> getForecastByCoords(double lat, double lon);
}
