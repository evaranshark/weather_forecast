import '../../Data/models/weather_model.dart';

abstract class WeatherDataSource {
  Future<WeatherModel> getWeatherByCityName(String location);
  Future<List<WeatherModel>> getForecastByCityName(String location);

  Future<WeatherModel> getWeatherByCoords(double lat, double lon);
  Future<List<WeatherModel>> getForecastByCoords(double lat, double lon);
}
