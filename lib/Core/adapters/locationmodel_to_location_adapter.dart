import 'package:weather_forecast/Core/adapters/weathermodel_to_weather_adapter.dart';

import '../../Data/models/location_model.dart';
import '../../Domain/entities/location.dart';

class LocationModelToLocationAdapter
    implements Adapter<LocationModel, Location> {
  @override
  Location cast(LocationModel value) =>
      Location(name: value.name, lat: value.lat, lon: value.lon);
}
