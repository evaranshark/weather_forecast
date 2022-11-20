import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:weather_forecast/Core/usecase.dart';
import 'package:weather_forecast/Domain/repositories/base_weather_repository.dart';

import '../entities/weather.dart';
import '../repositories/base_geocoding_repository.dart';

//Usecase gets data from related repositories and prepares data to be presented.
//Due to unclear specification of forecast screen data there are some assumptions:
//1. Show forecast data for next 3 days form current date (excluding current date);
//1.1 Additionally show the coldest day from this 3.
//2. Show daily data as average till day (one entry for the date);
//2.1 Min and max temperature should be min and max per date;
//3. Condition shown as first for the date (probably at midnight, needs fix);
class GetForecast extends UseCase<List<Weather>, GetForecastParams> {
  final BaseWeatherRepository repository;
  final BaseGeocodingRepository geocodingRepository;

  GetForecast({
    required this.repository,
    required this.geocodingRepository,
  });

  //Fetches coordinates of city using Geocoding API, then uses it to fetch forecast data.
  @override
  Future<List<Weather>> execute(GetForecastParams params) async {
    var location = await geocodingRepository
        .getLocations(params.location)
        .then((value) => value[0])
        .onError((error, stackTrace) {
      throw error!;
    });
    return await repository.getForecastByCoords(location).then((value) {
      value = value
          .map((e) => e.copyWith(date: DateUtils.dateOnly(e.date)))
          .toList();
      List<List<Weather>> sublists = [];
      List<Weather> result = [];

      //Split forecast results list to sublists based on entry's date
      for (DateTime date in value.map((e) => e.date).toSet()) {
        sublists.add(value.where((element) => element.date == date).toList());
      }
      //Shrink sublists to one-entry-per-date
      for (List<Weather> list in sublists) {
        result.add(Weather(
            condition: list[0].condition,
            date: list[0].date,
            location: list[0].location,
            temperature:
                list.map((e) => e.temperature.toDouble()).average.round(),
            minTemp: list.map((e) => e.minTemp!.toDouble()).min.round(),
            maxTemp: list.map((e) => e.maxTemp!.toDouble()).max.round(),
            pressure: list.map((e) => e.pressure.toDouble()).average.round(),
            humidity: list.map((e) => e.humidity.toDouble()).average.round(),
            wind: list.map((e) => e.wind.toDouble()).average.round(),
            windDegree:
                list.map((e) => e.windDegree.toDouble()).average.round()));
      }
      //Remove entries with current date
      result.removeWhere(
          (element) => element.date == DateUtils.dateOnly(DateTime.now()));
      //API returns forecast for 5 days so we get 3 of them
      result = result.sublist(0, 3);
      result.insert(
          0,
          result.firstWhere((element) =>
              element.minTemp ==
              result
                  .map(
                    (e) => e.minTemp!.toDouble(),
                  )
                  .min
                  .round()));
      return result;
    }).onError((error, stackTrace) => throw error!);
  }
}

class GetForecastParams extends Equatable {
  final String location;

  const GetForecastParams(this.location);

  @override
  List<Object?> get props => [location];
}
