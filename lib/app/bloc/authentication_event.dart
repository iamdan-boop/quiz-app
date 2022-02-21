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
    this.isAdmin,
  );

  final AuthenticationStatus status;
  final bool isAdmin;

  @override
  List<Object> get props => [
        status,
        isAdmin,
      ];
}

class AuthenticationGuestCheck extends AuthenticationEvent {}

class AuthenticationLogoutRequested extends AuthenticationEvent {}
