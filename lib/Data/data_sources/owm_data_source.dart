import 'dart:io';

import 'package:dio/dio.dart';
import 'package:weather_forecast/Data/data_sources/weather_data_source.dart';
import 'package:weather_forecast/Data/models/weather_model.dart';
import 'package:weather_forecast/app_constants.dart';

class OWMDataSource implements WeatherDataSource {
  @override
  Future<WeatherModel> getWeatherByCityName(String location) async {
    return await Dio()
        .get(_UriProvider.weatherByCity(location: location).uri.toString())
        .then((value) => WeatherModel.fromJson(value.data))
        .onError((error, stackTrace) =>
            throw HttpException("Error fetching weather data for $location"));
  }

  @override
  Future<List<WeatherModel>> getForecastByCityName(String location) async {
    return await Dio()
        .get(
            'https://api.openweathermap.org/data/2.5/forecast?q=$location&appid=${AppConstants.API_KEY}&units=metric&cnt=24')
        .then((value) => WeatherModel.arrayFromJson(value.data))
        .onError((error, stackTrace) => throw error!);
  }

  @override
  Future<List<WeatherModel>> getForecastByCoords(double lat, double lon) async {
    return await Dio()
        .getUri(_UriProvider.forecastByCoords(lat: lat, lon: lon).uri)
        .then((value) => WeatherModel.arrayFromJson(value.data))
        .onError((error, stackTrace) => throw HttpException(
            "Fetching forecast data for lat: $lat, lon: $lon failed."));
  }

  @override
  Future<WeatherModel> getWeatherByCoords(double lat, double lon) async {
    return await Dio()
        .getUri(_UriProvider.weatherByCoords(lat: lat, lon: lon).uri)
        .then((value) => WeatherModel.fromJson(value.data))
        .onError((error, stackTrace) => throw HttpException(
            "Fetching weather data for lat: $lat, lon: $lon failed."));
  }
}

class _UriProvider {
  String domain;
  String path;
  Map<String, dynamic>? query;

  _UriProvider._({required this.domain, required this.path, this.query});

  factory _UriProvider.weatherByCity({required String location}) =>
      _UriProvider._(
          domain: "api.openweathermap.org",
          path: "/data/2.5/weather",
          query: {
            'q': location,
            'units': 'metric',
            'appid': AppConstants.API_KEY
          });

  factory _UriProvider.weatherByCoords(
          {required double lat, required double lon}) =>
      _UriProvider._(
          domain: "api.openweathermap.org",
          path: "/data/2.5/weather",
          query: {
            'lat': lat.toStringAsFixed(2),
            'lon': lon.toStringAsFixed(2),
            'units': 'metric',
            'appid': AppConstants.API_KEY
          });

  factory _UriProvider.forecastByName({required String name}) => _UriProvider._(
          domain: "api.openweathermap.org",
          path: "/data/2.5/forecast",
          query: {
            'q': name,
            'units': 'metric',
            'appid': AppConstants.API_KEY,
          });

  factory _UriProvider.forecastByCoords(
          {required double lat, required double lon}) =>
      _UriProvider._(
          domain: "api.openweathermap.org",
          path: "/data/2.5/forecast",
          query: {
            'lat': lat.toStringAsFixed(2),
            'lon': lon.toStringAsFixed(2),
            'units': 'metric',
            'appid': AppConstants.API_KEY
          });

  Uri get uri => Uri.http(domain, path, query);
}
