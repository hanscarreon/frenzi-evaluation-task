import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:frenzi_app/frenzi_app.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
      (_) {
        runApp(const FrenziApp());
      },
    );
  }, (error, stack) {});

  FlutterError.onError = (FlutterErrorDetails details) async {
    final dynamic exception = details.exception;
    final StackTrace stackTrace = details.stack ?? StackTrace.current;
    Zone.current.handleUncaughtError(exception, stackTrace);
  };
}
