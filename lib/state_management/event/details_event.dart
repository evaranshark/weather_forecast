abstract class DetailsEvent {}

class DetailsLoadEvent extends DetailsEvent {
  String location;
  DetailsLoadEvent({required this.location});
}
