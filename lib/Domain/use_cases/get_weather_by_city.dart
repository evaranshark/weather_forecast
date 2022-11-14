import 'package:equatable/equatable.dart';
import 'package:weather_forecast/Core/usecase.dart';
import 'package:weather_forecast/Domain/repositories/base_geocoding_repository.dart';
import 'package:weather_forecast/Domain/repositories/base_weather_repository.dart';

import '../entities/weather.dart';

//Usecase gets data from related repositories and prepares data to be presented.
class GetWeatherByCity implements UseCase<Weather, GetWeatherByCityParams> {
  final BaseWeatherRepository weatherRepository;
  final BaseGeocodingRepository geocodingRepository;

  GetWeatherByCity({
    required this.weatherRepository,
    required this.geocodingRepository,
  });

  @override
  Future<Weather> execute(params) async {
    var location = await geocodingRepository
        .getLocations(params.location)
        .then((value) => value[0])
        .onError((error, stackTrace) {
      throw error!;
    });
    return await weatherRepository.getWeatherByCoords(location);
  }
}

class GetWeatherByCityParams extends Equatable {
  final String location;

  const GetWeatherByCityParams({required this.location});

  @override
  List<Object> get props => [location];
}
