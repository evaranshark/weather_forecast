abstract class InitialScreenEvent {}

class InitialScreenFieldValueChangedEvent extends InitialScreenEvent {
  String? value;
  InitialScreenFieldValueChangedEvent({this.value});
}

class InitialScreenItemPicked extends InitialScreenEvent {}
