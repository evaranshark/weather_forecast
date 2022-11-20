import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast/Data/data_sources/owm_geocoding_data_source.dart';
import 'package:weather_forecast/Data/repositories/geocoding_repository.dart';
import 'package:weather_forecast/Domain/use_cases/get_forecast.dart';
import 'package:weather_forecast/state_management/bloc/app_bloc.dart';
import 'package:weather_forecast/state_management/bloc/details_screen_bloc.dart';
import 'package:weather_forecast/state_management/bloc/forecast_bloc.dart';
import 'Data/data_sources/owm_data_source.dart';
import 'Data/repositories/weather_repository.dart';
import 'Domain/use_cases/get_weather_by_city.dart';

//Class contains current app configuration.
//Instantiates usecases and Bloc providers
class BaseConfiguration {
  late final GetWeatherByCity getWeatherCase;
  late final GetForecast getForecastCase;
  late final List<BlocProvider> providers;

  BaseConfiguration._() {
    getWeatherCase = GetWeatherByCity(
      weatherRepository: WeatherRepository(dataSource: OWMDataSource()),
      geocodingRepository:
          GeocodingRepository(dataSource: OWMGeocodingDataSource()),
    );
    getForecastCase = GetForecast(
      repository: WeatherRepository(dataSource: OWMDataSource()),
      geocodingRepository: GeocodingRepository(
        dataSource: OWMGeocodingDataSource(),
      ),
    );

    providers = [
      BlocProvider<DetailsBloc>(
        create: (context) => DetailsBloc(useCase: getWeatherCase),
      ),
      BlocProvider<ForecastBloc>(
          create: ((context) => ForecastBloc(useCase: getForecastCase))),
      BlocProvider<AppBloc>(
        create: ((context) => AppBloc()),
      )
    ];
  }

  BaseConfiguration.getConfiguration() : this._();
}
