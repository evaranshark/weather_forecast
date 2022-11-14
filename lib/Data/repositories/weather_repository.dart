import 'package:weather_forecast/Core/adapters/weathermodel_to_weather_adapter.dart';
import 'package:weather_forecast/Domain/data_sources/weather_data_source.dart';
import 'package:weather_forecast/Domain/entities/location.dart';
import 'package:weather_forecast/Domain/entities/weather.dart';
import 'package:weather_forecast/Domain/repositories/base_weather_repository.dart';

import '../../Core/adapter.dart';
import '../models/weather_model.dart';

//Repository for Weather data source. Fetches data from source and adapts it to buisness entities.
class WeatherRepository implements BaseWeatherRepository {
  final WeatherDataSource dataSource;
  const WeatherRepository({required this.dataSource});

  @override
  Future<Weather> getWeatherByCityName(String name) async {
    return await dataSource
        .getWeatherByCityName(name)
        .then((value) => WeatherModelToWeatherAdapter().cast(value))
        .onError((error, stackTrace) => throw error!);
  }

  @override
  Future<List<Weather>> getForecastByCityName(String location) async {
    Adapter<WeatherModel, Weather> adapter = WeatherModelToWeatherAdapter();
    return await dataSource
        .getForecastByCityName(location)
        .then((value) => value.map((e) => adapter.cast(e)).toList())
        .onError((error, stackTrace) {
      throw error!;
    });
  }

  @override
  Future<List<Weather>> getForecastByCoords(Location location) async {
    Adapter<WeatherModel, Weather> adapter = WeatherModelToWeatherAdapter();
    return await dataSource
        .getForecastByCoords(location.lat!, location.lon!)
        .then((value) => value.map((e) => adapter.cast(e)).toList())
        .onError((error, stackTrace) =>
            throw Exception("Fetching data from source failed."));
  }

  @override
  Future<Weather> getWeatherByCoords(Location location) async {
    Adapter<WeatherModel, Weather> adapter = WeatherModelToWeatherAdapter();
    return await dataSource
        .getWeatherByCoords(location.lat!, location.lon!)
        .then((value) => adapter.cast(value))
        .onError((error, stackTrace) =>
            throw Exception("Fetching data from source failed."));
  }
}
