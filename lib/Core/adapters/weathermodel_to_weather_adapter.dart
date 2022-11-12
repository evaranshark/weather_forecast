import '../../Data/models/weather_model.dart';
import '../../Domain/entities/weather.dart';
import '../../Domain/entities/weather_condition.dart';

class WeatherModelToWeatherAdapter implements Adapter<WeatherModel, Weather> {
  @override
  Weather cast(WeatherModel value) => Weather(
        condition: WeatherCondition(
            name: value.weather.name,
            description: value.weather.description,
            iconUri: value.weather.iconUri),
        date: value.date,
        location: value.location,
        temperature: value.temperature.round(),
        minTemp: value.minTemp?.round(),
        maxTemp: value.maxTemp?.round(),
        pressure: value.pressure.round(),
        humidity: value.humidity.round(),
        wind: value.wind.round(),
        windDegree: value.windDegree,
      );
}

abstract class Adapter<From, To> {
  To cast(From value);
}
