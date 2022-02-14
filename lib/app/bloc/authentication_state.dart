import 'package:equatable/equatable.dart';
import 'package:quiz_app/infrastructure/authentication_repository.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState({
    this.status = AuthenticationStatus.unknown,
  });

  const AuthenticationState.unknown() : this();

  const AuthenticationState.authenticated()
      : this(
          status: AuthenticationStatus.authenticated,
        );

  const AuthenticationState.unauthenticated()
      : this(
          status: AuthenticationStatus.unauthenticated,
        );

  const AuthenticationState.badRequest()
      : this(
          status: AuthenticationStatus.badRequest,
        );

  final AuthenticationStatus status;

  AuthenticationState copyWith({
    AuthenticationStatus? status,
  }) {
    return AuthenticationState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
