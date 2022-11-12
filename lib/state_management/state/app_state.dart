import '../../Domain/entities/location.dart';

class AppState {
  Location? location;
  AppState({this.location});

  AppState copyWith({Location? location}) => AppState(location: location);
}
