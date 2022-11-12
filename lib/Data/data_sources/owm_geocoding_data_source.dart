import 'dart:io';

import 'package:dio/dio.dart';
import 'package:weather_forecast/Data/data_sources/geocoding_data_source.dart';
import 'package:weather_forecast/Data/models/location_model.dart';
import 'package:weather_forecast/app_constants.dart';

class OWMGeocodingDataSource implements GeocodingDataSource {
  @override
  Future<List<LocationModel>> getLocations(String name) async {
    var uriString = _getUri(name).toString();
    return await Dio()
        .get(uriString)
        .then((value) => LocationModel.fromJsonList(value.data))
        .onError((error, stackTrace) {
      print(error!);
      throw HttpException("Error fetching data on uri.", uri: _getUri(name));
    });
  }

  Uri _getUri(String name) {
    return Uri.http("api.openweathermap.org", "/geo/1.0/direct",
        {'q': name, 'limit': '1', 'appid': AppConstants.API_KEY});
  }
}
