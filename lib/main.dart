import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast/app_constants.dart';
import 'package:weather_forecast/base_configuration.dart';
import 'package:weather_forecast/presentation/weather_screen.dart';
import 'package:weather_forecast/presentation/initial_screen.dart';
import 'package:weather_forecast/presentation/forecast_screen.dart';

void main() {
  BaseConfiguration configuration = BaseConfiguration.getConfiguration();
  runApp(MyApp(configuration: configuration));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.configuration});
  final BaseConfiguration configuration;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: configuration.providers,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
          //useMaterial3: true,
        ),
        home: InitialScreen(),
        routes: {
          AppConstants.WEATHER_DETAILS_ROUTE: (context) => WeatherScreen(),
          AppConstants.WEATHER_GRAPH_ROUTE: (context) => ForecastScreen(),
        },
      ),
    );
  }
}
