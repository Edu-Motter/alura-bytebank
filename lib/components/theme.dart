import 'package:flutter/material.dart';

final bytebankTheme = ThemeData(
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
      buttonColor: Colors.blueAccent[700], textTheme: ButtonTextTheme.primary),
);
