import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast/Core/helpers.dart';
import 'package:weather_forecast/app_constants.dart';
import 'package:weather_forecast/state_management/bloc/details_screen_bloc.dart';
import 'package:weather_forecast/state_management/event/forecast_event.dart';
import 'package:weather_forecast/state_management/state/details_state.dart';
import 'package:weather_icons/weather_icons.dart';

import '../Domain/entities/weather.dart';
import '../state_management/bloc/app_bloc.dart';
import '../state_management/bloc/forecast_bloc.dart';

class WeatherScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WeatherScreenState();
}

class WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<DetailsBloc, DetailsState>(
            builder: ((context, state) {
              if (state is DetailsLoadedState) {
                return Center(
                  child: Text(state.data.location),
                );
              }
              return const Center(
                child: Text("..."),
              );
            }),
          ),
          actions: [
            IconButton(
                onPressed: () => _onPressed(context),
                icon: const Icon(Icons.sort_outlined))
          ],
        ),
        body: Center(
          child: BlocListener<DetailsBloc, DetailsState>(
            listener: ((context, state) {
              if (state is DetailsErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Error fetching data."),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                ));
              }
            }),
            child: BlocBuilder<DetailsBloc, DetailsState>(
              builder: ((context, state) {
                if (state is DetailsEmptyState) {
                  return _buildEmptyScreen();
                }
                if (state is DetailsDataLoadingState) {
                  return _buildLoadingScreen();
                }
                if (state is DetailsErrorState) {
                  return _buildErrorScreen();
                }
                if (state is DetailsLoadedState) {
                  return _buildLoadedScreen(state);
                }
                return _buildEmptyScreen();
              }),
            ),
          ),
        ),
      ),
    );
  }

  void _onPressed(BuildContext context) {
    Navigator.pushNamed(context, AppConstants.WEATHER_GRAPH_ROUTE);
    context
        .read<ForecastBloc>()
        .add(ForecastEventStartLoad(context.read<AppBloc>().state.location!));
  }

  Widget _buildEmptyScreen() {
    return Container();
  }

  Widget _buildLoadingScreen() {
    return const CircularProgressIndicator();
  }

  Widget _buildErrorScreen() {
    return Container(
      child: Text("Error fetching data."),
    );
  }

  Widget _buildLoadedScreen(DetailsLoadedState state) {
    Weather data = state.data;
    return Column(
      children: [
        Card(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    TemperatureHelper.getTemperature(data.temperature),
                    style: const TextStyle(fontSize: 24.0),
                  ),
                  Image.network(data.condition.iconUri),
                ],
              ),
              Text("${data.condition.name}: ${data.condition.description}"),
              _getTile(WindIcon(degree: data.windDegree),
                  "${data.wind.round().toString()} m/s"),
              _getTile(const BoxedIcon(WeatherIcons.barometer),
                  "${data.pressure} hPa"),
              _getTile(
                  const BoxedIcon(WeatherIcons.raindrop), "${data.humidity}%"),
            ],
          ),
        ),
        Spacer(
          flex: 3,
        ),
      ],
    );
  }

  Widget _getTile(BoxedIcon icon, String text) {
    return SizedBox(
      width: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          Text(text),
        ],
      ),
    );
  }
}
