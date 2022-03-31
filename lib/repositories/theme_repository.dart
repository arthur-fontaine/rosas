import 'package:flutter/material.dart';
import 'package:rosas/themes/themes_barrel.dart';

class ThemeRepository {
  ThemeData _themeData = rosasDefaultTheme;

  ThemeRepository();

  ThemeData getThemeData() => _themeData;

  void setThemeData(ThemeData themeData) => _themeData = themeData;
}
