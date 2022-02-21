// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:developer';

// import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quiz_app/app/app.dart';
import 'package:quiz_app/app/app_bloc_observer.dart';
import 'package:quiz_app/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  setup();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  HydratedBlocOverrides.runZoned(
    () => runApp(const App()),
    storage: storage,
    blocObserver: AppBlocObserver(),
  );
}
