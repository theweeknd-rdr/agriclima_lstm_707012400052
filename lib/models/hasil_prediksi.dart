import 'package:flutter/material.dart';

// Model data hasil prediksi LTSM.
// Logika status dan rekomendasi ditulis di sini (bukan di build()).
class HasilPrediksi {
  // Daftar pilihan (dipakai di form input)
  static const List<String> daftarPetak = ['Petak 1', 'Petak 2'];
  static const List<String> daftarTanaman = ['Padi', 'Jagung', 'Cabai'];

  // Nama status mikroklimat
  static const String statusKering = 'Kering';
  static const String statusOptimal = 'Optimal';
  static const String statusTerlaluLembap = 'Terlalu Lembap';

  final String petak;
  final String tanaman;
  final double suhuUdara;
  final double kelembapanUdara;
  final double kelembapanTanah;
  final String namaPetugas;
  final DateTime waktu;

  HasilPrediksi({
    required this.petak,
    required this.tanaman,
    required this.suhuUdara,
    required this.kelembapanUdara,
    required this.kelembapanTanah,
    required this.namaPetugas,
    required this.waktu,
  });

  // Tabel A: status ditentukan dari prediksi kelembapan tanah
  String get status {
    if (kelembapanTanah < 40) {
      return statusKering;
    } else if (kelembapanTanah <= 70) {
      return statusOptimal;
    } else {
      return statusTerlaluLembap;
    }
  }

  // Tabel A: rekomendasi sesuai status
  String get rekomendasi {
    if (status == statusKering) {
      return 'Segera lakukan penyiraman atau irigasi';
    } else if (status == statusOptimal) {
      return 'Pertahankan pola perawatan saat ini';
    } else {
      return 'Kurangi penyiraman dan periksa drainase';
    }
  }

  // Tabel B: catatan perawatan per tanaman
  String get catatanPerawatan {
    switch (tanaman) {
      case 'Padi':
        return 'Jaga genangan air 2-5 cm pada fase vegetatif dan keringkan lahan menjelang panen';
      case 'Jagung':
        return 'Siram saat tanah mulai kering dan hindari genangan di sekitar perakaran';
      case 'Cabai':
        return 'Gunakan mulsa untuk menjaga kelembapan tanah dan siram pada pagi atau sore hari';
      default:
        return '-';
    }
  }

  // Warna dan ikon sesuai status
  Color get warna => warnaStatus(status);
  IconData get ikon => ikonStatus(status);

  static Color warnaStatus(String status) {
    switch (status) {
      case statusKering:
        return Colors.orange.shade800;
      case statusOptimal:
        return Colors.green.shade700;
      default:
        return Colors.blue.shade700;
    }
  }

  static IconData ikonStatus(String status) {
    switch (status) {
      case statusKering:
        return Icons.wb_sunny;
      case statusOptimal:
        return Icons.check_circle;
      default:
        return Icons.water_drop;
    }
  }

  // Waktu prediksi dalam format dd/MM/yyyy HH:mm
  String get waktuTeks {
    String duaDigit(int angka) => angka.toString().padLeft(2, '0');
    return '${duaDigit(waktu.day)}/${duaDigit(waktu.month)}/${waktu.year} '
        '${duaDigit(waktu.hour)}:${duaDigit(waktu.minute)}';
  }

  // Tampilkan angka bulat tanpa koma (25.0 jadi 25)
  static String formatAngka(double angka) {
    if (angka == angka.roundToDouble()) {
      return angka.toStringAsFixed(0);
    }
    return angka.toStringAsFixed(1);
  }
}
