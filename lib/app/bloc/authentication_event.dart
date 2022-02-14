import 'package:equatable/equatable.dart';
import 'package:quiz_app/infrastructure/authentication_repository.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationCheck extends AuthenticationEvent {}

class AuthenticationStatusChanged extends AuthenticationEvent {
  AuthenticationStatusChanged(
    this.status,
  );

  final AuthenticationStatus status;

  @override
  List<Object> get props => [
        status,
      ];
}

class AuthenticationGuestCheck extends AuthenticationEvent {}

class AuthenticationLogoutRequested extends AuthenticationEvent {}
