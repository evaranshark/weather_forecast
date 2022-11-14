import '../../Domain/entities/location.dart';

//Thie state provides location data through the app via BlocProvider
class AppState {
  Location? location;
  AppState({this.location});

  AppState copyWith({Location? location}) => AppState(location: location);
}
