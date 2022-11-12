import 'package:equatable/equatable.dart';

class InitialScreenState extends Equatable {
  final String textFieldValue;

  const InitialScreenState(this.textFieldValue);

  InitialScreenState copyWith({required String textFieldValue}) {
    return InitialScreenState(textFieldValue);
  }

  @override
  get props => [textFieldValue];
}
