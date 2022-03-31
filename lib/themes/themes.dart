import 'package:flutter/material.dart';
import 'package:rosas/themes/themes_barrel.dart';

enum Themes { rosasDefault }

extension ThemesX on Themes {
  ThemeData get theme {
    switch (this) {
      case Themes.rosasDefault:
        return rosasDefaultTheme;
      default:
        return rosasDefaultTheme;
    }
  }
}
