import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(
    this._secureStorage,
  );

  final FlutterSecureStorage _secureStorage;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final authToken = await _secureStorage.read(key: 'authToken');
    options.headers.addAll({
      'Authorization': 'Bearer $authToken',
    });
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 403) {
      // await _authenticationRepository.logout();
      await _secureStorage.delete(key: 'authToken');
      return;
    }
    super.onError(err, handler);
  }
}
