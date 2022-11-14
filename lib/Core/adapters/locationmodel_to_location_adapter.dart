import '../../Data/models/location_model.dart';
import '../../Domain/entities/location.dart';
import '../adapter.dart';

class LocationModelToLocationAdapter
    implements Adapter<LocationModel, Location> {
  @override
  Location cast(LocationModel value) =>
      Location(name: value.name, lat: value.lat, lon: value.lon);
}
