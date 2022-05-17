import 'dart:async';

import 'package:bytebank/screens/dashboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  if(kDebugMode){
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  } else {
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    FirebaseCrashlytics.instance.setUserIdentifier('alura-123');
  }

  runZonedGuarded<Future<void>>(() async {
    runApp(const BytebankApp());
  }, FirebaseCrashlytics.instance.recordError);
}

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Dashboard(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.green,
        ).copyWith(
          secondary: Colors.blueAccent[700],
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blueAccent[700]),
          ),
        ),
        buttonTheme: ButtonThemeData(
            buttonColor: Colors.blueAccent[700],
            textTheme: ButtonTextTheme.primary),
      ),
    );
  }
}
