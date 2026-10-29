import 'package:flutter/material.dart';

class HalamanTentang extends StatelessWidget {
  const HalamanTentang({super.key});

  Widget _judul(String teks) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 4),
      child: Text(
        teks,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tentang AgriClima')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _judul('Tujuan Aplikasi'),
          const Text(
            'AgriClima LTSM membantu petugas memantau dan memprediksi kondisi '
            'mikroklimat lahan pertanian 24 jam ke depan, sehingga penyiraman '
            'dan perawatan tanaman dapat dilakukan tepat waktu.',
          ),

          _judul('Lokasi Pemantauan'),
          const ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Petak 1'),
          ),
          const ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Petak 2'),
          ),

          _judul('Parameter Mikroklimat'),
          const ListTile(
            leading: Icon(Icons.thermostat),
            title: Text('Suhu udara'),
          ),
          const ListTile(
            leading: Icon(Icons.cloud),
            title: Text('Kelembapan udara'),
          ),
          const ListTile(
            leading: Icon(Icons.water_drop),
            title: Text('Kelembapan tanah'),
          ),
        ],
      ),
    );
  }
}
