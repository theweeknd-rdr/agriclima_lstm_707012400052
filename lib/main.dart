import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_routes.dart';
import 'app_theme.dart';
import 'pages/halaman_input_prediksi.dart';
import 'pages/halaman_tentang.dart';
import 'state/kerangka_navigasi.dart';
import 'state/prediksi_model.dart';
import 'state/tema_model.dart';
import 'pages/halaman_pengaturan.dart';

void main() {
  runApp(
    // Pengelola state dipasang di atas MaterialApp
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PrediksiModel()),
        ChangeNotifierProvider(create: (context) => TemaModel()),
      ],
      child: const AgriClimaApp(),
    ),
  );
}

class AgriClimaApp extends StatelessWidget {
  const AgriClimaApp({super.key});

  @override
  Widget build(BuildContext context) {
    final tema = context.watch<TemaModel>();

    return MaterialApp(
      title: 'AgriClima',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: tema.themeMode,
      initialRoute: AppRoutes.beranda,
      routes: {
        AppRoutes.beranda: (context) => const KerangkaNavigasi(),
        AppRoutes.tentang: (context) => const HalamanTentang(),
        AppRoutes.inputPrediksi: (context) => const HalamanInputPrediksi(),
        AppRoutes.pengaturan: (context) => const HalamanPengaturan(),
      },
    );
  }
}
