// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:quiz_app/app/bloc/authentication_bloc.dart';
import 'package:quiz_app/app/bloc/authentication_state.dart';
import 'package:quiz_app/infrastructure/authentication_repository.dart';
import 'package:quiz_app/injection_container.dart';
import 'package:quiz_app/presentation/authentication/sign_in.dart';
import 'package:quiz_app/presentation/dashboard/admin/admin_dashboard.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState? get _navigator => _navigatorKey.currentState;
  // bool isLoading = false;

  @override
  void initState() {
    getIt<FlutterSecureStorage>().delete(key: 'authToken');
    // _guestCheck(context);
    super.initState();
  }

  // void _guestCheck(BuildContext context) async {
  //   final guest = await getIt<FlutterSecureStorage>().read(key: 'guest_login');
  //   if (guest != null && guest.isNotEmpty) {
  //     guestCheck = guest;
  //     return;
  //   }
  //   final user = await getIt<FlutterSecureStorage>().read(key: 'authToken');
  //   if (user != null && user.isNotEmpty) {
  //     await getIt<AuthenticationRepository>().me();
  //   }
  //   return;
  // }

  @override
  void dispose() {
    context.read<AuthenticationBloc>().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthenticationBloc>(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          accentColor: const Color(0xFF13B9FF),
          appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
          fontFamily: 'Poppins',
        ),
        navigatorKey: _navigatorKey,
        builder: (context, child) {
          return BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              switch (state.status) {
                case AuthenticationStatus.authenticated:
                  _navigator?.pushAndRemoveUntil<void>(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const AdminDashboard(),
                    ),
                    (route) => false,
                  );
                  break;
                case AuthenticationStatus.unauthenticated:
                  _navigator?.pushAndRemoveUntil<void>(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const Signin(),
                    ),
                    (route) => false,
                  );
                  break;
                default:
                  break;
              }
            },
            child: child,
          );
        },
        onGenerateRoute: (_) => MaterialPageRoute<void>(
          builder: (_) => const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
