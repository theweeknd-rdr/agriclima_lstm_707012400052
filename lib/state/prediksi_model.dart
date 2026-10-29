import 'package:flutter/material.dart';

import '../models/hasil_prediksi.dart';

// Pengelola state (Provider): menyimpan riwayat prediksi mikroklimat.
class PrediksiModel extends ChangeNotifier {
  final List<HasilPrediksi> _daftarPrediksi = [];
  String _filterPetak = 'Semua';

  List<HasilPrediksi> get daftarPrediksi => _daftarPrediksi;
  String get filterPetak => _filterPetak;

  // Daftar yang tampil di tab Prediksi (sudah difilter per petak)
  List<HasilPrediksi> get daftarTampil {
    if (_filterPetak == 'Semua') {
      return _daftarPrediksi;
    }
    return _daftarPrediksi.where((data) => data.petak == _filterPetak).toList();
  }

  // Statistik (dihitung dari seluruh data)
  int get total => _daftarPrediksi.length;

  int get jumlahKering => _hitungStatus(HasilPrediksi.statusKering);
  int get jumlahOptimal => _hitungStatus(HasilPrediksi.statusOptimal);
  int get jumlahTerlaluLembap => _hitungStatus(HasilPrediksi.statusTerlaluLembap);

  // Perlu tindakan = kering + terlalu lembap
  int get jumlahPerluTindakan => jumlahKering + jumlahTerlaluLembap;

  int _hitungStatus(String status) {
    return _daftarPrediksi.where((data) => data.status == status).length;
  }

  // Tambah data (data terbaru di paling atas)
  void tambahData(HasilPrediksi data) {
    _daftarPrediksi.insert(0, data);
    notifyListeners();
  }

  // Hapus data
  void hapusData(HasilPrediksi data) {
    _daftarPrediksi.remove(data);
    notifyListeners();
  }

  // Ubah data
  void ubahData(HasilPrediksi lama, HasilPrediksi baru) {
    final index = _daftarPrediksi.indexOf(lama);
    if (index != -1) {
      _daftarPrediksi[index] = baru;
      notifyListeners();
    }
  }

  // Filter petak: 'Semua', 'Petak 1', atau 'Petak 2'
  void setFilterPetak(String petak) {
    _filterPetak = petak;
    notifyListeners();
  }
}
