import 'package:weather_forecast/Data/models/location_model.dart';

abstract class GeocodingDataSource {
  Future<List<LocationModel>> getLocations(String name);
}
