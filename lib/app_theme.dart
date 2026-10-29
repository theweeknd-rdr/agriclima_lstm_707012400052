import 'package:flutter/material.dart';

// Tema aplikasi: terang (lightTheme) dan gelap (darkTheme).
class AppTheme {
  static const Color _warnaSeed = Color(0xFF2E7D32);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _warnaSeed,
        brightness: Brightness.light,
      ),
      appBarTheme: const AppBarTheme(centerTitle: false),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _warnaSeed,
        brightness: Brightness.dark,
      ),
      appBarTheme: const AppBarTheme(centerTitle: false),
    );
  }
}
