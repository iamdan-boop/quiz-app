// ignore_for_file: cascade_invocations

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:quiz_app/app/bloc/authentication_bloc.dart';
import 'package:quiz_app/infrastructure/api.dart';
import 'package:quiz_app/infrastructure/authentication_repository.dart';
import 'package:quiz_app/infrastructure/interceptors/auth_interceptor.dart';
import 'package:quiz_app/presentation/authentication/bloc/login/login_bloc.dart';
import 'package:quiz_app/presentation/authentication/bloc/register/register_bloc.dart';
import 'package:quiz_app/presentation/dashboard/admin/leaderboards/cubit/leaderboards_cubit.dart';
import 'package:quiz_app/presentation/dashboard/admin/quiz/bloc/create/create_quiz_bloc.dart';
import 'package:quiz_app/presentation/dashboard/admin/quiz/bloc/quiz_bloc.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<FlutterSecureStorage>(
    const FlutterSecureStorage(),
  );

  getIt.registerSingleton<Dio>(
    Dio()
      ..interceptors.addAll([
        // JsonHeaderInterceptor(getIt()),
        AuthInterceptor(getIt()),
        LogInterceptor(requestBody: true, responseBody: true),
      ]),
  );

  getIt.registerSingleton<QuizApi>(QuizApi(getIt()));

  getIt.registerSingleton<AuthenticationRepository>(
    AuthenticationRepository(getIt(), getIt()),
  );

  getIt.registerLazySingleton<AuthenticationBloc>(
    () => AuthenticationBloc(
      authenticationRepository: getIt(),
      // flutterSecureStorage: getIt(),
    ),
  );

  getIt.registerFactory<LoginBloc>(() => LoginBloc(getIt()));

  getIt.registerFactory<RegisterBloc>(
      () => RegisterBloc(authenticationRepository: getIt()));

  getIt.registerFactory<QuizBloc>(() => QuizBloc(quizApi: getIt()));

  getIt.registerFactory<CreateQuizBloc>(() => CreateQuizBloc(quizApi: getIt()));

  getIt.registerFactory<LeaderboardsCubit>(
      () => LeaderboardsCubit(quizApi: getIt()));
}
