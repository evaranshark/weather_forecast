import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_forecast/Core/helpers.dart';
import 'package:weather_forecast/state_management/bloc/forecast_bloc.dart';
import 'package:weather_forecast/state_management/state/forecast_state.dart';

import '../Domain/entities/weather.dart';

class ForecastScreen extends StatelessWidget {
  const ForecastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: BlocBuilder<ForecastBloc, ForecastState>(
              builder: ((context, state) {
            if (state is ForecastStateLoaded) {
              return Text(state.location.name);
            }
            return const Text("...");
          })),
        ),
      ),
      body: Center(
        child: BlocListener<ForecastBloc, ForecastState>(
          listener: (context, state) {
            if (state is ForecastStateError) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Error fetching data."),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
              ));
            }
          },
          child: BlocBuilder<ForecastBloc, ForecastState>(
            builder: (context, state) {
              if (state is ForecastStateLoading) {
                return _buildLoadingScreen();
              }
              if (state is ForecastStateError) {
                return _buildErrorScreen();
              }
              if (state is ForecastStateLoaded) {
                return _buildLoadedScreen(state);
              }
              return _buildEmptyScreen();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyScreen() {
    return Container();
  }

  Widget _buildErrorScreen() {
    return const Text("Error fetching data.");
  }

  Widget _buildLoadingScreen() {
    return const CircularProgressIndicator();
  }

  Widget _buildLoadedScreen(ForecastStateLoaded state) {
    List<Weather> data = state.data;
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: ((context, index) {
          Weather item = data[index];
          return Card(
            color: (index == 0) ? Colors.blueGrey : null,
            child: _buildTile(item, title: index != 0 ? null : "Coldest day"),
          );
        }));
  }

  //TODO create separate widget
  Widget _buildTile(Weather weather, {String? title}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 88,
        child: Column(
          children: [
            Expanded(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (title != null)
                                  Text(
                                    title,
                                    style: const TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                Text(DateFormat("d MMMM").format(weather.date)),
                                Text(DateHelper.weekday[weather.date.weekday]),
                              ]),
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 80,
                      child: Card(
                        color: Colors.lightBlue,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            weather.condition.iconUri,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 70,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Min"),
                              Text(TemperatureHelper.getTemperature(
                                  weather.minTemp!)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 70,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Max"),
                              Text(TemperatureHelper.getTemperature(
                                  weather.maxTemp!)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
