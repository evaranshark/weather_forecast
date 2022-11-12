import '../../Domain/entities/weather.dart';

abstract class DetailsState {}

class DetailsEmptyState extends DetailsState {}

class DetailsDataLoadingState extends DetailsState {}

class DetailsLoadedState extends DetailsState {
  Weather data;
  DetailsLoadedState({required this.data});
}

class DetailsErrorState extends DetailsState {}
