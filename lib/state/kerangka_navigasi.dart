import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'prediksi_model.dart';
import '../pages/halaman_beranda.dart';
import '../pages/halaman_pengaturan.dart';
import '../pages/halaman_prediksi.dart';
import '../pages/halaman_statistik.dart';

// Kerangka utama: AppBar + isi tab (IndexedStack) + NavigationBar.
class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

  @override
  State<KerangkaNavigasi> createState() => _KerangkaNavigasiState();
}

class _KerangkaNavigasiState extends State<KerangkaNavigasi> {
  int _indexAktif = 0;

  final List<String> _namaTab = ['Beranda', 'Prediksi', 'Statistik', 'Pengaturan'];

  final List<Widget> _halaman = const [
    HalamanBeranda(),
    HalamanPrediksi(),
    HalamanStatistik(),
    HalamanPengaturan(),
  ];

  // Ikon tab Prediksi dengan badge jumlah data yang perlu tindakan
  Widget _ikonPrediksi(bool terpilih) {
    return Consumer<PrediksiModel>(
      builder: (context, model, child) {
        return Badge(
          isLabelVisible: model.jumlahPerluTindakan > 0,
          label: Text('${model.jumlahPerluTindakan}'),
          child: Icon(terpilih ? Icons.insights : Icons.insights_outlined),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AgriClima - ${_namaTab[_indexAktif]}'),
      ),
      // IndexedStack menjaga isi tab tetap ada saat berpindah
      body: IndexedStack(
        index: _indexAktif,
        children: _halaman,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indexAktif,
        onDestinationSelected: (index) {
          setState(() {
            _indexAktif = index;
          });
        },
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: _ikonPrediksi(false),
            selectedIcon: _ikonPrediksi(true),
            label: 'Prediksi',
          ),
          const NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: 'Statistik',
          ),
          const NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
      ),
    );
  }
}
