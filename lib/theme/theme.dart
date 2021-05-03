import 'package:flutter/material.dart';

final lightTheme = ThemeData.light().copyWith(
  primaryColor: Colors.blueAccent,
  primaryColorLight: Colors.blueAccent,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  appBarTheme: AppBarTheme(
    color: Colors.blue,
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.red,
    focusColor: Colors.blueAccent,
    suffixStyle: TextStyle(
      color: Colors.blueAccent,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
  ),
);

final darkTheme = ThemeData.dark().copyWith(
    //primaryColor: Colors.yellow,
    //visualDensity: VisualDensity.adaptivePlatformDensity,
    //appBarTheme: AppBarTheme(
    //  color: Colors.red,
    //),
    );
