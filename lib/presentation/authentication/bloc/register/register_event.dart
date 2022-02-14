import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {}

class RegisterNameChanged extends RegisterEvent {
  RegisterNameChanged({required this.name});

  final String name;

  @override
  List<Object?> get props => [name];
}

class RegisterEmailChanged extends RegisterEvent {
  RegisterEmailChanged({required this.email});

  final String email;

  @override
  List<Object?> get props => [email];
}

class RegisterPasswordChanged extends RegisterEvent {
  RegisterPasswordChanged({required this.password});

  final String password;

  @override
  List<Object?> get props => [password];
}

class RegisterSubmitted extends RegisterEvent {
  @override
  List<Object?> get props => [];
}
