import 'package:weather_forecast/Core/adapters/locationmodel_to_location_adapter.dart';
import 'package:weather_forecast/Data/data_sources/geocoding_data_source.dart';
import 'package:weather_forecast/Data/models/location_model.dart';
import 'package:weather_forecast/Domain/entities/location.dart';
import 'package:weather_forecast/Domain/repositories/base_geocoding_repository.dart';

import '../../Core/adapter.dart';

class GeocodingRepository implements BaseGeocodingRepository {
  final GeocodingDataSource dataSource;
  const GeocodingRepository({required this.dataSource});

  @override
  Future<List<Location>> getLocations(String location) async {
    Adapter<LocationModel, Location> adapter = LocationModelToLocationAdapter();
    return await dataSource
        .getLocations(location)
        .then((value) => value.map((e) => adapter.cast(e)).toList())
        .onError((error, stackTrace) =>
            throw Exception("Fetching data from source failed."));
  }
}
