import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quiz_app/infrastructure/api.dart';
import 'package:quiz_app/infrastructure/models/auth_token.dart';

enum AuthenticationStatus {
  unknown,
  authenticated,
  unauthenticated,
  badRequest,
  invalid,
  isLoggedIn,
}

class AuthenticationStatusState extends Equatable {
  const AuthenticationStatusState(this.authenticationStatus, this.isAdmin);

  final AuthenticationStatus authenticationStatus;
  final bool isAdmin;

  @override
  List<Object?> get props => [authenticationStatus, isAdmin];
}

class AuthenticationRepository {
  AuthenticationRepository(this._client, this._secureStorage);

  final QuizApi _client;
  final FlutterSecureStorage _secureStorage;

  final _controller = StreamController<AuthenticationStatusState>();

  Stream<AuthenticationStatusState> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield const AuthenticationStatusState(
      AuthenticationStatus.isLoggedIn,
      false,
    );
    yield* _controller.stream;
  }

  Future<void> me() async {
    try {
      final token = await _client.me();
      await _secureStorage.write(key: 'authToken', value: token.authToken);
      return _controller.add(
        AuthenticationStatusState(
          AuthenticationStatus.authenticated,
          token.isAdmin,
        ),
      );
    } on DioError catch (_) {
      return _controller.add(
        const AuthenticationStatusState(
          AuthenticationStatus.unauthenticated,
          false,
        ),
      );
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      final token = await _client.login(email: email, password: password);
      await saveToken(token);

      return _controller.add(
        AuthenticationStatusState(
          AuthenticationStatus.authenticated,
          token.isAdmin,
        ),
      );
    } on DioError catch (e) {
      handleError(e);
      rethrow;
    }
  }

  Future<void> logout() async {
    await _secureStorage.delete(key: 'authToken');
    return _controller.add(
      const AuthenticationStatusState(
        AuthenticationStatus.unauthenticated,
        false,
      ),
    );
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final token = await _client.register(
        name: name,
        email: email,
        password: password,
      );
      await saveToken(token);
      return _controller.add(
        AuthenticationStatusState(
          AuthenticationStatus.authenticated,
          token.isAdmin,
        ),
      );
    } on DioError catch (e) {
      handleError(e);
      rethrow;
    }
  }

  void handleError(DioError e) {
    final responseCode = e.response?.statusCode;
    if (responseCode == 403) {
      return _controller.add(
        const AuthenticationStatusState(
          AuthenticationStatus.invalid,
          false,
        ),
      );
    }
    if (responseCode == 400) {
      return _controller.add(
        const AuthenticationStatusState(
          AuthenticationStatus.badRequest,
          false,
        ),
      );
    }
    if (responseCode == 500) {
      return _controller.add(
        const AuthenticationStatusState(
          AuthenticationStatus.unknown,
          false,
        ),
      );
    }
    return _controller.add(
      const AuthenticationStatusState(
        AuthenticationStatus.unauthenticated,
        false,
      ),
    );
  }

  Future<void> saveToken(AuthToken token) async {
    await Future.wait([
      _secureStorage.write(key: 'authToken', value: token.authToken),
      _secureStorage.write(key: 'user', value: token.name),
    ]);
    return;
  }

  void dispose() => _controller.close();
}
