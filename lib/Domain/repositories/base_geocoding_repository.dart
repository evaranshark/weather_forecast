import '../entities/location.dart';

abstract class BaseGeocodingRepository {
  Future<List<Location>> getLocations(String location);
}
