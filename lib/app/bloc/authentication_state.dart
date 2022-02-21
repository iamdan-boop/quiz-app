import 'package:equatable/equatable.dart';
import 'package:quiz_app/infrastructure/authentication_repository.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState({
    this.status = AuthenticationStatus.unknown,
    this.isAdmin = false,
  });

  const AuthenticationState.unknown() : this();

  const AuthenticationState.authenticated(bool isAdmin)
      : this(
          status: AuthenticationStatus.authenticated,
          isAdmin: isAdmin,
        );

  const AuthenticationState.unauthenticated()
      : this(
          status: AuthenticationStatus.unauthenticated,
        );

  const AuthenticationState.badRequest()
      : this(
          status: AuthenticationStatus.badRequest,
        );

  const AuthenticationState.isLoggedIn()
      : this(status: AuthenticationStatus.isLoggedIn);

  final AuthenticationStatus status;
  final bool isAdmin;

  AuthenticationState copyWith({
    AuthenticationStatus? status,
    bool? isAdmin,
  }) {
    return AuthenticationState(
      isAdmin: isAdmin ?? this.isAdmin,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status, isAdmin];
}
