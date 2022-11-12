import '../../Domain/entities/location.dart';

abstract class AppEvent {}

class AppEventUpdateLocation extends AppEvent {
  final Location location;

  AppEventUpdateLocation({required this.location});
}
