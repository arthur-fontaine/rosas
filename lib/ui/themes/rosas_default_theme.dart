import 'package:flutter/material.dart';

final rosasDefaultTheme = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color.fromRGBO(251, 245, 243, 1),
    secondary: Color.fromRGBO(218, 0, 55, 1),
    background: Color.fromRGBO(251, 245, 243, 1),
    surface: Color.fromRGBO(251, 245, 243, 1),
    error: Color.fromRGBO(218, 0, 55, 1),
    onPrimary: Color.fromRGBO(0, 0, 34, 1),
    onSecondary: Color.fromRGBO(255, 255, 255, 1),
    onBackground: Color.fromRGBO(0, 0, 34, 1),
    onSurface: Color.fromRGBO(0, 0, 34, 1),
    onError: Color.fromRGBO(255, 255, 255, 1),
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontFamily: 'Archivo',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
      fontSize: 22,
      height: 1,
    ),
    headline2: TextStyle(
      fontFamily: 'Archivo',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
      fontSize: 18,
      height: 1.3,
    ),
    bodyText1: TextStyle(
      fontFamily: 'Archivo',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontSize: 16,
      height: 1.3,
    ),
    caption: TextStyle(
      fontFamily: 'Archivo',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w100,
      fontSize: 14,
      height: 1.3,
    ),
    labelMedium: TextStyle(
      fontFamily: 'Archivo',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 12,
      height: 1,
    ),
  )
);
