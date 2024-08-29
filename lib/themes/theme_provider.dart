import 'package:eco_app/themes/dark_mode.dart';
import 'package:eco_app/themes/light_mode.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  // ignore: prefer_final_fields
  ThemeData _lightMode = lightMode;
  ThemeData get light => _lightMode;

  bool get isDarkMode => _lightMode == darkMode;

  set light(ThemeData light) {
    _lightMode = light;
    notifyListeners();
  }

  void toogleTheme() {
    if (_lightMode == lightMode) {
      light = darkMode;
    } else {
      light = lightMode;
    }
  }
}
