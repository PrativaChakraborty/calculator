import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Mytheme with ChangeNotifier {
  static bool _isDark = false;
  ThemeMode getThemeMode() => _isDark ? ThemeMode.dark : ThemeMode.light;
  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}
