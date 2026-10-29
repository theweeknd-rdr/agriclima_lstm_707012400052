import 'package:flutter/material.dart';

// Pengelola state (Provider) untuk themeMode: terang atau gelap.
class TemaModel extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  bool get modeGelap => _themeMode == ThemeMode.dark;

  // Dipanggil oleh Switch "Mode Gelap"
  void gantiMode(bool gelap) {
    _themeMode = gelap ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
