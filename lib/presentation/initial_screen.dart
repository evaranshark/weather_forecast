import 'package:flutter/material.dart';
import 'package:weather_forecast/app_constants.dart';
import 'package:weather_forecast/state_management/bloc/details_screen_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast/state_management/event/app_event.dart';

import '../Domain/entities/location.dart';
import '../state_management/bloc/app_bloc.dart';
import '../state_management/event/details_event.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<StatefulWidget> createState() => InitialScreenWidgetState();
}

class InitialScreenWidgetState extends State<InitialScreen> {
  final TextEditingController _cityTextController = TextEditingController();
  bool _isSubmitEnabled = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather Forecast"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: _cityTextController,
                onChanged: (value) => setState(() {
                  _isSubmitEnabled = value.isNotEmpty;
                }),
                onSubmitted: (value) => _onSubmitPressed(context),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      _cityTextController.clear();
                      setState(() {
                        _isSubmitEnabled = false;
                      });
                    },
                    icon: const Icon(Icons.clear_outlined),
                  ),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              ElevatedButton(
                onPressed: _isSubmitEnabled
                    ? () {
                        _onSubmitPressed(context);
                      }
                    : null,
                child: const Text(
                  "Submit",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _onSubmitPressed(BuildContext context) {
    context.read<AppBloc>().add(AppEventUpdateLocation(
            location: Location(
          name: _cityTextController.text,
        )));
    Navigator.pushNamed(context, AppConstants.WEATHER_DETAILS_ROUTE);
    context
        .read<DetailsBloc>()
        .add(DetailsLoadEvent(location: _cityTextController.text));
  }
}
