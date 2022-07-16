import 'dart:async';

import 'package:bytebank/components/localization/localization_container.dart';
import 'package:bytebank/components/theme.dart';
import 'package:bytebank/screens/dashboard/dashboard_container.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    debugPrint('${bloc.runtimeType} > $change');
    super.onChange(bloc, change);
  }
}

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LocalizationContainer(
        child: DashboardContainer(),
      ),
      debugShowCheckedModeBanner: false,
      theme: bytebankTheme,
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _firebaseInitialize();

  BlocOverrides.runZoned(
      () => {
            runZonedGuarded<Future<void>>(() async {
              runApp(const BytebankApp());
            }, FirebaseCrashlytics.instance.recordError)
          },
      blocObserver: LogObserver());
}

Future<void> _firebaseInitialize() async {
  await Firebase.initializeApp();

  if (kDebugMode) {
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  } else {
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    FirebaseCrashlytics.instance.setUserIdentifier('alura-123');
  }
}
