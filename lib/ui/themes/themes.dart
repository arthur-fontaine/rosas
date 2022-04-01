import 'package:flutter/material.dart';
import 'themes_barrel.dart';

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
