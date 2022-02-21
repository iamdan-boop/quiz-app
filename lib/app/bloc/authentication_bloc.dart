import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/app/bloc/authentication_event.dart';
import 'package:quiz_app/app/bloc/authentication_state.dart';
import 'package:quiz_app/infrastructure/authentication_repository.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationCheck>(_authCheck);
    on<AuthenticationLogoutRequested>(
      (event, emit) => _authenticationRepository.logout(),
    );
    on<AuthenticationStatusChanged>(_mapAuthenticationStatusChangedToState);
    _authenticationStatusSubscription =
        _authenticationRepository.status.listen((status) {
      add(
        AuthenticationStatusChanged(
          status.authenticationStatus,
          status.isAdmin,
        ),
      );
    });
  }

  Future<void> _authCheck(
    AuthenticationCheck event,
    Emitter<AuthenticationState> emit,
  ) async {
    return await _authenticationRepository.me();
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription?.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  final AuthenticationRepository _authenticationRepository;
  StreamSubscription<AuthenticationStatusState>?
      _authenticationStatusSubscription;

  Future<void> _mapAuthenticationStatusChangedToState(
    AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(
          state.copyWith(
            status: AuthenticationStatus.unauthenticated,
          ),
        );
      case AuthenticationStatus.authenticated:
        return emit(
          state.copyWith(
            status: AuthenticationStatus.authenticated,
            isAdmin: event.isAdmin,
          ),
        );
      // ignore: no_default_cases
      default:
        return emit(const AuthenticationState.unknown());
    }
  }
}
